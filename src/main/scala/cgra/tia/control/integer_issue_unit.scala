package cgra.tia.control

import cgra.common.Instructions.Instructions
import chisel3._
import chisel3.util._
import cgra.tia.parameters.derived_parameters._

class integer_issue_unit extends Module
  with Instructions {
  val io = IO(new Bundle{
    val dx1_instruction_op = Input(UInt(TIA_OP_WIDTH.W))
    val retiring_stage = Output(UInt(3.W)) //TODO why 3?
    val functional_unit = Output(UInt(log2Ceil(TIA_NUM_FU_TYPES).W))
  })


  when(basic_insts.exists(_ === io.dx1_instruction_op)){
    io.retiring_stage := 1.U
    io.functional_unit := ALU.U
  }.elsewhen(scratchpad_insts.exists(_ === io.dx1_instruction_op)){
    io.retiring_stage := 2.U
    io.functional_unit := SM.U
  }.elsewhen(integer_mult_insts.exists(_ === io.dx1_instruction_op)){
    io.retiring_stage := 3.U
    io.functional_unit := IMU.U
  }.otherwise{
    io.retiring_stage := 1.U
    io.functional_unit := ALU.U
  }

}
