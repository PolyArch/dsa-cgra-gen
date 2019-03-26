package cgra.fabric.Shared_PE_component.control

import cgra.fabric.Shared_PE_component.common.Instructions.Instructions
import cgra.fabric.Shared_PE_component.tia_parameters.derived_parameters._
import cgra.fabric.Shared_PE_component.tia_parameters.fixed_parameters._
import chisel3._

class integer_collision_detector extends Module
  with Instructions {


  val io = IO(new Bundle{
    val triggered_instruction_op = Input(UInt(TIA_OP_WIDTH.W))
    val dx1_instruction_retiring_stage = Input(UInt(3.W)) //TODO: why 3?
    val collision = Output(Bool())
  })

  when(VecInit(basic_insts.map(_.U)).exists( _ === io.triggered_instruction_op)){
    io.collision := Mux(io.dx1_instruction_retiring_stage === 2.U,1.U,0.U)
  }.otherwise{
    io.collision := 0.U
  }

}
