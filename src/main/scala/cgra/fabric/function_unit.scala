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

  // the total config bit width
  private val conf_bit_width : Int = log2Ceil(num_inst) + max_num_operand *
      (log2Ceil(max_delay_fifo_depth) + log2Ceil(num_register + num_input))
  // config for opcode, (delay fifo + source select) for each operand
  apply("conf_bit_width", conf_bit_width)

  // ------ Create Hardware ------

  // Create the I/O port
  val io = IO(new Bundle{
    val input_ports = Flipped(Vec(num_input,Vec(decomposer,ReqAckConf_if(granularity))))
    val output_ports = Vec(num_output,Vec(decomposer,ReqAckConf_if(granularity)))
  })

  // Create register file
  val register_file : Vec[UInt] =
    RegInit(VecInit(Seq.fill(num_register)(0.U(datawidth.W))))

  // Create shared configuration slot
  val config_slot_file : Vec[UInt] =
    RegInit(VecInit(Seq.fill(max_util)(0.U(conf_bit_width.W))))

  // Create opcode select wire
  val opcode_select : UInt = Wire(0.U(log2Ceil(num_inst).W))

  // ------ Post process ------
  override def postprocess(): Unit = ???
}
