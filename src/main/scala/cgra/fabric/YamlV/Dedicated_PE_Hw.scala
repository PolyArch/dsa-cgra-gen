package cgra.fabric.YamlV

import cgra.IO.ReqAckConf_if
import cgra.IR.{dedicated_pe, port_subnet, subnet_connection}
import cgra.config.encoding.{config_module_id_high, config_module_id_low}
import cgra.config.{instruction_prop, system}
import chisel3._
import chisel3.util._

import scala.collection.mutable.ListBuffer
import cgra.config.fullinst._

import scala.math.ceil

class Dedicated_PE_Hw(name_p:(String,dedicated_pe)) extends Module with Has_IO
  with Decomposable{

  // Extract Parameter
  private val module_name = name_p._1
  private val p = name_p._2
  private val num_input = p.getInput_ports.length
  private val num_output = p.getOutput_ports.length
  private val decomposer = p.decomposer
  private val input_ports = p.input_ports
  private val output_ports = p.output_ports
  private val data_word_width = system.data_word_width
  private val config_input_port = p.config_input_port
  private val config_output_port = p.config_output_port
  private val instructions = p.instructions

  // ------ Define Input Output
  val io = IO(new Bundle{
    val in = Flipped(Vec(num_input,ReqAckConf_if(data_word_width)))
    val out = Vec(num_output,ReqAckConf_if(data_word_width))
  })

  // ------ Wiring
  val config_enable : Bool= io.in(input_ports.indexOf(config_input_port)).config

  // ------ Function
  val decomposed_input_ports = decompose("in",io.in)
  val decomposed_output_ports = decompose("out",io.out)
  private val all_in_port_subnet: ListBuffer[port_subnet] = new ListBuffer[port_subnet]()
  private val all_out_port_subnet: ListBuffer[port_subnet] = new ListBuffer[port_subnet]()
  private val inter_subnet_connection : ListBuffer[subnet_connection] = new ListBuffer[subnet_connection]()

  // Generate Port-Subnet Connection
  for (subnet <- 0 until decomposer){
    for (in <- input_ports;out <- output_ports){
      val temp_connection = new subnet_connection
      temp_connection.source = all_in_port_subnet.find(p=>p.port == in && p.subnet == subnet).getOrElse({
        val temp_port_subnet = new port_subnet
        temp_port_subnet.subnet = subnet;temp_port_subnet.port = in
        all_in_port_subnet += temp_port_subnet;temp_port_subnet
      })
      temp_connection.sink = all_out_port_subnet.find(p=>p.port == out && p.subnet == subnet).getOrElse({
        val temp_port_subnet = new port_subnet
        temp_port_subnet.subnet = subnet;temp_port_subnet.port = out
        all_out_port_subnet += temp_port_subnet;temp_port_subnet
      })
      inter_subnet_connection += temp_connection
    }
  }
  // Create MUXes, DelayPipe, Alu
  val all_sink_port_subnet : ListBuffer[port_subnet] = inter_subnet_connection.map(i=>i.sink).distinct
  val all_source_port_subnet : ListBuffer[port_subnet] = inter_subnet_connection.map(i=>i.source).distinct
  val all_muxes : ListBuffer[Multiplexer] = new ListBuffer[Multiplexer]()
  val all_delaypipes : ListBuffer[delay_pipe] = new ListBuffer[delay_pipe]()
  val all_alus : ListBuffer[alu] = new ListBuffer[alu]()
  for (output_port_subnet <- all_sink_port_subnet){
    val insts = instructions(output_port_subnet.port)
    val num_operand = get_num_max_operand(insts)
    for (m <- 0 until num_operand){
      val mux = new Multiplexer
      val delaypipe = new delay_pipe
      all_muxes += mux;all_delaypipes += delaypipe
      delaypipe.operand = m
      delaypipe.sink = output_port_subnet
      delaypipe.pipe_word_width = data_word_width / decomposer
      delaypipe.max_delay = if(p.has_backpressure.valid) 0 else p.has_backpressure.max_delay
      mux.operand = m
      mux.sink = output_port_subnet
      mux.sources = inter_subnet_connection.filter(i=>i.sink == output_port_subnet).map(s=>s.source) toList
    }
    val alu = new alu;all_alus += alu
    alu.max_num_operand = num_operand
    alu.alu_word_width = data_word_width / decomposer
    alu.inst = insts
    alu.sink = output_port_subnet
  }

  // Assign Mux, Delaypipe, Alu config location
  var pre_high_bit : Int = -1
  for (m <- all_muxes){
    m.config_low = pre_high_bit + 1
    m.config_high = m.config_low + (1 max log2Ceil(m.sources.length)) - 1
    pre_high_bit = m.config_high
  }
  for (d <- all_delaypipes){
    d.config_low = pre_high_bit + 1
    d.config_high = d.config_low + (1 max log2Ceil(1 max d.max_delay)) - 1
    pre_high_bit = d.config_high
  }
  for (a <- all_alus){
    a.config_low = pre_high_bit + 1
    a.config_high = a.config_low + (1 max log2Ceil(a.inst.length)) - 1
    pre_high_bit = a.config_high
  }

  // Create Config Wire
  val config_width : Int = 1 + pre_high_bit
  val config_wire = Wire(UInt(config_width.W))

  // Instantiate Alu and Delaypipe
  val all_delaypipes_hw = all_delaypipes.map(p=>Module(new delay_pipe_hw(p)))
  val all_alus_hw = all_alus.map(a=>Module(new alu_hw(a)))

  // Forward Connect Bits and Valid
  for (out_port_sub <- all_sink_port_subnet){
    val muxes = all_muxes.filter(m=>m.sink == out_port_sub)
    val delaypipes_per_ps = all_delaypipes.filter(d=>d.sink == out_port_sub)
    val alu = all_alus.find(a=>a.sink == out_port_sub).get
    val alu_hw = all_alus_hw(all_alus.indexOf(alu))
    for (idx_operand <- 0 until alu.max_num_operand){
      // Instantiate MUX and Delaypipe
      val m = muxes.find(m=>m.operand == idx_operand).get
      val delay_pipe = delaypipes_per_ps.find(p=>p.operand == idx_operand).get
      val delay_pipe_hw = all_delaypipes_hw(all_delaypipes.indexOf(delay_pipe))
      // Connect Input with Delay pipe
      val select2source_bits =
        m.sources.zipWithIndex.map(mi=>mi._2.U -> decomposed_input_ports(mi._1.subnet)(input_ports.indexOf(mi._1.port)).bits)
      val select2source_valid =
        m.sources.zipWithIndex.map(mi=>mi._2.U -> decomposed_input_ports(mi._1.subnet)(input_ports.indexOf(mi._1.port)).valid)
      delay_pipe_hw.io.in.bits :=
        MuxLookup(config_wire(m.config_high,m.config_low),0.U,select2source_bits)
      delay_pipe_hw.io.in.valid :=
        MuxLookup(config_wire(m.config_high,m.config_low),0.U,select2source_valid)
      // Connect Delay pipe with alu
      alu_hw.io.in(idx_operand).bits := delay_pipe_hw.io.out.bits
      alu_hw.io.in(idx_operand).valid := delay_pipe_hw.io.out.valid
      delay_pipe_hw.io.out.ready := alu_hw.io.in(idx_operand).ready
      // Connect Delay Pipe with Control Wiring
      delay_pipe_hw.io.delay := config_wire(delay_pipe.config_high,delay_pipe.config_low)
    }
    // Connect Alu to Output Port
    decomposed_output_ports(out_port_sub.subnet)(output_ports.indexOf(out_port_sub.port)).bits := alu_hw.io.out.bits
    decomposed_output_ports(out_port_sub.subnet)(output_ports.indexOf(out_port_sub.port)).valid := alu_hw.io.out.valid
    alu_hw.io.out.ready := decomposed_output_ports(out_port_sub.subnet)(output_ports.indexOf(out_port_sub.port)).ready
    // Connect Alu Config (Opcode)
    alu_hw.io.opcode := config_wire(alu.config_high,alu.config_low)
  }

  // Connect Ready Signal
  all_source_port_subnet.foreach(s=>{
    val connect_muxes = all_muxes.filter(m=>m.sources.contains(s))
    val combined_ready : ListBuffer[Bool] = connect_muxes.map(cm=>{
      val target_delaypipe = all_delaypipes.find(d=>d.sink == cm.sink && d.operand == cm.operand).get
      Mux(config_wire(cm.config_high,cm.config_low) === cm.sources.indexOf(s).U,
        all_delaypipes_hw(all_delaypipes.indexOf(target_delaypipe)).io.in.ready,
        true.B)
    })
    decomposed_input_ports(s.subnet)(input_ports.indexOf(s.port)).ready := combined_ready.reduce(_&&_)
  })

  // ------ Calculate Config Encoding
  val config_idx_data_width = config_module_id_low
  def calculate_config_idx_data_width(num_idx:Int, config_width:Int, config_idx_data_width:Int):Int={
    val config_width_per_idx : Int = ceil(config_width.toDouble / num_idx.toDouble).toInt
    val idx_width = log2Ceil(num_idx)
    if(idx_width + config_width_per_idx > config_idx_data_width)
      calculate_config_idx_data_width(num_idx+1,config_width,config_idx_data_width)
    else if (idx_width >= config_idx_data_width)
      throw new Exception("Can not fold config data into register file, too many configurations")
    else
      num_idx
  }
  val num_idx : Int = calculate_config_idx_data_width(1,config_width,config_idx_data_width)
  val idx_width : Int = log2Ceil(num_idx) max 1
  val config_idx_high : Int = config_module_id_low - 1
  val config_idx_low : Int = config_idx_high - idx_width + 1
  val config_width_per_idx : Int = ceil(config_width.toDouble / num_idx.toDouble).toInt
  val config_data_high : Int = config_width_per_idx - 1
  val config_data_low = 0

  // ------ Create Config Register File and Connect to Config Wire
  val config_register_file = RegInit(VecInit(Seq.fill(num_idx)(0.U(config_width_per_idx.W))))
  config_wire := config_register_file.reduce(Cat(_,_))(config_width - 1,0)

  // Update Config Register when configured in config port
  println("module name = " + module_name)
  println("config_input_port = " + config_input_port + ", config_output_port = " + config_output_port)
  println("input_ports = " + input_ports)
  val config_device_word : UInt= io.in(input_ports.indexOf(config_input_port)).bits
  val config_module_id = config_device_word(config_module_id_high,config_module_id_low)
  val module_id_match : Bool = config_module_id === p.module_id.U
  val config_idx = config_device_word(config_idx_high,config_idx_low)
  val config_data = config_device_word(config_data_high,config_data_low)
  when(config_enable && module_id_match){
    config_register_file(config_idx) := config_data
  }

  // ------ Util
  def get_port (io_t:String,name:String) = {
    io_t match {
      case "in" => io.in(p.input_ports.indexOf(name))
      case "out" => io.out(p.output_ports.indexOf(name))
    }
  }
  def decompose(io_type:String,ports: Vec[ReqAckConf_if]) : List[Vec[DecoupledIO[UInt]]] = {
    val num_ports = ports.length
    val sub_word_width = data_word_width / decomposer
    val decomposed_ports : List[Vec[DecoupledIO[UInt]]] =
      List.fill[Vec[DecoupledIO[UInt]]](decomposer)(Wire(Vec(num_ports,DecoupledIO(UInt(sub_word_width.W)))))

    io_type match{
      case "in" =>
        for(idx_port <- 0 until num_ports){
          for (subnet <- 0 until decomposer){
            decomposed_ports(subnet)(idx_port).bits :=
              ports(idx_port).bits((subnet + 1) * sub_word_width - 1, subnet * sub_word_width)
            decomposed_ports(subnet)(idx_port).valid :=
              ports(idx_port).valid
          }
          ports(idx_port).ready := decomposed_ports.map(vp=>vp(idx_port).ready).reduce(_ && _)
        }
      case "out" =>
        for(idx_port <- 0 until num_ports){
          // Connect Decomposed Port to Output Register
          val readyreg = Reg(Vec(decomposer,Bool()))
          for (subnet <- 0 until decomposer){
            decomposed_ports(subnet)(idx_port).ready := readyreg(subnet)
          }
          val bitsreg = RegInit(0.U(data_word_width.W))
          bitsreg := decomposed_ports.map(vp=>vp(idx_port).bits).reduce(Cat(_,_))
          val validreg = RegInit(false.B)
          validreg := decomposed_ports.map(vp=>vp(idx_port).valid).reduce(_ && _)

          // If this port is an output config port
          if (idx_port == output_ports.indexOf(config_output_port)){
            // Then when configured, connect directly with input config port
            ports(idx_port).config := io.in(input_ports.indexOf(config_input_port)).config
            when (config_enable){
              ports(idx_port).bits := io.in(input_ports.indexOf(config_input_port)).bits
              ports(idx_port).valid := io.in(input_ports.indexOf(config_input_port)).valid
              io.in(input_ports.indexOf(config_input_port)).ready := ports(idx_port).ready
            }otherwise{ // Otherwise perform as a data port
              for (subnet <- 0 until decomposer) {
                readyreg(subnet) := ports(idx_port).ready
              }
              ports(idx_port).bits := bitsreg
              ports(idx_port).valid := validreg
            }
          }else{
            // Update Output Port (non-config port)
            for (subnet <- 0 until decomposer) {
              readyreg(subnet) := ports(idx_port).ready
            }
            ports(idx_port).bits := bitsreg
            ports(idx_port).valid := validreg
            ports(idx_port).config := false.B
          }
        }
    }
    decomposed_ports
  }
  def get_num_max_operand(insts:List[String]):Int = {
    val subnet_word_width = data_word_width / decomposer
    insts.map(i=>insts_prop(i).numOperands) max
  }
}

class delay_pipe {
  var config_high : Int = -1
  var config_low : Int = -1
  var max_delay : Int = -1
  var pipe_word_width : Int = -1
  var sink : port_subnet = new port_subnet
  var operand : Int = -1
}

class alu {
  var config_high : Int = -1
  var config_low : Int = -1
  var sink : port_subnet = new port_subnet
  var max_num_operand: Int = -1
  var inst : List[String] = Nil
  var alu_word_width : Int = -1
}

class delay_pipe_hw(p:delay_pipe) extends Module{
  val io = IO(new Bundle{
    val in = new Bundle {
      val bits = Input(UInt(p.pipe_word_width.W))
      val valid = Input(Bool())
      val ready = Output(Bool())
    }
    val out = new Bundle {
      val bits = Output(UInt(p.pipe_word_width.W))
      val valid = Output(Bool())
      val ready = Input(Bool())
    }
    val delay = Input(UInt((1 max log2Ceil(1 max p.max_delay)).W))
  })
  if (p.max_delay > 0){
    val fifo_bits = Reg(Vec(p.max_delay,UInt(p.pipe_word_width.W)))
    val fifo_valid = Reg(Vec(p.max_delay,Bool()))
    val head = RegInit(0.U(log2Ceil(p.max_delay).W))
    val tail = RegInit(0.U(log2Ceil(p.max_delay).W))
    io.out.bits := fifo_bits(head)
    io.out.valid := fifo_valid(head)
    fifo_bits(tail) := io.in.bits
    fifo_valid(tail) := io.in.valid
    io.in.ready := io.out.ready
    head := head + 1.U
    tail := head + io.delay
  }else{
    io.out <> io.in
  }
}

class alu_hw(p:alu) extends Module{
  val io = IO(new Bundle{
    val in = Vec(p.max_num_operand,new Bundle {
      val bits = Input(UInt(p.alu_word_width.W))
      val valid = Input(Bool())
      val ready = Output(Bool())
    })
    val out = new Bundle {
      val bits = Output(UInt(p.alu_word_width.W))
      val valid = Output(Bool())
      val ready = Input(Bool())
    }
    val opcode = Input(UInt(log2Ceil(p.inst.length).W))
  })
  val operation_func = p.inst.map(f=>inst_operation(f))
  val inst_props = p.inst.map(f=>insts_prop(f))
  val result_buffer : ListBuffer[UInt] = new ListBuffer[UInt]()
  for (idx_opcode <- p.inst.indices){
    val op_func = operation_func(idx_opcode)
    val inst_prop = inst_props(idx_opcode)
    val result = alu_result(inst_prop,op_func)
    result_buffer += result
  }
  val alu_results = result_buffer.toList

  for (idx_opcode <- p.inst.indices){
    when(io.opcode === idx_opcode.U){
      io.out.bits := alu_results(idx_opcode)
    }.otherwise{
      io.out.bits := 0.U
    }
  }

  // Util
  def alu_result (inst_prop:instruction_prop,func:(UInt*) => UInt) : UInt ={
    val num_op = inst_prop.numOperands
    val result:UInt = num_op match {
      case 1 => func(io.in(0).bits)
      case 2 => func(io.in(0).bits,io.in(1).bits)
      case 3 => func(io.in(0).bits,io.in(1).bits,io.in(2).bits)
    }
    result
  }

  // TODO: Directly connect ready and valid
  io.out.valid := io.in.map(p=>p.valid).reduce(_ && _)
  for (i <- 0 until p.max_num_operand){
    io.in(i).ready := io.out.ready
  }
}