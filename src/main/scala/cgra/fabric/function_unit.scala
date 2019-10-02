package cgra.fabric

import cgra.IO._
import chisel3.util._
import chisel3._
import dsl.IRPrintable
import scala.collection.mutable
import scala.util.Random
import cgra.config.fullinst._

class function_unit(prop:mutable.Map[String,Any])
  extends Module
  with IRPrintable{
  // Assign initial properties
  apply(prop)

  // ------ Reconfigurable Variable------

  // Initialize the properties of switch (hardware)
  private val id = getValue(getPropByKey("id")).asInstanceOf[Int]
  private val max_id = getPropByKey("max_id").asInstanceOf[Int]
  private val datawidth:Int = getPropByKey("datawidth").asInstanceOf[Int]
  private val granularity = getPropByKey("granularity").asInstanceOf[Int]
  private val num_input:Int = getPropByKey("num_input").asInstanceOf[Int]
  private val num_output:Int = getPropByKey("num_output").asInstanceOf[Int]
  private val flow_control:Boolean = getPropByKey("flow_control").asInstanceOf[Boolean]
  private val max_util:Int = getPropByKey("max_util").asInstanceOf[Int]
  private val decomposer:Int = datawidth / granularity
  private val config_in_port_idx:Int = getPropByKey("config_in_port_idx")
    .asInstanceOf[Int]
  private val config_out_port_idx:List[Int] = getPropByKey("config_out_port_idx")
    .asInstanceOf[List[Int]]
  private val instructions : List[String] = getPropByKey("instructions")
    .asInstanceOf[List[String]]
  private val num_inst : Int = instructions.length
  private val num_register : Int = getPropByKey("num_register")
    .asInstanceOf[Int]
  private val max_delay_fifo_depth : Int = getPropByKey("max_delay_fifo_depth")
    .asInstanceOf[Int]

  // ------ Intermediate Variable ------
  // the max number of operand for all instruction
  private val max_num_operand : Int =
    instructions.map(i=>insts_prop(i).numOperands).max
  apply("max_num_operand", max_num_operand)
  private val max_inst_latency : Int =
    instructions.map(i=>insts_prop(i).latency).max
  apply("max_inst_latency", max_inst_latency)

  // the total config bit width
  private val conf_bit_width : Int = log2Ceil(num_inst) + max_num_operand *
      (log2Ceil(max_delay_fifo_depth) + log2Ceil(num_register + num_input))
  // config width for opcode, (delay fifo + source select) for each operand
  apply("conf_bit_width", conf_bit_width)

  // generate the config bit range
  // three things need to be controlled: alu (opcode), delay fifo, operand mux
  private var curr_low_bit : Int = 0
  private var curr_high_bit : Int = curr_low_bit
  private val opcode_bit_width : Int = log2Ceil(num_inst)
  curr_high_bit = curr_low_bit + opcode_bit_width - 1
  apply("opcode_bit_range", (curr_high_bit, curr_low_bit))
  curr_low_bit = curr_high_bit + 1
  // for each operand
  for (op_idx <- 0 until max_num_operand){
    // delay fifo
    val delay_fifo_width = log2Ceil(max_delay_fifo_depth)
    curr_high_bit = curr_low_bit + delay_fifo_width - 1
    apply("delay_" + op_idx, (curr_high_bit, curr_low_bit))
    curr_low_bit = curr_high_bit + 1
    // source select
    val source_select_width = log2Ceil(num_register + num_input)
    curr_high_bit = curr_low_bit + source_select_width - 1
    apply("source_" + op_idx, (curr_high_bit, curr_low_bit))
    curr_low_bit = curr_high_bit + 1
  }

  private val operand_select_map : mutable.Map[Int, String] =
    mutable.Map[Int,String]()
  for (in_idx <- 0 until num_input){
    operand_select_map += in_idx -> ("in-port_" + in_idx)
  }
  for (reg_idx <- 0 until num_register){
    operand_select_map += (reg_idx + num_input) -> ("reg_" + reg_idx)
  }
  apply("operand_sel2source", operand_select_map)

  // instruction encoding (get opcode)
  private val inst2enc = mutable.Map[String,Int]()
  private val enc2inst = mutable.Map[Int,String]()
  for(inst <- instructions) {
    inst2enc += inst -> instructions.indexOf(inst)
    enc2inst += instructions.indexOf(inst) -> inst
  }
  apply("inst2enc", inst2enc)
  apply("enc2inst", enc2inst)

  // ------ Create Hardware ------

  // Create the I/O port
  val io = IO(new Bundle{
    val input_ports = Flipped(Vec(num_input,Vec(decomposer,ReqAckConf_if(granularity))))
    val output_ports = Vec(num_output,Vec(decomposer,ReqAckConf_if(granularity)))
  })

  // Create register file, each fu will have at least one register (acc)
  val register_file : Vec[UInt] =
    RegInit(VecInit(Seq.fill(num_register)(0.U(datawidth.W))))

  // Create shared configuration slot
  val config_slot_file : Vec[UInt] =
    RegInit(VecInit(Seq.fill(max_util)(0.U(conf_bit_width.W))))

  // Create configuration wire
  val config_wire : UInt =
    WireInit(0.U(conf_bit_width.W))

  // Create config select pointer
  val config_select_pointer : UInt = if(max_util > 1){
    RegInit(0.U(log2Ceil(max_util).W))
  }else{
    0.U
  }

  // Create opcode select wire
  val opcode_select : UInt = WireInit(0.U(log2Ceil(num_inst).W))

  // Create operands wire, and its control protocol
  val operands : Vec[UInt] =
    WireInit(VecInit(Seq.fill(max_num_operand)(0.U(datawidth.W))))
  val operands_valid : Vec[Bool] =
    WireInit(VecInit(Seq.fill(max_num_operand)(true.B)))
  val operands_ready : Vec[Bool] =
    WireInit(VecInit(Seq.fill(max_num_operand)(true.B)))

  // Create Alu result buffer
  val alu_results : Vec[UInt] =
    WireInit(VecInit(Seq.fill(num_inst)(0.U(datawidth.W))))

  // Create output result
  val output_result : UInt = WireInit(0.U(datawidth.W))
  val output_valid : Bool = WireInit(false.B)
  val output_ready : Bool = WireInit(true.B)

  // Create latency countdown
  val latency_countdown : UInt = if(max_inst_latency > 1){
    RegInit(0.U(log2Ceil(max_inst_latency).W))
  }else{
    0.U
  }

  // Create config enable
  val config_enable : Bool = io.input_ports(config_in_port_idx)
    .map(_.config).reduce(_ && _)

  // Create delay pipe/fifo
  val delays_module = Array.fill(max_num_operand)(
    Module(new delay(datawidth, max_delay_fifo_depth, flow_control)).io
  )

  // Create operands select
  val operands_sel : IndexedSeq[UInt] = for(op_idx <- 0 until max_num_operand)
    yield{
    val source_bit_range = getPropByKey("source_" + op_idx)
      .asInstanceOf[(Int,Int)]
    config_wire(source_bit_range._1, source_bit_range._2)
  }

  // ------ Logical connections ------
  // Don't Care control protocol when not control flow
  if(!flow_control){
    for(i <- 0 until num_input;
        j <- 0 until decomposer){
      io.input_ports(i)(j).ready := DontCare
      io.input_ports(i)(j).valid := DontCare
    }
    for(i <- 0 until num_output;
        j <- 0 until decomposer){
      io.output_ports(i)(j).ready := DontCare
      io.output_ports(i)(j).valid := DontCare
    }
  }

  when(!config_enable){ // data stream
    // Config selection
    config_wire := config_slot_file(config_select_pointer)

    // update the pointer
    if(max_util > 1){
      config_select_pointer := config_select_pointer + 1.U
    }

    // operands selection, forward connect (bits and valid)
    for(op_idx <- 0 until max_num_operand){
      val source_bit_range = getPropByKey("source_" + op_idx)
          .asInstanceOf[(Int,Int)]
      val sel = operands_sel(op_idx)
      // select value to data bits
      val sel2value : Seq[(UInt,UInt)] =
        for(sel_value <- 0 until num_input + num_register)yield{
        val source : Array[String] = operand_select_map(sel_value).split("_")
        val source_type : String = source(0)
        val source_idx : Int = source(1).toInt
        val bits = source_type match {
          case "in-port" =>
            io.input_ports(source_idx).map(_.bits).reduce(Cat(_,_))
          case "reg" =>
            register_file(source_idx)
        }
        (sel_value.U,bits)
      }
      // mux incoming data bits
      operands(op_idx) := MuxLookup(sel, 0.U, sel2value)
      // if flow control, add valid
      if(flow_control){
        // mux incoming data valid
        val sel2valid : Seq[(UInt,Bool)] =
          for(sel_value <- 0 until num_input + num_register)yield{
            val source : Array[String] = operand_select_map(sel_value).split("_")
            val source_type : String = source(0)
            val source_idx : Int = source(1).toInt
            val valid = source_type match {
              case "in-port" =>
                io.input_ports(source_idx).map(_.valid).reduce(_ && _)
              case "reg" =>
                true.B
            }
            (sel_value.U,valid)
          }
        operands_valid(op_idx) := MuxLookup(sel,false.B,sel2valid)
      }else{
        operands_valid(op_idx) := DontCare
      }
    }

    // back-pressure, connect ready bit
    if(flow_control){
      for(i <- 0 until num_input;j <- 0 until decomposer) {
        io.input_ports(i)(j).ready := {
          for (op_idx <- 0 until max_num_operand) yield {
            Mux(operands_sel(op_idx) === i.U,operands_ready(op_idx),false.B)
          }
        }.reduce(_ && _)
      }
    }

    // delay configure
    for (op_idx <- 0 until max_num_operand){
      // Extract the control bit range for delay
      val delay_bit_range = getPropByKey("delay_" + op_idx)
        .asInstanceOf[(Int,Int)]
      // connect config bit
      delays_module(op_idx).delay := config_wire(delay_bit_range._1,delay_bit_range._2)
      // connect bits
      delays_module(op_idx).in.bits := operands(op_idx)
      // connect flow control logic
      if(flow_control){
        delays_module(op_idx).in.valid := operands_valid(op_idx)
        operands_ready(op_idx) := delays_module(op_idx).in.ready
      }
      // Dont Care config bit
      delays_module(op_idx).in.config := DontCare
      delays_module(op_idx).out.config := DontCare
    }

    // Alu logic
    // extract all needed bits, valid, ready
    val alu_operands : Seq[UInt] = delays_module.map(_.out.bits)
    val alu_operands_valid = delays_module.map(_.out.valid)
    val alu_operands_ready = delays_module.map(_.out.ready)

    // get opcode
    val opcode_bit_range = getPropByKey("opcode_bit_range")
        .asInstanceOf[(Int,Int)]
    opcode_select := config_wire(opcode_bit_range._1,opcode_bit_range._2)

    // fill the alu results buffer (wire)
    for (inst <- instructions){
      // Calculate all results
      val inst_idx = instructions.indexOf(inst)
      val inst_func = inst_operation(inst)
      val result = alu_results(inst_idx)
      result := inst_func(alu_operands)

      // Optional: do something else for specific instruction
    }

    // connect to output result
    val opcode2result : Seq[(UInt,UInt)]= instructions.map(i=>{
      val idx = instructions.indexOf(i)
      (idx.U, alu_results(idx))
    })
    output_result := MuxLookup(opcode_select, 0.U, opcode2result)

    // Alu Control logic
    if(flow_control){
      val all_valid = alu_operands_valid.reduce(_ && _)
      val opcode2latency = instructions.map(i=>{
        val opcode = instructions.indexOf(i)
        val lan = insts_prop(i).latency
        (opcode.U,lan.U)
      })
      when(all_valid){
        when(latency_countdown =/= 0.U){
          alu_operands_ready.foreach(r=>r := false.B)
          output_valid := false.B
          latency_countdown := latency_countdown - 1.U
        }.otherwise{
          alu_operands_ready.foreach(r=>r := true.B)
          output_valid := true.B
          latency_countdown := Mux(output_ready,
            MuxLookup(opcode_select,0.U,opcode2latency),0.U)
        }
      }
    }else{
      output_valid := DontCare
      output_ready := DontCare
      alu_operands_valid.foreach(v=>v := DontCare)
      alu_operands_ready.foreach(r=>r := DontCare)
    }

  }otherwise{
    // fu is being reset (reconfigured)

  }

  // ------ Post process ------
  override def postprocess(): Unit = ???
}
