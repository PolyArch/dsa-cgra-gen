package cgra.component

import chisel3.util._
import chisel3._
import cgra.config.fullinst._

object wrapper {
  case class switch_stored_config_info_wrapper(num_input: Int, num_output: Int,
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
                                            max_util: Int,
                                            data_width: Int,
                                            config_info: UInt, config_valid: Bool){
    private val num_config_bit : Int = log2Ceil(max_util + 1)
    private var curr_high_bit : Int = data_width + num_config_bit - 1

    // ------ Identifier Information ------

    // Configuration Status
    val config_type : UInt =
      config_info(curr_high_bit, curr_high_bit - num_config_bit + 1)
    curr_high_bit -= num_config_bit

    val curr_num_util : UInt =
      if (max_util > 1){
        val curr_util = config_info(curr_high_bit, curr_high_bit - num_config_bit + 1)
        curr_high_bit -= num_config_bit
        curr_util
      }else{
        0.U(1.W)
      }

    // Node ID
    require(num_node > 1)
    private val num_id_bit : Int = log2Ceil(num_node)
    val node_id : UInt = config_info(curr_high_bit, curr_high_bit - num_id_bit + 1)
    val config_enable : Bool = (config_type =/= 0.U) && config_valid
    val config_this : Bool = config_enable && node_id === id.U
    curr_high_bit -= num_id_bit

    // ------ Stored Information ------
    private val stored_high_bit : Int = curr_high_bit

    private val stored_config_info = switch_stored_config_info_wrapper(
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

  case class nxt_fu_config_info_wrapper(id: Int, num_node: Int,
                                        num_input: Int, num_output: Int,
                                        decomposer: Int,
                                        max_util: Int,
                                        data_width: Int,
                                        instructions : List[String],
                                        config_info: UInt, config_valid: Bool){
    private val num_instruction : Int = instructions.distinct.length
    private val num_config_bit : Int = log2Ceil(max_util + 1)
    private var curr_high_bit : Int = data_width + num_config_bit - 1

    // ------ Identifier Information ------

    // Configuration Status
    val config_type : UInt =
      config_info(curr_high_bit, curr_high_bit - num_config_bit + 1)
    curr_high_bit -= num_config_bit

    val curr_num_util : UInt =
      if (max_util > 1){
        val info = config_info(curr_high_bit, curr_high_bit - num_config_bit + 1)
        curr_high_bit -= num_config_bit
        info
      }else{
        0.U(1.W)
      }

    // Node ID
    require(num_node > 1)
    private val num_id_bit : Int = log2Ceil(num_node)
    val node_id : UInt = config_info(curr_high_bit, curr_high_bit - num_id_bit + 1)
    val config_enable : Bool = (config_type =/= 0.U) && config_valid
    val config_this : Bool = config_enable && node_id === id.U
    curr_high_bit -= num_id_bit

    // ------ Stored Information ------
    private val stored_high_bit : Int = curr_high_bit

    private val stored_config_info = fu_stored_config_info_wrapper(
      num_input,num_output,decomposer,instructions,
      config_info(stored_high_bit,0)
    )
  }

  case class fu_stored_config_info_wrapper(num_input: Int, num_output: Int,
                                           decomposer: Int,
                                           instructions : List[String],
                                           curr_config_info: UInt){
    private var curr_high_bit : Int = curr_config_info.getWidth - 1
    private val num_opcode : Int = instructions.distinct.length
    private val high_bit : Int = curr_high_bit
    private val max_num_operand : Int =
      instructions.map(insts_prop(_).numOperands) max

    // Operands select
    private val num_operand_sel_bit : Int = log2Ceil(num_input + 1)
    // Add default ground input when select value is zero
    val operand_select : IndexedSeq[UInt] =
      for(_ <- 0 until max_num_operand) yield {
        val info = curr_config_info(curr_high_bit,
          curr_high_bit - num_operand_sel_bit + 1)
        curr_high_bit -= num_operand_sel_bit
        info
      }

    // Opcode select
    private val num_opcode_bit : Int = log2Ceil(num_opcode + 1)
    // One more operation added for doing nothing
    val opcode : UInt = curr_config_info(curr_high_bit,
      curr_high_bit - num_opcode_bit + 1)
    curr_high_bit -= num_opcode_bit

    // Output select
    private val num_output_bit : Int = log2Ceil(num_output + 1)
    // One more output direction (broadcast to all output port)
    val output_select : UInt = curr_config_info(
      curr_high_bit,curr_high_bit - num_output_bit + 1)
    curr_high_bit -= num_output_bit

    // Offset select
    private val num_offset_bit : Int = log2Ceil(decomposer)
    val offset_select : UInt = curr_config_info(
      curr_high_bit, curr_high_bit - num_offset_bit + 1)
    curr_high_bit -= num_offset_bit

    // Used Bit
    val num_conf_reg_bit : Int = high_bit - curr_high_bit
    val config_reg_info : UInt = curr_config_info(high_bit, curr_high_bit + 1)

    implicit def toPrintable: Printable = {
      val operand_sel_print = for(oper_idx <- 0 until max_num_operand) yield {
        p"op$oper_idx = ${operand_select(oper_idx)}"
      }
      operand_sel_print.reduceLeft(_ + p", " + _) + p", "
        p"opcode = $opcode, output = $output_select, offset = $offset_select\n"
    }
  }

}
