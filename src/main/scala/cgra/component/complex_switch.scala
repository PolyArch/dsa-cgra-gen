package cgra.component

import cgra.IO._
import cgra.fabric.delay
import chisel3.util._
import chisel3._
import dsl.IRPrintable

import scala.collection.mutable
import scala.util.Random
import common.wrapper._

class complex_switch(prop:mutable.Map[String,Any]) extends Module
  with IRPrintable{
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
  private val max_util:Int =
    if(getPropByKey("flow_control") == None) 1
    else getPropByKey("max_util").asInstanceOf[Int]
  require(max_util > 0, "Switch must have utility greater than zero")
  private val decomposer:Int = data_width / granularity
  private val config_in_port_idx:Int = getPropByKey("config_in_port_idx")
    .asInstanceOf[Int]
  private val config_out_port_idx:List[Int] =
    if(getPropByKey("config_out_port_idx") == None){Nil}
    else{getPropByKey("config_out_port_idx").asInstanceOf[List[Int]]}

  // Internal Defined Parameter
  private val num_config_bit : Int = log2Ceil(max_util + 1) // + 1 means at
  // least one type is needed for non-config mode (dataflow mode)
  private val max_delay : Int = if(flow_control){
    if(getPropByKey("max_delay")== None) 2
    else getPropByKey("max_delay").asInstanceOf[Int]
  }else{
    1
  }

  this.suggestName(s"switch_id_${id}")

  // ------ Create Hardware ------

  // Initialize the I/O port
  val io = IO(new EnabledVecDecoupledIO(num_input, num_output, 1 + data_width))
  // one more for control bit

  // --- Internal Logic ---
  // Enable
  private val enable = io.en

  // Decode the next configuration information
  private val nxt_config_info_bits : UInt = io.input_ports(config_in_port_idx).bits
  private val nxt_config_info_valid : Bool= io.input_ports(config_in_port_idx).valid
  private val nxt_config_info = nxt_switch_config_info_wrapper(
    id, num_node,
    num_input, num_output, decomposer,
    max_util, data_width,
    RegNext(nxt_config_info_bits), RegNext(nxt_config_info_valid))

  // Update the configuration information when reconfigured
  val config_file = RegInit(VecInit(Seq.fill(max_util)(0.U(nxt_config_info.num_conf_reg_bit.W))))
  val reconfig_mode : Bool =  enable && nxt_config_info.config_enable
  val reconfig_this : Bool = reconfig_mode && nxt_config_info.config_this
  val dataflow_mode : Bool = enable && !reconfig_mode
  when(reconfig_this){
    // Use the config type to indicate which config to write
    config_file(nxt_config_info.config_idx) :=
      nxt_config_info.config_reg_info
  }
  val curr_util : UInt =
    RegEnable(nxt_config_info.curr_num_util, 0.U, reconfig_this)
  curr_util.suggestName("curr_util")

  // Select the configuration by Round-Robin
  val config_pointer : UInt = if(max_util > 1) {
    RegInit(0.U(log2Ceil(max_util).W))
  }else{
    0.U(1.W)
  }
  if (max_util > 1){
    when(dataflow_mode){
      config_pointer :=
        Mux(config_pointer === curr_util,0.U,config_pointer + 1.U)
    }.elsewhen(reconfig_this){
      config_pointer := 0.U
    }
  }

  private val curr_config = switch_stored_config_info_wrapper(
    num_input, num_output, decomposer,
    config_file(config_pointer))

  // Duplicate the Incoming data (for broadcast to downstream)
  private val sources_dup = for(input_idx <- 0 until num_input)yield{
    val dup = Module(new duplicatorN(num_output, data_width)).io
    dup.en := dataflow_mode
    dup.input_port.bits := io.input_ports(input_idx).bits
    dup.input_port.valid := io.input_ports(input_idx).valid
    io.input_ports(input_idx).ready := {
      if(flow_control){
        RegNext(dup.input_port.ready)
      }else{
        true.B// if not flow control, then always ready
      }
    }
    dup
  }

  // Add buffer for output
  private val buffers = for(_ <- 0 until num_output) yield {
    val buff = Module(new delay(data_width, max_delay, flow_control)).io
    buff.en := dataflow_mode
    if(flow_control){
      buff.delay := DontCare
    }else{
      buff.delay := 0.U
    }
    buff
  }

  // Shift the output for subnet connection
  private val subnet_shifter = for(output_idx <- 0 until num_output)yield{
    val sub_shift = Module(new subnet_shifter(decomposer, granularity)).io
    sub_shift.en := dataflow_mode
    sub_shift.offset := RegNext(curr_config.offset_select(output_idx))
    sub_shift
  }

  // Route the Ready
  for(input_idx <- 0 until num_input;
      output_idx <- 0 until num_output){
    val source_select = curr_config.sources_select(output_idx)
    // If the output port do receive value from this input port,
    // then pass the ready otherwise, it is just ready (true)
    when(dataflow_mode){
      sources_dup(input_idx).output_ports(output_idx).ready :=
        Mux(source_select === (input_idx + 1).U,
          buffers(output_idx).in.ready,
          //io.output_ports(output_idx).ready,
          false.B)
    }otherwise{
      sources_dup(input_idx).output_ports(output_idx).ready := true.B
    }
  }
  // Ready
  for (output_idx <- 0 until num_output){
    buffers(output_idx).out.ready := io.output_ports(output_idx).ready
  }

  // Route the Valid, Data Bits and Config Bits
  for(output_idx <- 0 until num_output){
    // select -> (valid, data bits, config bits)
    val lookup : Seq[(UInt, (Bool, UInt))]= (0 to num_input).map(x=>{
      if(x == 0){
        // Connect to Ground when zero
        x.U -> (false.B, 0.U)
      }else{
        x.U -> (
          // valid bit
          sources_dup(x-1).output_ports(output_idx).valid,
          // data info
          sources_dup(x-1).output_ports(output_idx).bits(data_width - 1, 0)
        )
      }
    })
    // buffer
    buffers(output_idx).in.valid :=
      MuxLookup(curr_config.sources_select(output_idx),false.B,
        lookup.map(x=>x._1 -> x._2._1))
    buffers(output_idx).in.bits :=
      MuxLookup(curr_config.sources_select(output_idx),0.U,
        lookup.map(x=>x._1 -> x._2._2))
    // subnet shift
    subnet_shifter(output_idx).input_data := buffers(output_idx).out.bits

    // State Machine
    when(dataflow_mode){
      // Valid
      io.output_ports(output_idx).valid :=
        RegNext(buffers(output_idx).out.valid)
      // Bits
      io.output_ports(output_idx).bits :=
        RegNext(subnet_shifter(output_idx).output_data)
    }.elsewhen(reconfig_mode){
      // pass value to downstream
      if(config_out_port_idx.contains(output_idx)){
        io.output_ports(output_idx).valid := true.B
        io.output_ports(output_idx).bits := nxt_config_info_bits
      }else{
        io.output_ports(output_idx).valid := false.B
        io.output_ports(output_idx).bits := 0.U
      }
    }.otherwise{
      io.output_ports(output_idx).valid := false.B
      io.output_ports(output_idx).bits := 0.U
    }
  }

  // Post process
  def postprocess(): Unit = {
    print(this)
  }

  //  ----- Debug -----
  when(reconfig_this){
    //printf(nxt_config_info.toPrintable)
    //print_config_file
  }

  def print_config_file = {
    printf(" ---- config file ---- \n")
    for(idx <- 0 until max_util){
      printf(p"$idx : ${config_file(idx)}\n")
    }
  }

  // println(prop)

}

object gen_comp_switch extends App{

  // Config switch
  val node = mutable.Map[String, Any]()
  val id : Int = 0
  val num_node : Int = 44
  val data_width : Int = 64
  val granularity : Int = 64
  val num_input : Int = 4
  val num_output : Int = 3
  val flow_control : Boolean = false
  val max_util : Int = 1
  val max_delay : Int = 1

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

  chisel3.Driver.execute(args,()=>{
    val module = new complex_switch(node)
    println(module)
    module
  })
}