
package cgra.fabric.Shared_PE_component.common.datapath

import cgra.config.fullinst.{inst_operation, insts_prop}
import cgra.config.inst_prop
import cgra.fabric.Shared_PE_component.common.Instructions.Instructions
import cgra.fabric.Shared_PE_component.datapath.floatpoint._
import cgra.fabric.Shared_PE_component.tia_parameters.derived_parameters._
import cgra.fabric.Shared_PE_component.tia_parameters.fixed_parameters._
import chisel3._
import chisel3.util._

import scala.collection.mutable.ListBuffer

class arithmetic_logic_unit extends Module
  with Instructions{
  val word_width : Int = TIA_WORD_WIDTH
  val inst_list : List[String] = Instructions
  val op_width = log2Ceil(inst_list.length)

  val io = IO(
    new Bundle {
      val opcode = Input(UInt(op_width.W))
      val operands = Input(Vec(TIA_NUM_OPERANDS,UInt(word_width.W)))
      val result = Output(UInt(word_width.W))
    }
  )

  val operation_func = inst_list.map(f=>inst_operation(f))
  val inst_props = inst_list.map(f=>insts_prop(f))
  val result_buffer : Vec[UInt] = Wire(Vec(inst_list.length,UInt(word_width.W)))
  for (idx_opcode <- inst_list.indices){
    val op_func = operation_func(idx_opcode)
    val inst_prop = inst_props(idx_opcode)
    val result = alu_result(inst_prop,op_func)
    result_buffer(idx_opcode) := result
  }

  io.result := result_buffer(io.opcode)

  // Util
  def alu_result (inst_prop:inst_prop, func:(UInt*) => UInt) : UInt ={
    val num_op = inst_prop.numOperands
    val result:UInt = num_op match {
      case 1 => func(io.operands(0))
      case 2 => func(io.operands(0),io.operands(1))
      case 3 => func(io.operands(0),io.operands(1),io.operands(2))
    }
    result
  }
}
/*
object AluDriver extends App
{
  chisel3.Driver.execute(args, () => new arithmetic_logic_unit(64,List(1,3,4,6,7,9,10)))
}
*/