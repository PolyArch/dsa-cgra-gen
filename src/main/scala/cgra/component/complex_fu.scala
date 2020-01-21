package cgra.component

import cgra.IO.EnabledVecDecoupledIO
import chisel3.util._
import chisel3._
import dsl.IRPrintable
import wrapper._
import cgra.config.fullinst._
import cgra.fabric.delay

import scala.collection.mutable

class complex_fu(prop:mutable.Map[String,Any]) extends Module with IRPrintable{
  // Assign initial properties
  apply(prop)

  // Derived Parameters
  private val id = getValue(getPropByKey("id")).asInstanceOf[Int]
  private val max_id = getPropByKey("max_id").asInstanceOf[Int]
  private val data_width:Int = getPropByKey("data_width").asInstanceOf[Int]
  private val granularity = getPropByKey("granularity").asInstanceOf[Int]
  private val num_input:Int = getPropByKey("num_input").asInstanceOf[Int]
  private val num_output:Int = getPropByKey("num_output").asInstanceOf[Int]
  private val flow_control:Boolean = getPropByKey("flow_control").asInstanceOf[Boolean]
  private val max_delay : Int = getPropByKey("max_delay").asInstanceOf[Int]
  private val max_util:Int = getPropByKey("max_util").asInstanceOf[Int]
  require(max_util > 0, "Switch must have utility greater than zero")
  private val decomposer:Int = data_width / granularity
  private val config_in_port_idx:Int = getPropByKey("config_in_port_idx")
    .asInstanceOf[Int]
  private val config_out_port_idx:List[Int] =
    if(getPropByKey("config_out_port_idx") == None){Nil}
    else{getPropByKey("config_out_port_idx").asInstanceOf[List[Int]]}
  private val instructions : List[String] =
    getPropByKey("instructions").asInstanceOf[List[String]]

  // Internal Defined Parameter
  private val num_opcode : Int = instructions.distinct.length + 1 // Default Pass
  private val num_operand : Int = instructions.map(insts_prop(_).numOperands) max
  private val num_config_bit : Int = log2Ceil(max_util + 1) // + 1 means at
  // least one type is needed for non-config mode (dataflow mode)

  // ------ Create Hardware ------

  // Initialize the I/O port
  val io = IO(new EnabledVecDecoupledIO(num_input, num_output,
    num_config_bit + data_width))

  // --- Internal Logic (Wire and Register) ---
  // Enable
  private val enable = io.en

  // Decode the next configuration information
  private val nxt_config_info_bits : UInt = io.input_ports(config_in_port_idx).bits
  private val nxt_config_info_valid : Bool= io.input_ports(config_in_port_idx).valid
  private val nxt_config_info = nxt_fu_config_info_wrapper(
    id, max_id,
    num_input, num_output, decomposer,flow_control,
    max_util, max_delay, data_width,
    instructions,
    nxt_config_info_bits, nxt_config_info_valid)

  // Update the configuration information when reconfigured
  private val config_file = RegInit(VecInit(Seq.fill(max_util)(0.U(nxt_config_info.num_conf_reg_bit.W))))
  private val reconfig_detected : Bool =  enable && nxt_config_info.config_enable
  private val reconfig_this : Bool = enable && nxt_config_info.config_this
  private val dataflow_mode : Bool = enable && !reconfig_detected
  private val reconfig_mode : Bool = enable && reconfig_detected
  private val num_curr_util : UInt = nxt_config_info.curr_num_util

  // Select the current configuration by Round-Robin
  // create pointer
  private val config_pointer : UInt = if(max_util > 1) {
    RegInit(0.U(log2Ceil(max_util).W))
  }else{
    0.U(1.W)
  }

  // select and parse the current config
  private val curr_config = fu_stored_config_info_wrapper(
    num_input, num_output, decomposer,flow_control,max_delay,
    instructions,
    config_file(config_pointer))

  // Create Operands Register (and its control protocol)
  private val operands : Vec[UInt] = WireInit(VecInit(
    Seq.fill(num_operand)(0.U(data_width.W))
  ))
  private val operand_valid : Bool = WireInit(Bool(), false.B)
  private val operand_ready : Bool = WireInit(Bool(), true.B)

  // Create Result Register and shift it
  private val result : UInt = WireInit(0.U(data_width.W))
  private val shifted_result: UInt = WireInit(0.U(data_width.W))
  private val result_valid : Bool = WireInit(Bool(), false.B)
  private val result_ready : Bool = WireInit(Bool(), true.B)

  // ---------- Module create and connection ----------

  // Subnet Shifter
  private val subnet_shifter = Module(new subnet_shifter(decomposer, granularity)).io
  subnet_shifter.en := dataflow_mode
  subnet_shifter.input_data := result
  subnet_shifter.offset := curr_config.offset_select
  // Shifted Result
  shifted_result := subnet_shifter.output_data

  // ALU
  private val complex_alu = Module(new complex_alu(data_width, instructions))
  complex_alu.io.en := dataflow_mode
  complex_alu.io.opcode := curr_config.opcode
  val opcode2info = complex_alu.opcode2info
  // Operand -> ALU operand
  for(op_idx <- 0 until num_operand){
    complex_alu.io.operands(op_idx) := operands(op_idx)
  }
  // Operand Valid -> ALU valid
  complex_alu.io.operand_valid := operand_valid
  // Result Ready -> ALU Ready
  complex_alu.io.result_ready := result_ready

  // Delay Pipe
  private val delay_pipes = for(op_idx <- 0 until num_operand) yield {
    // such delay is an explicit delay
    val pipe = Module(new delay(data_width, max_delay, flow_control))
    pipe.io.en := dataflow_mode
    pipe.io.delay := (if(!flow_control){
      curr_config.delay_select(op_idx)
    }else{
      DontCare
    })
    pipe.io.out.ready := operand_ready && operand_valid
    pipe
  }

  // Input Duplicator and Mux
  // Duplicate the Incoming data
  // (for broadcast to downstream and Mux back to ready)
  private val sources_dup = for(input_idx <- 0 until num_input)yield{
    val dup = Module(new duplicatorN(num_operand, data_width)).io
    dup.en := dataflow_mode
    dup.input_port.bits := io.input_ports(input_idx).bits(data_width - 1,0)
    dup.input_port.valid := io.input_ports(input_idx).valid
    // if not flow control, then always ready
    io.input_ports(input_idx).ready :=
      (if(flow_control) RegNext(dup.input_port.ready) else true.B)
    dup
  }

  // Connect Dup --> Mux --> Delay Pipe
  for(op_idx <- 0 until num_operand){
    val op_select = curr_config.operand_select(op_idx)
    val lookup = (0 to num_input).map(src_idx => {
      val bits =
        if(src_idx > 0)
          sources_dup(src_idx - 1).output_ports(op_idx).bits(data_width - 1, 0)
        else
          0.U(data_width.W)
      val valid =
        if(src_idx > 0) sources_dup(src_idx - 1).output_ports(op_idx).valid
        else true.B // Ground Input is valid input
      src_idx.U -> (bits, valid)
    })
    val pipe = delay_pipes(op_idx)
    // Route Bits
    pipe.io.in.bits := MuxLookup(op_select, 0.U, lookup.map(p=>p._1 -> p._2._1))
    // Route Valid
    pipe.io.in.valid := MuxLookup(op_select, false.B, lookup.map(p=>p._1 -> p._2._2))
    // Route Ready
    for (input_idx <- 0 until num_input){
      sources_dup(input_idx).output_ports(op_idx).ready :=
        Mux(op_select === (input_idx+1).U,pipe.io.in.ready, false.B)
    }
  }

  // Delay Pipe --> Operand
  private val opcode2num = opcode2info.map(p=>p._1 -> p._2._3)
  private val opcode2valid = opcode2num.map(op2num => {
    val op = op2num._1
    val num_operand = op2num._2
    val valids : IndexedSeq[Bool] =
      for (valid_op_idx <- 0 until num_operand) yield {
      delay_pipes(valid_op_idx).io.out.valid
    }
    op -> valids.reduce(_ && _)
  })

  // ----------- FSM ----------

  // Increase pointer
  if (max_util > 1){
    when(dataflow_mode){
      config_pointer :=
        Mux(config_pointer === num_curr_util,0.U,config_pointer + 1.U)
    }.elsewhen(reconfig_this){
      config_pointer := 0.U
    }
  }

  // Write to config file
  when(reconfig_this){
    // Use the config type to indicate which config to write
    // because config type == 1 means write to 0 config
    //         config type == 2 means write to 1 config
    //         config type == 0 means not a config mode
    // so we need to -1.U
    config_file(nxt_config_info.config_type - 1.U) :=
      nxt_config_info.config_reg_info
  }

  when(dataflow_mode){

    // ----------- Delay Pipe ------------
    val nxt_operand_valid : Bool = MuxLookup(curr_config.opcode,false.B,opcode2valid)
    // Delay Pipe -> Operands
    for(op_idx <- 0 until num_operand){
      val bits = delay_pipes(op_idx).io.out.bits
      when(nxt_operand_valid){
        operands(op_idx) := bits
      }
    }
    // Delay Pipe Valid -> Operand Valid
    operand_valid := nxt_operand_valid

    // ----------- ALU ----------------
    // ALU ready -> Operand ready
    operand_ready := complex_alu.io.operand_ready
    // ALU -> Result
    val nxt_alu_result_valid = complex_alu.io.result_valid
    when(nxt_alu_result_valid){
      result := complex_alu.io.result
    }
    // ALU Valid -> Result Valid
    result_valid := nxt_alu_result_valid

    // ----------- Output -------------
    // Output Ready -> Result Ready
    val is_broadcast = curr_config.output_select === 0.U // Broadcast to all output
    val temp_result_ready : Bool = (for(out_idx <- 0 until num_output)yield{
      val is_this = curr_config.output_select === (out_idx + 1).U
      val this_output_port_used : Bool = is_broadcast || is_this
      // Result bits -> Output bits
      io.output_ports(out_idx).bits :=
        RegNext(Mux(this_output_port_used, shifted_result, 0.U))
      // Result valid -> Output valid
      io.output_ports(out_idx).valid :=
        RegNext(Mux(this_output_port_used, result_valid, false.B))
      Mux(this_output_port_used, io.output_ports(out_idx).ready, false.B)
    }).reduce(_||_)
    result_ready := temp_result_ready

  }.elsewhen(reconfig_mode){
    // pass config info to downstream
    for(output_idx <- 0 until num_output){
      if(config_out_port_idx.contains(output_idx)){
        io.output_ports(output_idx).valid := RegNext(true.B)
        io.output_ports(output_idx).bits := RegNext(nxt_config_info_bits)
      }else{
        io.output_ports(output_idx).valid := RegNext(false.B)
        io.output_ports(output_idx).bits := RegNext(0.U)
      }
    }

  }.otherwise{
    for(output_idx <- 0 until num_output){
      io.output_ports(output_idx).valid := RegNext(false.B)
      io.output_ports(output_idx).bits := RegNext(0.U)
    }
  }

  // Post process
  def postprocess(): Unit = {
    print(this)
  }

  // ------- Debug --------
  when(reconfig_this){
    printf("----- RECONFIGURED MODE -----\n")
    printf(nxt_config_info.toPrintable)
    print_config_file
  }.elsewhen(reconfig_mode){
    printf("----- RECONFIGURED MESSAGE PASS -----\n")
    printf("reconfigured detected, but not this module\n")
  }.elsewhen(dataflow_mode){
    printf("----- DATAFLOW MODE -----\n")
    printf(p"config pointer = $config_pointer, config = ${curr_config.config_reg_info}\n")
    printf(p"-----curr config-----\n")
    printf(curr_config.toPrintable)
    printf(p"-----curr alu reg----\n")
    for(op_idx <- 0 until num_operand){
      printf(p"operand($op_idx) = ${operands(op_idx)}, ")
    }
    printf(p"operand valid = ${operand_valid}, operand ready = ${operand_ready}\n")
    printf(p"shif_result = $shifted_result, result = $result, result valid = $result_valid, result ready = $result_ready\n")
  }

  def print_config_file = {
    printf("---- config file ----\n")
    for(idx <- 0 until max_util){
      printf(p"$idx : ${config_file(idx)}\n")
    }
  }


}

object gen_comp_fu extends App{

  // Config switch
  val node = mutable.Map[String, Any]()
  val id : Int = 13
  val max_id : Int = 59
  val data_width : Int = 64
  val granularity : Int = 16
  val decomposer = data_width / granularity
  val num_input : Int = 3
  val num_output : Int = 2
  val flow_control : Boolean = true
  val max_util : Int = 1
  val max_delay : Int = 4
  val instructions : List[String] = List("Add","Mul")

  node("id") = id
  node("max_id") = max_id
  node("data_width") = data_width
  node("granularity") = granularity
  node("num_input") = num_input
  node("num_output") = num_output
  node("flow_control") = flow_control
  node("max_util") = max_util
  node("max_delay") = max_delay
  node("config_in_port_idx") = 0
  node("config_out_port_idx") = List(0)
  node("instructions") = instructions

  chisel3.Driver.execute(args,()=>{
    val module = new complex_fu(node)
    println(module)
    module
  })
}