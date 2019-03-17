package cgra.fabric.XmlV.Shared_PE.control

import cgra.entity.Entity
import cgra.fabric.XmlV.Shared_PE.parameters.derived_parameters
import chisel3._
import chisel3.util._

class predicate_unit(p:Entity) extends Module with derived_parameters{
  parameter_update(p)

  val io = IO(
    new Bundle{
      val enable = Input(Bool())
      val datapath_dt = Input(UInt(TIA_DT_WIDTH.W))
      val datapath_di = Input(UInt(TIA_DI_WIDTH.W))
      val datapath_result = Input(UInt(TIA_WORD_WIDTH.W))
      val instruction_pum = Input(UInt(TIA_PUM_WIDTH.W))
      val predicates = Output(UInt(TIA_NUM_PREDICATES.W))
    }
  )

  val predicates = RegInit(0.U(TIA_NUM_PREDICATES.W))

  val datapath_pum,pum = Wire(UInt(TIA_PUM_WIDTH.W))

  val predicate_set_mask,predicate_unset_mask,next_predicate =
    Wire(UInt(TIA_NUM_PREDICATES.W))

  when(io.datapath_dt === TIA_DESTINATION_TYPE_PREDICATE.U){
    when(io.datapath_result.orR){
      datapath_pum := Cat(UIntToOH(io.datapath_di,TIA_NUM_PREDICATES),0.U)
    }.otherwise{
      datapath_pum := Cat(0.U,UIntToOH(io.datapath_di,TIA_NUM_PREDICATES))
    }
  }.otherwise{
    datapath_pum := 0.U
  }

  pum := io.instruction_pum | datapath_pum

  predicate_set_mask := pum(TIA_NUM_PREDICATES * 2 - 1, TIA_NUM_PREDICATES)
  predicate_unset_mask := pum(TIA_NUM_PREDICATES - 1, 0)
  next_predicate := (predicates | predicate_set_mask) & (~predicate_unset_mask).asUInt()

  when(io.enable){
    predicates := next_predicate
  }
  io.predicates := predicates
}
/*
object predicateDriver extends App
{
  chisel3.Driver.execute(args, () => new predicate_unit)
}
*/