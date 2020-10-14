package cgra.component

import cgra.IO.EnabledVecDecoupledIO
import chisel3.util._
import chisel3._
import dsl.IRPrintable
import common.wrapper._
import cgra.config.fullinst._
import cgra.fabric.delay

import scala.collection.mutable

class complex_fu(prop:mutable.Map[String,Any]) extends Module with IRPrintable{
  // Assign initial properties
  apply(prop)

  // Derived Parameters
  private val id = getValue(getPropByKey("id")).asInstanceOf[Int]
  private val num_node = getPropByKey("num_node").asInstanceOf[Int]
  private val data_width:Int = getPropByKey("data_width").asInstanceOf[Int]
  private val granularity = getPropByKey("granularity").asInstanceOf[Int]
  private val num_input:Int = getPropByKey("num_input").asInstanceOf[Int]
  private val num_output:Int = getPropByKey("num_output").asInstanceOf[Int]
  private val flow_control:Boolean = {
    if(getPropByKey("flow_control") == None) true
    else getPropByKey("flow_control").asInstanceOf[Boolean]
  }
  private val max_delay : Int = if(flow_control){
    if(getPropByKey("max_delay")== None) 2
    else getPropByKey("max_delay").asInstanceOf[Int]
  }else{
    1
  }
  private val max_util:Int =
    if(getPropByKey("flow_control") == None) 1
    else getPropByKey("max_util").asInstanceOf[Int]
  require(max_util > 0, "FU must have utility greater than zero")
  private val decomposer:Int = data_width / granularity
  private val config_in_port_idx:Int = getPropByKey("config_in_port_idx")
    .asInstanceOf[Int]
  private val config_out_port_idx:List[Int] =
    getPropByKey("config_out_port_idx") match {
      case None => Nil
      case list : List[Int] => list
    }
  private val register_file_size:Int =
    getPropByKey("register_file_size") match {
      case None => 0
      case x : Int => x
    }
  private val instructions : List[String] = {
    if(getPropByKey("instruction") != None){
      getPropByKey("instruction").asInstanceOf[List[String]]
    }else if(getPropByKey("instructions") != None){
      getPropByKey("instructions").asInstanceOf[List[String]]
    }else{
      require(false, "insstructions not defined")
      List("")
    }
  }

  this.suggestName(s"function_unit_id_${id}")

  // Internal Defined Parameter
  private val num_opcode : Int = instructions.distinct.length + 1 // Default Pass
  private val num_operand : Int = instructions.map(insts_prop(_).numOperands) max
  private val num_config_bit : Int = log2Ceil(max_util) // + 1 means at
  // least one type is needed for non-config mode (dataflow mode)

  // ------ Create Hardware ------

  // Initialize the I/O port
  val io = IO(new EnabledVecDecoupledIO(num_input, num_output, 1 + data_width))

  // --- Internal Logic (Wire and Register) ---
  // Enable
  private val enable = RegNext(io.en)

  // Decode the next configuration information
  val nxt_config_info_bits : UInt = io.input_ports(config_in_port_idx).bits
  val nxt_config_info_valid : Bool= io.input_ports(config_in_port_idx).valid

  val nxt_config_info = nxt_fu_config_info_wrapper(
    id, num_node,
    num_input + register_file_size,
    num_output + register_file_size,
    decomposer,flow_control,
    max_util, max_delay, data_width,
    instructions,
    RegNext(nxt_config_info_bits).suggestName("nxt_config_info_bits"),
    RegNext(nxt_config_info_valid).suggestName("nxt_config_info_valid"))

  // Update the configuration information when reconfigured
  val config_file = RegInit(VecInit(Seq.fill(max_util)(0.U(nxt_config_info.num_conf_reg_bit.W))))
  val reconfig_mode : Bool =  enable && nxt_config_info.config_enable
  val reconfig_this : Bool = reconfig_mode && nxt_config_info.config_this
  val dataflow_mode : Bool = enable && !reconfig_mode
  private val curr_config_util : UInt =
    RegEnable(nxt_config_info.curr_num_util, 0.U, reconfig_this)
      .suggestName("curr_config_util")

  // Select the current configuration by Round-Robin
  // create pointer
  val config_pointer : UInt = if(max_util > 1) {
    RegInit(0.U(log2Ceil(max_util).W))
  }else{
    0.U(1.W)
  }

  // Register File
  val register_file : Vec[UInt] = RegInit(
    if(register_file_size > 0){
      VecInit(Seq.fill(register_file_size)(0.U(data_width.W)))
    }else{
      VecInit(Seq.fill(1)(0.U(1.W)))
    }).suggestName("register_file")

  // select and parse the current config
  val curr_config = fu_stored_config_info_wrapper(
    num_input + register_file_size,
    num_output + register_file_size,
    decomposer,flow_control,max_delay,
    instructions,
    config_file(config_pointer))

  // Create Operands Register (and its control protocol)
  val operands : Vec[UInt] = WireInit(VecInit(
    Seq.fill(num_operand)(0.U(data_width.W))
  )).suggestName("operands")
  val operand_valid : Bool = WireInit(Bool(), false.B)
    .suggestName("operand_valid")
  val operand_ready : Bool = WireInit(Bool(), true.B)
    .suggestName("operand_ready")

  // Create Result Register and shift it
  val result : UInt = WireInit(0.U(data_width.W))
    .suggestName("result")
  val shifted_result: UInt = WireInit(0.U(data_width.W))
    .suggestName("shifted_result")
  val result_valid : Bool = WireInit(Bool(), false.B)
    .suggestName("result_valid")
  val result_ready : Bool = WireInit(Bool(), true.B)
    .suggestName("result_ready")

  // ---------- Module create and connection ----------

  // Subnet Shifter
  private val subnet_shifter =
    Module(new subnet_shifter(decomposer, granularity))
  subnet_shifter.io.en := dataflow_mode
  subnet_shifter.io.input_data := result
  subnet_shifter.io.offset := curr_config.offset_select
  // Shifted Result
  shifted_result := subnet_shifter.io.output_data

  // ALU
  private val complex_alu =
    Module(new complex_alu(data_width, instructions))
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
    pipe.io.out.ready := operand_ready
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
    val lookup = (0 to (num_input+register_file_size)).map(src_idx => {
      val bits =
      // The reason that we need `RegNext` here is source select is based on
      // current config, which is register based
        if(src_idx > num_input)
          // read from register
          register_file(src_idx - (num_input + 1))
        else if(src_idx > 0)
          // read from input ports
          RegNext(sources_dup(src_idx - 1).output_ports(op_idx).bits(data_width - 1, 0))
        else
          0.U(data_width.W)
      val valid =
        if(src_idx > num_input)
          // register File is valid input
          true.B
        else if(src_idx > 0)
          RegNext(sources_dup(src_idx - 1).output_ports(op_idx).valid)
        else
          true.B // Ground Input is valid input
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
        Mux(config_pointer === curr_config_util,0.U,config_pointer + 1.U)
    }.elsewhen(reconfig_this){
      config_pointer := 0.U
    }
  }

  // Write to config file
  when(reconfig_this){
    // Use the config type to indicate which config to write
    config_file(nxt_config_info.config_idx) :=
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

    // Write to Register
    if(register_file_size > 0){
      val is_write_reg : Bool = (curr_config.output_select > num_output.U)
        .suggestName("is_write_reg")
      val write_reg_idx : UInt = (curr_config.output_select - (num_output + 1).U)
        .suggestName("write_reg_idx")
      when(result_valid && is_write_reg){
        register_file(write_reg_idx) := shifted_result
      }
    }

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
}

object gen_comp_fu extends App{

  // Config switch
  val node = mutable.Map[String, Any]()
  val id : Int = 13
  val num_node : Int = 59
  val data_width : Int = 64
  val granularity : Int = 16
  val decomposer = data_width / granularity
  val num_input : Int = 3
  val num_output : Int = 2
  val flow_control : Boolean = true
  val max_util : Int = 1
  val max_delay : Int = 4
  val reg_file_size : Int = 16
  val instructions : List[String] = List("Add","Mul")

  node("id") = id
  node("num_node") = num_node
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
  node("register_file_size") = reg_file_size

  chisel3.Driver.execute(args,()=>{
    val module = new complex_fu(node)
    println(module)
    module
  })
}