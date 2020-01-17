package cgra.component

import cgra.IO._
import chisel3.util._
import chisel3._
import dsl.IRPrintable
import scala.collection.mutable
import scala.util.Random

class complex_switch(prop:mutable.Map[String,Any]) extends Module with IRPrintable{
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
  private val max_util:Int = getPropByKey("max_util").asInstanceOf[Int]
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

  // ------ Create Hardware ------

  // Initialize the I/O port
  val io = IO(new EnabledVecDecoupledIO(num_input, num_output,
    num_config_bit + data_width))

  // --- Internal Logic ---
  // Enable
  private val enable = io.en

  // Decode the next configuration information
  private val nxt_config_info_bits : UInt = io.input_ports(config_in_port_idx).bits
  private val nxt_config_info_valid : Bool= io.input_ports(config_in_port_idx).valid
  private val nxt_config_info = nxt_switch_config_info_wrapper(
    id, max_id,
    num_input, num_output, decomposer,
    num_config_bit, data_width,
    nxt_config_info_bits, nxt_config_info_valid)

  // Update the configuration information when reconfigured
  val config_file = RegInit(VecInit(Seq.fill(max_util)(0.U(nxt_config_info.num_conf_reg_bit.W))))
  val reconfig_detected : Bool =  nxt_config_info.config_enable
  val reconfig_this : Bool = nxt_config_info.config_this
  val dataflow_mode : Bool = enable && !reconfig_detected
  val reconfig_mode : Bool = enable && reconfig_detected
  when(reconfig_this){
    // Use the config type to indicate which config to write
    // because config type == 1 means write to 0 config
    //         config type == 2 means write to 1 config
    //         config type == 0 means not a config mode
    // so we need to -1.U
    config_file(nxt_config_info.config_type - 1.U) :=
      nxt_config_info.config_reg_info
  }
  val num_curr_util : UInt =
    RegEnable(nxt_config_info.curr_num_util, 0.U, reconfig_this)

  // Select the configuration by Round-Robin
  val config_pointer : UInt = if(max_util > 1) {
    RegInit(0.U(log2Ceil(max_util).W))
  }else{
    0.U(1.W)
  }
  if (max_util > 1){
    when(dataflow_mode){
      config_pointer :=
        Mux(config_pointer === num_curr_util,0.U,config_pointer + 1.U)
    }.elsewhen(reconfig_this){
      config_pointer := 0.U
    }
  }

  private val curr_config = stored_config_info_wrapper(
    num_input, num_output, decomposer,
    config_file(config_pointer))

  // Duplicate the Incoming data (for broadcast to downstream)
  private val sources_dup = for(input_idx <- 0 until num_input)yield{
    val dup = Module(new duplicatorN(num_output, num_config_bit + data_width)).io
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

  // Shift the output for subnet connection
  private val subnet_shifter = for(output_idx <- 0 until num_output)yield{
    val sub_shift = Module(new subnet_shifter(decomposer, granularity)).io
    sub_shift.en := dataflow_mode
    sub_shift.offset := curr_config.offset_select(output_idx)
    sub_shift
  }

  // Route the Ready
  for(input_idx <- 0 until num_input;
      output_idx <- 0 until num_output){
    // If the output port do receive value from this input port,
    // then pass the ready otherwise, it is just ready (true)
    when(dataflow_mode){
      sources_dup(input_idx).output_ports(output_idx).ready :=
        Mux(curr_config.sources_select(output_idx) === input_idx.U,
          io.output_ports(output_idx).ready, true.B)
    }otherwise{
      sources_dup(input_idx).output_ports(output_idx).ready := true.B
    }
  }

  // Route the Valid, Data Bits and Config Bits
  for(output_idx <- 0 until num_output){
    // select -> (valid, data bits, config bits)
    val lookup = (0 to num_input).map(x=>{
      if(x == 0){
        // Connect to Ground when zero
        x.U -> (false.B, 0.U, 0.U)
      }else{
        x.U -> (
          // valid bit
          sources_dup(x-1).output_ports(output_idx).valid,
          // data info
          sources_dup(x-1).output_ports(output_idx).bits(data_width - 1, 0),
          // config info
          sources_dup(x-1).output_ports(output_idx).bits(data_width + num_config_bit - 1, data_width)
        )
      }
    })
    // subnet shift
    subnet_shifter(output_idx).input_data :=
      MuxLookup(curr_config.sources_select(output_idx),0.U,
        lookup.map(x=>x._1 -> x._2._2))
    // extract config bit
    val config_bits = MuxLookup(curr_config.offset_select(output_idx),0.U,
      lookup.map(x=>x._1 -> x._2._3))

    // State Machine
    when(dataflow_mode){
      // Valid
      io.output_ports(output_idx).valid := RegNext(
        MuxLookup(curr_config.offset_select(output_idx),false.B,
          lookup.map(x=>x._1 -> x._2._1))
      )
      // Bits
      io.output_ports(output_idx).bits := RegNext(
        Cat(config_bits, subnet_shifter(output_idx).output_data)
      )
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
      io.output_ports(output_idx).valid := RegNext(false.B)
      io.output_ports(output_idx).bits := RegNext(0.U)
    }
  }

  // Post process
  def postprocess(): Unit = {
    print(this)
  }

  //  ----- Debug -----
  when(reconfig_this){
    printf(nxt_config_info.toPrintable)
  }


}

case class stored_config_info_wrapper(num_input: Int, num_output: Int,
                                      decomposer: Int,
                                      curr_config_info: UInt){
  private var curr_high_bit : Int = curr_config_info.getWidth - 1
  private val high_bit : Int = curr_high_bit

  // Sources Info
  private val num_source_sel_bit : Int = log2Ceil(num_input + 1)
  // Add default ground input when select value is zero
  val sources_select : IndexedSeq[UInt] =
    for(_ <- 0 until num_output) yield{
      val info = curr_config_info(curr_high_bit, curr_high_bit - num_source_sel_bit + 1)
      curr_high_bit -= num_source_sel_bit
      info
    }

  // Offset Info
  val num_offset_bit : Int = log2Ceil(decomposer)
  val offset_select : IndexedSeq[UInt] =
    for(_ <- 0 until num_output) yield{
      if(decomposer > 1){
        val info = curr_config_info(curr_high_bit, curr_high_bit - num_offset_bit + 1)
        curr_high_bit -= num_offset_bit
        info
      }else{
        0.U
      }
    }

  // Used Bit
  val num_conf_reg_bit : Int = high_bit - curr_high_bit
  val config_reg_info : UInt = curr_config_info(high_bit, curr_high_bit + 1)

  implicit def toPrintable: Printable = {
    val out_off_sel_print = for(out_idx <- 0 until num_output) yield {
      p"Out $out_idx src = ${sources_select(out_idx)}, " +
        p"off = ${offset_select(out_idx)} "
    }
    out_off_sel_print.reduceLeft(_ + p"\n" + _) + p"\n"
  }
}

case class nxt_switch_config_info_wrapper(id: Int, num_node: Int,
                                          num_input: Int, num_output: Int,
                                          decomposer: Int,
                                          num_config_bit: Int,
                                          data_width: Int,
                                          config_info: UInt, config_valid: Bool){
  private var curr_high_bit : Int = data_width + num_config_bit - 1

  // ------ Identifier Information ------

  // Configuration Status
  val config_type : UInt =
    config_info(curr_high_bit, curr_high_bit - num_config_bit + 1)
  curr_high_bit -= num_config_bit

  val curr_num_util : UInt =
    config_info(curr_high_bit, curr_high_bit - num_config_bit + 1)
  curr_high_bit -= num_config_bit

  // Node ID
  require(num_node > 1)
  private val num_id_bit : Int = log2Ceil(num_node)
  val node_id : UInt = config_info(curr_high_bit, curr_high_bit - num_id_bit + 1)
  val config_enable : Bool = (config_type =/= 0.U) && config_valid
  val config_this : Bool = config_enable && node_id === id.U
  curr_high_bit -= num_id_bit

  // ------ Stored Information ------
  private val stored_high_bit : Int = curr_high_bit

  private val stored_config_info = stored_config_info_wrapper(
    num_input,num_output,decomposer, config_info(stored_high_bit,0))

  // Total config bit info
  val num_conf_reg_bit : Int = stored_config_info.num_conf_reg_bit
  val config_reg_info : UInt = stored_config_info.config_reg_info
  println("num conf reg bit = " + num_conf_reg_bit)
  println("stored config info width = " + config_reg_info.getWidth)
  require(config_reg_info.getWidth == num_conf_reg_bit)

  implicit def toPrintable : Printable ={
    p"switch $id: config type = $config_type, curr_num_util = $curr_num_util, " +
      p"id_field = $node_id\n" + stored_config_info.toPrintable
  }
}

object gen_comp_switch extends App{

  val node = mutable.Map[String, Any]()
  node("id") = 13
  node("max_id") = 59
  node("data_width") = 64
  node("granularity") = 16
  node("num_input") = 4
  node("num_output") = 5
  node("flow_control") = true
  node("max_util") = 3

  // Add config input / output port for test
  val num_input = node("num_input").asInstanceOf[Int]
  val num_output = node("num_output").asInstanceOf[Int]
  node += "config_in_port_idx" -> (num_input - 1)
  val rand = new Random()
  if(rand.nextBoolean() && num_output == 1){
    node += "config_out_port_idx" -> List(0)
  }else{
    node += "config_out_port_idx" -> List(0, num_output - 1)
  }

  chisel3.Driver.execute(args,()=>{
    val module = new complex_switch(node)
    println(module)
    module
  })
}