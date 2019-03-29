package cgra.fabric

import cgra.IO.{ReqAckConf_if, config_wire}
import cgra.IO.port_generator.gc_port
import cgra.IR.global_var.get_new_id
import cgra.config.encoding.{config_module_id_high, config_module_id_low}
import cgra.config.fullinst._
import cgra.config.{inst_prop, system}
import chisel3._
import chisel3.util._

import scala.collection.mutable
import scala.collection.mutable.ListBuffer
import scala.math.ceil
import scala.xml.Elem

class Dedicated_PE_Hw(name_p:(String,Any)) extends Module with Has_IO
  with Reconfigurable {

  // Extract Parameter
  val module_name = name_p._1
  private val p = name_p._2.asInstanceOf[mutable.Map[String,Any]]
  val module_id : Int = p("module_id").asInstanceOf[Int]
  val use_global : Boolean = try{p("use_global").asInstanceOf[Boolean]}
  catch {case _: Throwable => false}
  val input_ports : List[String] = try{p("input_ports").asInstanceOf[List[String]]}
  catch{case _:Throwable => List("northeast","southeast","northwest","southwest")}
  val output_ports : List[String] = try{p("output_ports").asInstanceOf[List[String]]}
  catch{case _:Throwable => List("southeast")}
  val protocol : String = try{p("protocol").toString}
  catch {case _:Throwable => "Data"}
  val delay_fifo_depth : Int = try p("delay_fifo_depth").asInstanceOf[Int] catch{case _:Throwable => 1}
  val isDecomposed : Boolean = try {p("isDecomposed").asInstanceOf[Boolean]}catch{case _:Throwable => false}
  val decomposer : Int = if(isDecomposed){try{p("decomposer").asInstanceOf[Int]}
  catch{case _:Throwable => 1}}else{1}
  val isShared : Boolean = try{p("isShared").asInstanceOf[Boolean]}catch{case _:Throwable => false}
  val shared_slot_size : Int = if(isShared){try{p("shared_slot_size").asInstanceOf[Int]}
  catch{case _:Throwable => 32}}else{0}
  val register_file_size : Int = if(isShared){try{p("register_file_size").asInstanceOf[Int]}
  catch{case _:Throwable => 8}}else{0}
  val data_word_width : Int = try {if(use_global) system.data_word_width else p("data_word_width").asInstanceOf[Int]}
  catch{case _:Throwable => 64}
  val config_input_port : String = try p("config_input_port").toString catch{case _:Throwable => input_ports.head}
  val config_output_port : String = try p("config_output_port").toString catch{case _:Throwable => output_ports.head}
  private val instructions = p("instructions").asInstanceOf[List[String]]

  // Derived Variables
  val decomped_data_word_width : Int = data_word_width / decomposer
  val num_input : Int = input_ports.length
  val num_output : Int = output_ports.length
  val input_ports_subnet : List[String] = (for(subnet<- 0 until decomposer;port<-input_ports) yield port + "_" + subnet).toList
  val output_ports_subnet : List[String] = (for(subnet<- 0 until decomposer;port<-output_ports) yield port + "_" + subnet).toList
  val input_ports_type : List[String] = input_ports.map(p=>{if(p == config_input_port) protocol + "_Config" else protocol})
  val output_ports_type : List[String] = output_ports.map(p=>{if(p == config_output_port) protocol + "_Config" else protocol})

  // ------ Define Input Output
  val io = IO(new Bundle{
    val input_ports = Flipped(Vec(num_input,Vec(decomposer,ReqAckConf_if(decomped_data_word_width))))
    val output_ports = Vec(num_output,Vec(decomposer,ReqAckConf_if(decomped_data_word_width)))
  })
  // Connect Useless Port with DontCare
  for(p_idx <- input_ports.indices;subnet <- 0 until decomposer){
    val port_type : String = input_ports_type(p_idx)
    val port : ReqAckConf_if = io.input_ports(p_idx)(subnet)
    gc_port(port,port_type)
  }
  for(p_idx <- output_ports.indices; subnet <- 0 until decomposer){
    val port_type = output_ports_type(p_idx)
    val port = io.output_ports(p_idx)(subnet)
    gc_port(port,port_type)
  }

  // ------- Calculate Hardware Configuration
  var config_register_files_width : Int = -1
  val instruction_properties = instructions.map(p=>insts_prop(p))
  val max_num_operand : Int = instruction_properties.map(i=>i.numOperands) max
  val all_MUXes : Array[MUX] = new Array[MUX](decomposer * max_num_operand);var mux_c = 0
  val all_Delay_Channels : Array[Delay_Pipe] = new Array[Delay_Pipe](decomposer * max_num_operand);var dp_c = 0
  val all_ALUs : Array[Alu] = new Array[Alu](decomposer);var alu_c = 0
  for(subnet <- 0 until decomposer){
    var pre_high_bit : Int = -1
    for (operand_idx <- 0 until max_num_operand){
      // ------ Add MUX
      val mux : MUX = new MUX;all_MUXes(mux_c) = mux;mux_c += 1
      mux.operand = operand_idx
      mux.subnet = subnet
      mux.sources = input_ports_subnet.filter(s=>s.endsWith(subnet.toString))
      if(isShared){ // Add Source as MUX source if it is shared
        val temp = mux.sources.to[ListBuffer]
        for(r_idx <- 0 until register_file_size)
          temp += "reg_" + r_idx
        mux.sources = temp.toList
      }
      val num_source = mux.sources.length
      mux.config_low = pre_high_bit + 1
      mux.config_high = mux.config_low + log2Ceil(num_source) - 1
      pre_high_bit = mux.config_high
      // ------ Add Delay Pipe
      val dp : Delay_Pipe = new Delay_Pipe;all_Delay_Channels(dp_c) = dp;dp_c += 1
      dp.operand = operand_idx;dp.subnet = subnet
      dp.pipe_word_width = decomped_data_word_width
      dp.max_delay = delay_fifo_depth
      dp.config_low = pre_high_bit + 1
      dp.config_high = dp.config_low + log2Ceil(delay_fifo_depth) - 1
      dp.protocol = protocol
      pre_high_bit = dp.config_high
    }
    // ------ Add Alu
    val alu : Alu = new Alu;all_ALUs(alu_c) = alu;alu_c +=1
    alu.max_num_operand = max_num_operand
    alu.subnet = subnet
    alu.inst = instructions
    alu.alu_word_width = decomped_data_word_width
    alu.protocol = protocol
    alu.config_low = pre_high_bit + 1
    alu.config_high = alu.config_low + log2Ceil(instructions.length) - 1
    pre_high_bit = alu.config_high
    config_register_files_width = (1 + pre_high_bit) max config_register_files_width
  }
  val config_register_files : Vec[UInt] = RegInit(VecInit(Seq.fill(decomposer)(0.U(config_register_files_width.W))))

  // ------- Config Wire
  // Extract Config Port Name and Index
  val in_config_port_idx :List[(String,Int)] = input_ports_subnet.zipWithIndex
    .filter(p=>p._1.startsWith(config_input_port))
  val out_config_port_idx :List[(String,Int)]= output_ports_subnet.zipWithIndex
    .filter(p=>p._1.startsWith(config_output_port))
  // Extract Config Port based on Index
  val input_config_ports = io.input_ports(input_ports.indexOf(config_input_port))
  val output_config_ports = io.output_ports(output_ports.indexOf(config_output_port))
  // Create Config Wire
  val in_config_wire = Wire(config_wire(data_word_width))
  val out_config_wire = Wire(config_wire(data_word_width))
  // Connect Config Port with Config Wiring
  in_config_wire.bits := input_config_ports.map(_.bits).reduce(Cat(_,_))
  in_config_wire.config := input_config_ports.map(_.config).reduce(_&&_)
  output_config_ports.zipWithIndex.foreach(p=>{
    val idx = p._2
    output_config_ports(idx).bits := out_config_wire.bits((idx + 1) * decomped_data_word_width - 1,idx * decomped_data_word_width)
    output_config_ports(idx).config := out_config_wire.config
  })
  // Connect Input and Output Wire
  out_config_wire := in_config_wire

  // ------- Update Configuration
  val module_id_wire : UInt = in_config_wire.bits(config_module_id_high,config_module_id_low)
  val config_enable : Bool = in_config_wire.config && module_id.U === module_id_wire
  val subnet_select_wire = if(isDecomposed && decomposer > 1){Wire(UInt(log2Ceil(decomposer).W))}else{Wire(UInt(1.W))}
  val slot_select_wire = if(isShared && shared_slot_size > 1){Wire(UInt(log2Ceil(shared_slot_size).W))}else{Wire(UInt(1.W))}
  var config_subnet_high : Int = config_module_id_low
  var config_subnet_low : Int = config_module_id_low
  var config_slot_high : Int = config_module_id_low
  var config_slot_low : Int = config_module_id_low
  if(isDecomposed && decomposer > 1){
    // Specify Wiring
    config_subnet_high = config_module_id_low - 1;config_subnet_low = config_subnet_high - log2Ceil(decomposer) + 1
    subnet_select_wire := in_config_wire.bits(config_subnet_high,config_subnet_low)
  }else{
    subnet_select_wire := 0.U
  }
  if(isShared && shared_slot_size > 1){
    // Specify Wiring
    config_slot_high = config_subnet_low - 1
    config_slot_low = config_slot_high - log2Ceil(shared_slot_size) + 1
    slot_select_wire := in_config_wire.bits(config_slot_high,config_slot_low)
  }else{
    slot_select_wire := 0.U
  }
  // Specift Config Data Wiring
  var config_data_high : Int = config_slot_low - 1
  var config_data_low : Int = 0
  require(config_data_high + 1 > config_register_files_width,"Write Config Data / Instruction should be wider than Config Register")
  val config_data_wire : UInt = Wire(UInt((config_data_high + 1).W))
  config_data_wire := in_config_wire.bits(config_data_high,config_data_low)
  if(isShared){
    // Create Slot File
    val config_slot_files = RegInit(VecInit(Seq.fill(decomposer)(VecInit(Seq.fill(shared_slot_size)(0.U(config_register_files_width.W))))))
    val config_slot_counter =RegInit(VecInit(Seq.fill(decomposer)(0.U(log2Ceil(shared_slot_size).W))))
    config_slot_counter.zipWithIndex.foreach(c => {
      val counter = c._1;val subnet = c._2
      when(config_slot_files(subnet)(counter) === 0.U){
        counter := 0.U
      }.otherwise{counter := counter + 1.U}
    })
    for(subnet <- 0 until decomposer){
      config_register_files(subnet) := config_slot_files(subnet)(config_slot_counter(subnet))
    }
    // When Config Enabled
    when(config_enable){
      config_slot_files(subnet_select_wire)(slot_select_wire) := config_data_wire
      config_slot_counter(subnet_select_wire) := 0.U // Reset Counter When Slot updated
    }
  }else{
    when(config_enable){
      config_register_files(subnet_select_wire) := config_data_wire
    }
  }

  // ------- Create Hardware
  // Create Register File
  val register_file : Vec[UInt] = if(isShared){
    RegInit(VecInit(Seq.fill(register_file_size)(0.U(data_word_width.W))))
  }else{
    RegInit(VecInit(Seq.fill(1)(0.U(1.W)))) // if not shared, create a 1 bit flip-flop, just for grammar check
  }
  // Connect Hardware TODO: Seperate Code for each protocol
  if(protocol.contains("Ready")){
    val output_interface = Wire(Vec(all_MUXes.length,DecoupledIO(UInt(decomped_data_word_width.W))))
    val all_alu_hw = all_ALUs.map(a=>Module(new alu_hw(a)).io)
    // Forward
    for (subnet <- 0 until decomposer){
      // ALU -> Output
      val alu = all_ALUs.find(a=>a.subnet == subnet).get
      val alu_hw = all_alu_hw(all_ALUs.indexOf(alu))
      alu_hw.in.foreach(gc_port(_,protocol));gc_port(alu_hw.out,protocol)
      alu_hw.opcode := config_register_files(subnet)(alu.config_high,alu.config_low)
      for (output_port <- output_ports){
        val port_idx = output_ports.indexOf(output_port)
        io.output_ports(port_idx)(subnet).bits := alu_hw.out.bits
        io.output_ports(port_idx)(subnet).valid := alu_hw.out.valid
      }
      for (operand_idx <- 0 until max_num_operand){
        // Delay Pipe -> ALU
        val dp = all_Delay_Channels.find(d=>d.subnet == subnet && d.operand == operand_idx).get
        val dp_hw = Module(new delay_pipe_hw(dp)).io
        gc_port(dp_hw.in,protocol);gc_port(dp_hw.out,protocol)
        dp_hw.delay := config_register_files(subnet)(dp.config_high,dp.config_low)
        alu_hw.in(operand_idx) <> dp_hw.out
        // IN -> MUX
        val mux = all_MUXes.find(m=>m.operand == operand_idx && m.subnet == subnet).get
        val sources = mux.sources
        val select_bits = sources.map(s=>{
          if(s.startsWith("reg")){
            val reg_idx = s.split("_")(1).toInt
            register_file(reg_idx)((subnet + 1) * decomped_data_word_width - 1,subnet * decomped_data_word_width)
          }else{
            val port_name = s.split("_").head;val port_idx = input_ports.indexOf(port_name)
            io.input_ports(port_idx)(subnet).bits
          }}).zipWithIndex.map(p=> p._2.U -> p._1)
        val select_valid = sources.map(s=>{
          if(s.startsWith("reg")){
            true.B
          }else{
            val port_name = s.split("_").head;val port_idx = input_ports.indexOf(port_name)
            io.input_ports(port_idx)(subnet).valid
          }}).zipWithIndex.map(p=> p._2.U -> p._1)
        val select_wire : UInt = config_register_files(subnet)(mux.config_high,mux.config_low)
        //MUX -> Delay Pipe
        val dp_bridge = output_interface(all_MUXes.indexOf(mux))
        dp_hw.in.bits := dp_bridge.bits
        dp_hw.in.valid := dp_bridge.valid
        dp_bridge.ready := dp_hw.in.ready
        dp_bridge.bits := MuxLookup(select_wire,0.U,select_bits)
        dp_bridge.valid := MuxLookup(select_wire,false.B,select_valid)
      }
    }
    // Backward
    // Alu -> Output
    for (subnet <- 0 until decomposer){
      val alu = all_ALUs.find(a=>a.subnet == subnet).get
      val alu_hw = all_alu_hw(all_ALUs.indexOf(alu))
      val backpressure_signal = (for(output <- output_ports)
        yield io.output_ports(output_ports.indexOf(output))(subnet).ready).reduce(_&&_)
      alu_hw.out.ready := backpressure_signal
    }
    // MUX -> DelayPipe
    for(input_subnet <- input_ports_subnet){
      val port_name = input_subnet.split("_").head;val port_idx = input_ports.indexOf(port_name)
      val subnet = input_subnet.split("_")(1).toInt
      val connect_MUXes = all_MUXes.zipWithIndex.filter(m=>m._1.sources.exists(p=>p.startsWith(port_name))
        && m._1.subnet == subnet)
      val connect_select_value = connect_MUXes.map(m=>m._1.sources.indexOf(input_subnet))
      val connect_select_wire = connect_MUXes.map(m=>{
        val mux = m._1;val m_subnet = mux.subnet
        config_register_files(m_subnet)(mux.config_high,mux.config_low)
      })
      val connect_bridges = connect_MUXes.map(_._2).map(output_interface)
      val backpressure_signal : Bool = (for(m_idx <- connect_MUXes.indices)
        yield Mux(connect_select_wire(m_idx) === connect_select_value(m_idx).U,connect_bridges(m_idx).ready,true.B))
        .reduce(_&&_)
      io.input_ports(port_idx)(subnet).ready := backpressure_signal
    }
  }else if(protocol.contains("Valid")){
    // Forward
    for (subnet <- 0 until decomposer){
      // ALU -> Output
      val alu = all_ALUs.find(a=>a.subnet == subnet).get
      val alu_hw = Module(new alu_hw(alu)).io
      alu_hw.in.foreach(gc_port(_,protocol));gc_port(alu_hw.out,protocol)
      alu_hw.opcode := config_register_files(subnet)(alu.config_high,alu.config_low)
      for (output_port <- output_ports){
        val port_idx = output_ports.indexOf(output_port)
        io.output_ports(port_idx)(subnet).bits := alu_hw.out.bits
        io.output_ports(port_idx)(subnet).valid := alu_hw.out.valid
      }
      for (operand_idx <- 0 until max_num_operand){
        // Delay Pipe -> ALU
        val dp = all_Delay_Channels.find(d=>d.subnet == subnet && d.operand == operand_idx).get
        val dp_hw = Module(new delay_pipe_hw(dp)).io
        gc_port(dp_hw.in,protocol);gc_port(dp_hw.out,protocol)
        dp_hw.delay := config_register_files(subnet)(dp.config_high,dp.config_low)
        alu_hw.in(operand_idx) <> dp_hw.out
        // IN -> MUX
        val mux = all_MUXes.find(m=>m.operand == operand_idx && m.subnet == subnet).get
        val sources = mux.sources
        val select_bits = sources.map(s=>{
          if(s.startsWith("reg")){
            val reg_idx = s.split("_")(1).toInt
            register_file(reg_idx)((subnet + 1) * decomped_data_word_width - 1,subnet * decomped_data_word_width)
          }else{
            val port_name = s.split("_").head;val port_idx = input_ports.indexOf(port_name)
            io.input_ports(port_idx)(subnet).bits
          }}).zipWithIndex.map(p=> p._2.U -> p._1)
        val select_valid = sources.map(s=>{
          if(s.startsWith("reg")){
            true.B
          }else{
            val port_name = s.split("_").head;val port_idx = input_ports.indexOf(port_name)
            io.input_ports(port_idx)(subnet).valid
          }}).zipWithIndex.map(p=> p._2.U -> p._1)
        val select_wire : UInt = config_register_files(subnet)(mux.config_high,mux.config_low)
        //MUX -> Delay Pipe
        dp_hw.in.bits := MuxLookup(select_wire,0.U,select_bits)
        dp_hw.in.valid := MuxLookup(select_wire,false.B,select_valid)
      }
    }
  }else{
    // Forward
    for (subnet <- 0 until decomposer){
      // ALU -> Output
      val alu = all_ALUs.find(a=>a.subnet == subnet).get
      val alu_hw = Module(new alu_hw(alu)).io
      alu_hw.in.foreach(gc_port(_,protocol));gc_port(alu_hw.out,protocol)
      alu_hw.opcode := config_register_files(subnet)(alu.config_high,alu.config_low)
      for (output_port <- output_ports){
        val port_idx = output_ports.indexOf(output_port)
        io.output_ports(port_idx)(subnet).bits := alu_hw.out.bits
        io.output_ports(port_idx)(subnet).valid := alu_hw.out.valid
      }
      for (operand_idx <- 0 until max_num_operand){
        // Delay Pipe -> ALU
        val dp = all_Delay_Channels.find(d=>d.subnet == subnet && d.operand == operand_idx).get
        val dp_hw = Module(new delay_pipe_hw(dp)).io
        gc_port(dp_hw.in,protocol);gc_port(dp_hw.out,protocol)
        dp_hw.delay := config_register_files(subnet)(dp.config_high,dp.config_low)
        alu_hw.in(operand_idx) <> dp_hw.out
        // IN -> MUX
        val mux = all_MUXes.find(m=>m.operand == operand_idx && m.subnet == subnet).get
        val sources = mux.sources
        val select_bits = sources.map(s=>{
          if(s.startsWith("reg")){
            val reg_idx = s.split("_")(1).toInt
            register_file(reg_idx)((subnet + 1) * decomped_data_word_width - 1,subnet * decomped_data_word_width)
          }else{
            val port_name = s.split("_").head;val port_idx = input_ports.indexOf(port_name)
            io.input_ports(port_idx)(subnet).bits
          }}).zipWithIndex.map(p=> p._2.U -> p._1)
        val select_wire : UInt = config_register_files(subnet)(mux.config_high,mux.config_low)
        //MUX -> Delay Pipe
        dp_hw.in.bits := MuxLookup(select_wire,0.U,select_bits)
      }
    }
  }

  def get_num_max_operand(insts:List[String]):Int = {
    val subnet_word_width = data_word_width / decomposer
    insts.map(i=>insts_prop(i).numOperands) max
  }

  // ------ Print Configuration
  def config2XML : Elem = {
    <Dedicated_PE>
      <Module_Name>{module_name}</Module_Name>
      <Module_ID>{module_id}</Module_ID>
      <Input_Ports>{input_ports.zipWithIndex.map(p=>{<Index>{p._2}</Index><Port>{p._1}</Port>})}</Input_Ports>
      <Output_Ports>{output_ports.zipWithIndex.map(p=>{<Index>{p._2}</Index><Port>{p._1}</Port>})}</Output_Ports>
      <Width_Register_File>{config_register_files_width}</Width_Register_File>
      <MUXes>{all_MUXes.map(b=>b.config2XML)}</MUXes>
      <Delay_Pipes>{all_Delay_Channels.map(d=>d.config2XML)}</Delay_Pipes>
      <Alues>{all_ALUs.map(a=>a.config2XML)}</Alues>
    </Dedicated_PE>
  }
}

class Delay_Pipe extends Reconfigurable {
  var config_high : Int = -1
  var config_low : Int = -1
  var max_delay : Int = -1
  var pipe_word_width : Int = -1
  var sink : String = ""
  var subnet : Int = -1
  var operand : Int = -1
  var protocol : String = ""
  def config2XML : Elem = {
    <Delay_Pipe>
      <Config_High_Bit>{config_high}</Config_High_Bit>
      <Config_Low_Bit>{config_low}</Config_Low_Bit>
      <Max_Delay>{max_delay}</Max_Delay>
      <Idx_Operand>{operand}</Idx_Operand>
    </Delay_Pipe>
  }
}

class Alu extends Reconfigurable {
  var config_high : Int = -1
  var config_low : Int = -1
  var sink : String = ""
  var subnet : Int = -1
  var max_num_operand: Int = -1
  var inst : List[String] = Nil
  var alu_word_width : Int = -1
  var protocol : String = ""
  def config2XML : Elem = {
    <Alu>
      <Config_High_Bit>{config_high}</Config_High_Bit>
      <Config_Low_Bit>{config_low}</Config_Low_Bit>
      <Num_Operands>{max_num_operand}</Num_Operands>
      <Opcodes>
        {inst.zipWithIndex.map(i=>{<Select>{i._2}</Select><Opcode>{i._1}</Opcode>})}
      </Opcodes>
      <Sink>{sink}</Sink>
    </Alu>
  }
}

class delay_pipe_hw(p:Delay_Pipe) extends Module{
  val io = IO(new Bundle{
    val in = Flipped(ReqAckConf_if(p.pipe_word_width))
    val out = ReqAckConf_if(p.pipe_word_width)
    val delay = Input(UInt((1 max log2Ceil(1 max p.max_delay)).W))
  })
  gc_port(io.in,p.protocol)
  gc_port(io.out,p.protocol)
  if (p.max_delay > 0){
    if(p.protocol.contains("Ready")){
      val queue_in : DecoupledIO[UInt] = Wire(DecoupledIO(UInt(p.pipe_word_width.W)))
      queue_in.bits := io.in.bits
      queue_in.valid := io.in.valid
      queue_in.ready <> io.in.ready
      val queue_out = Queue(queue_in,p.max_delay)
      io.out.bits := queue_out.bits
      io.out.valid := queue_out.valid
      io.out.ready <> queue_out.ready
    }else if (p.protocol.contains("Valid")){
      val fifo_bits = Reg(Vec(p.max_delay,UInt(p.pipe_word_width.W)))
      val fifo_valid = Reg(Vec(p.max_delay,Bool()))
      val head = RegInit(0.U(log2Ceil(p.max_delay).W))
      val tail = RegInit(0.U(log2Ceil(p.max_delay).W))
      io.out.bits := fifo_bits(head)
      io.out.valid := fifo_valid(head)
      fifo_bits(tail) := io.in.bits
      fifo_valid(tail) := io.in.valid
      head := head + 1.U
      tail := head + 1.U + io.delay
    }else{
      val fifo_bits = Reg(Vec(p.max_delay,UInt(p.pipe_word_width.W)))
      val head = RegInit(0.U(log2Ceil(p.max_delay).W))
      val tail = RegInit(0.U(log2Ceil(p.max_delay).W))
      io.out.bits := fifo_bits(head)
      fifo_bits(tail) := io.in.bits
      head := head + 1.U
      tail := head + 1.U + io.delay
    }
  }else{
    io.out <> io.in
  }
}

class alu_hw(p:Alu) extends Module{
  val io = IO(new Bundle{
    val in = Flipped(Vec(p.max_num_operand,ReqAckConf_if(p.alu_word_width)))
    val out = ReqAckConf_if(p.alu_word_width)
    val opcode = Input(UInt(log2Ceil(p.inst.length).W))
  })
  // GC useless port
  io.in.foreach(ap=>gc_port(ap,p.protocol))
  gc_port(io.out,p.protocol)

  val operation_func = p.inst.map(f=>inst_operation(f))
  val inst_props = p.inst.map(f=>insts_prop(f))

  val result_buffer : Vec[UInt] = Wire(Vec(p.inst.length,UInt(p.alu_word_width.W)))

  for (idx_opcode <- p.inst.indices){
    val op_func = operation_func(idx_opcode)
    val inst_prop = inst_props(idx_opcode)
    val result = alu_result(inst_prop,op_func)
    result_buffer(idx_opcode) := result
  }

  io.out.bits := result_buffer(io.opcode)

  // Util
  def alu_result (inst_prop:inst_prop, func:(UInt*) => UInt) : UInt ={
    val num_op = inst_prop.numOperands
    val result:UInt = num_op match {
      case 1 => func(io.in(0).bits)
      case 2 => func(io.in(0).bits,io.in(1).bits)
      case 3 => func(io.in(0).bits,io.in(1).bits,io.in(2).bits)
    }
    result
  }

  // TODO: Backpressure
  if (!p.protocol.contains("Ready")){
    io.out.valid := io.in.map(p=>p.valid).reduce(_ && _)
    for (i <- 0 until p.max_num_operand){
      io.in(i).ready := io.out.ready
    }
  }else{
    val simulated_alu_latency = RegInit(0.U(1 max log2Ceil(inst_props.map(i=>i.latency) max)))

    // Restart
    when(io.out.ready && io.in.map(p=>p.valid).reduce(_ && _) && simulated_alu_latency === 0.U){
      for (idx_opcode <- p.inst.indices){
        when(io.opcode === idx_opcode.U){
          simulated_alu_latency := inst_props(idx_opcode).latency.U
        }
      }
    }

    // Counting Down
    when(simulated_alu_latency =/= 0.U){
      simulated_alu_latency := simulated_alu_latency - 1.U
      io.out.valid := false.B
      for (i <- 0 until p.max_num_operand){
        io.in(i).ready := false.B
      }
    }.otherwise{ // Finished
      io.out.valid := true.B
      for (i <- 0 until p.max_num_operand){
        io.in(i).ready := true.B
      }
    }
  }

}

object tester_pe extends App{
  // Knob Parameters
  /*
  val module_name = name_p._1
  val module_id : Int = p("module_id").asInstanceOf[Int]
  private val p = name_p._2.asInstanceOf[mutable.Map[String,Any]]
  val use_global : Boolean = try{p("use_global").asInstanceOf[Boolean]}
  catch {case _: Throwable => false}
  val input_ports : List[String] = try{p("input_ports").asInstanceOf[List[String]]}
  catch{case _:Throwable => List("northeast","southeast","northwest","southwest")}
  val output_ports : List[String] = try{p("output_ports").asInstanceOf[List[String]]}
  catch{case _:Throwable => List("southeast")}
  val protocol : String = try{p("protocol").toString}
  catch {case _:Throwable => "Data"}
  val delay_fifo_depth : Int = try p("delay_fifo_depth").asInstanceOf[Int] catch{case _:Throwable => 1}
  val isDecomposed : Boolean = try {p("isDecomposed").asInstanceOf[Boolean]}catch{case _:Throwable => false}
  val decomposer : Int = if(isDecomposed){try{p("decomposer").asInstanceOf[Int]}
  val isShared : Boolean = try{p("isShared").asInstanceOf[Boolean]}catch{case _:Throwable => false}
  val shared_slot_size : Int = if(isShared){try{p("shared_slot_size").asInstanceOf[Int]}
  val register_file_size : Int = if(isShared){try{p("register_file_size").asInstanceOf[Int]}
  val execute_model : String = if(isShared){try{p("execute_model").toString}catch{case _:Throwable=>"update"}}else{""}
  val data_word_width : Int = try {if(use_global) system.data_word_width else p("data_word_width").asInstanceOf[Int]}
  val config_input_port : String = try p("config_input_port").toString catch{case _:Throwable => input_ports.head}
  val config_output_port : String = try p("config_output_port").toString catch{case _:Throwable => output_ports.head}
  private val instructions = p("instructions").asInstanceOf[List[String]]
   */
  system.data_word_width = 64
  val p : mutable.Map[String,Any] = mutable.Map[String,Any]()
  p += "module_name" -> "PE_Test"
  p += "module_id" -> {get_new_id;get_new_id;get_new_id;get_new_id;get_new_id;get_new_id;get_new_id;get_new_id}
  p += "protocol" -> "Data_Valid_Ready"
  p += "delay_fifo_depth" -> 4
  p += "isDecomposed" -> true
  p += "decomposer" -> 8
  p += "isShared" -> true
  p += "shared_slot_size" -> 32
  p += "register_file_size" -> 8
  p += "instructions" -> List("Add","Sub","BOr","BAnd")
  chisel3.Driver.execute(args,()=>{new Dedicated_PE_Hw("test",p)})
}