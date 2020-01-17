package cgra.component

import cgra.IO.EnabledVecDecoupledIO
import chisel3.util.log2Ceil
import chisel3._
import dsl.IRPrintable
import wrapper._
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
  private val num_instruction : Int = instructions.distinct.length
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
  private val nxt_config_info = nxt_fu_config_info_wrapper(
    id, max_id,
    num_input, num_output, decomposer,
    max_util, data_width,
    instructions,
    nxt_config_info_bits, nxt_config_info_valid)

  // Update the configuration information when reconfigured
  val config_file = RegInit(VecInit(Seq.fill(max_util)(0.U(nxt_config_info.num_conf_reg_bit.W))))
  val reconfig_detected : Bool =  nxt_config_info.config_enable
  val reconfig_this : Bool = nxt_config_info.config_this
  val dataflow_mode : Bool = enable && !reconfig_detected
  val reconfig_mode : Bool = enable && reconfig_detected

  // Post process
  def postprocess(): Unit = {
    print(this)
  }

}
