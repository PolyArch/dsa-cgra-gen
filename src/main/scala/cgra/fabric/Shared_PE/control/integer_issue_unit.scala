package cgra.fabric.Shared_PE.control

import cgra.entity.Entity
import cgra.fabric.Shared_PE.common.Instructions.Instructions
import cgra.fabric.Shared_PE.parameters.derived_parameters
import chisel3._
import chisel3.util._

class integer_issue_unit(p:Entity) extends Module
  with Instructions with derived_parameters{
  parameter_update(p)
  val io = IO(new Bundle{
    val dx1_instruction_op = Input(UInt(TIA_OP_WIDTH.W))
    val retiring_stage = Output(UInt(3.W)) //TODO why 3?
    val functional_unit = Output(UInt(log2Ceil(TIA_NUM_FU_TYPES).W))
  })


  when(VecInit(basic_insts.map(_.U)).exists(_ === io.dx1_instruction_op)){
    io.retiring_stage := 1.U
    io.functional_unit := ALU.U
  }.elsewhen(VecInit(scratchpad_insts.map(_.U)).exists(_ === io.dx1_instruction_op)){
    io.retiring_stage := 2.U
    io.functional_unit := SM.U
  }.elsewhen(VecInit(integer_mult_insts.map(_.U)).exists(_ === io.dx1_instruction_op)){
    io.retiring_stage := 3.U
    io.functional_unit := IMU.U
  }.otherwise{
    io.retiring_stage := 1.U
    io.functional_unit := ALU.U
  }

}
