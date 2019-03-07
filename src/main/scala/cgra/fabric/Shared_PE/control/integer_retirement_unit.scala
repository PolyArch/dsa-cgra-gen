package cgra.fabric.Shared_PE.control

import cgra.entity.Entity
import chisel3._
import chisel3.util._
import cgra.fabric.Shared_PE.instruction._
import cgra.fabric.Shared_PE.parameters.derived_parameters

class integer_retirement_unit(p:Entity) extends Module with derived_parameters{
  parameter_update(p)
  val io = IO(new Bundle{
    val dx1_instruction_retiring_stage = Input(UInt(3.W)) //todo why 3
    val dx1_functional_unit = Input(UInt(log2Ceil(TIA_NUM_FU_TYPES).W))
    val x2_instruction_retiring_stage = Input(UInt(3.W)) //todo why 3
    val x2_functional_unit = Input(UInt(log2Ceil(TIA_NUM_FU_TYPES).W))
    val dx1_datapath_instruction = Input(new datapath_instruction_t(p))
    val x2_datapath_instruction = Input(new datapath_instruction_t(p))
    val alu_result = Input(UInt(TIA_WORD_WIDTH.W))
    val imu_result = Input(UInt(TIA_WORD_WIDTH.W))
    val sm_result = Input(UInt(TIA_WORD_WIDTH.W))
    val retiring_datapath_instruction = Output(new datapath_instruction_t(p))
    val datapath_result = Output(UInt(TIA_WORD_WIDTH.W))
  })

  when(io.x2_instruction_retiring_stage === 2.U){
    io.retiring_datapath_instruction := io.x2_datapath_instruction
    io.datapath_result := io.alu_result
    switch(io.x2_functional_unit){
      is(SM.U){io.datapath_result := io.sm_result}
      is(IMU.U)(io.datapath_result := io.imu_result)
    }
  }.elsewhen(io.dx1_instruction_retiring_stage === 1.U){
    io.retiring_datapath_instruction := io.dx1_datapath_instruction
    io.datapath_result := io.alu_result
  }.otherwise{
    io.retiring_datapath_instruction := Module(new zero_datapath_instruction(p)).io
    io.datapath_result := io.alu_result
  }
}
