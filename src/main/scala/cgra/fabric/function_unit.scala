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

  // Create operands wire
  val operands : Vec[UInt] = WireInit(VecInit(Seq.fill(max_num_operand)(0.U(datawidth.W))))

  // Create config enable
  val config_enable : Bool = io.input_ports(config_in_port_idx).map(_.config).reduce(_ && _)

  // ------ Logical connections ------
  when(!config_enable){
    // Config selection
    config_wire := config_slot_file(config_select_pointer)

    // update the pointer
    if(max_util > 1){
      config_select_pointer := config_select_pointer + 1.U
    }

    // operands selection
    for(op_idx <- 0 until max_num_operand){
      val source_bit_range = getPropByKey("source_" + op_idx)
          .asInstanceOf[(Int,Int)]
      val sel = config_wire(source_bit_range._1, source_bit_range._2)
      val sel2value : Seq[(UInt,UInt)] =
        for(sel_value <- 0 until num_input + num_register)yield{
        val source : String = operand_select_map(sel_value)
        val source_type = source(0)
        val source_idx = source(1).toInt
        val bits = source match {
          case "in-port" =>
            io.input_ports(source_idx).map(_.bits).reduce(Cat(_,_))
          case "reg" =>
            register_file(source_idx)
        }
        (sel_value.U,bits)
      }
      operands(op_idx) := MuxLookup(sel, 0.U, sel2value)
    }
  }otherwise{

  }

  // ------ Post process ------
  override def postprocess(): Unit = ???
}
