package cgra.fabric.XmlV.Shared_PE.control

import cgra.entity.Entity
import cgra.fabric.XmlV.Shared_PE.common.Instructions.Instructions
import cgra.fabric.XmlV.Shared_PE.parameters.derived_parameters
import chisel3._

class integer_collision_detector(p:Entity) extends Module
  with Instructions with derived_parameters{
  parameter_update(p)

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
