package cgra.fabric.Trig_PE_component.datapath

import cgra.fabric.Trig_PE_component.tia_parameters.derived_parameters._
import cgra.fabric.Trig_PE_component.tia_parameters.fixed_parameters._
import chisel3._
import chisel3.iotesters.PeekPokeTester
import chisel3.util._

class operand_forwarding_unit extends Module {
  val io = IO(
    new Bundle{
      val enable = Input(Bool())
      val source_types = Input(UInt(TIA_ST_WIDTH.W))
      val source_indices = Input(UInt(TIA_SI_WIDTH.W))
      val downstream_dt = Input(UInt(TIA_DT_WIDTH.W))
      val downstream_di = Input(UInt(TIA_DI_WIDTH.W))
      val downstream_result = Input(UInt(TIA_WORD_WIDTH.W))
      val pre_ofu_operands = Input(Vec(TIA_NUM_SOURCE,UInt(TIA_WORD_WIDTH.W)))
      val post_ofu_operands = Output(Vec(TIA_NUM_SOURCE,UInt(TIA_WORD_WIDTH.W)))
    }
  )

  val source_types = Wire(Vec(TIA_NUM_SOURCE,UInt(TIA_SINGLE_ST_WIDTH.W)))
  val source_indices = Wire(Vec(TIA_NUM_SOURCE,UInt(TIA_SINGLE_SI_WIDTH.W)))

  for (i <- 0 until TIA_NUM_SOURCE){
    source_types(i) := io.source_types(TIA_SINGLE_ST_WIDTH *(i+1)-1,TIA_SINGLE_ST_WIDTH*i)
    source_indices(i) := io.source_indices(TIA_SINGLE_SI_WIDTH *(i+1)-1,TIA_SINGLE_SI_WIDTH*i)
  }

  for (i <- 0 until TIA_NUM_SOURCE){
    when(io.enable){
      when(source_types(i) === TIA_SOURCE_TYPE_REGISTER.U &&
        io.downstream_dt === TIA_DESTINATION_TYPE_REGISTER.U &&
        source_indices(i) === io.downstream_di){
        io.post_ofu_operands(i) := io.downstream_result
      }.otherwise{
        io.post_ofu_operands(i) := io.pre_ofu_operands(i)
      }
    }.otherwise{
      io.post_ofu_operands(i) := io.pre_ofu_operands(i)
    }
  }
}
/*
object ofuDriver extends App
{
  chisel3.Driver.execute(args, () => new operand_forwarding_unit)
}
*/