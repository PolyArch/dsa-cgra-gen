package cgra.fabric.Shared_PE_component.control

import chisel3._
import chisel3.util._
import cgra.fabric.Shared_PE_component.instruction._
import cgra.fabric.Shared_PE_component.tia_parameters.derived_parameters._
import cgra.fabric.Shared_PE_component.tia_parameters.fixed_parameters._

class integer_retirement_unit extends Module {
  val io = IO(new Bundle{
    val dx1_instruction_retiring_stage = Input(UInt(3.W)) //todo why 3
    val dx1_functional_unit = Input(UInt(log2Ceil(TIA_NUM_FU_TYPES).W))
    val x2_instruction_retiring_stage = Input(UInt(3.W)) //todo why 3
    val x2_functional_unit = Input(UInt(log2Ceil(TIA_NUM_FU_TYPES).W))
    val dx1_datapath_instruction = Input(new datapath_instruction_t)
    val x2_datapath_instruction = Input(new datapath_instruction_t)
    val alu_result = Input(UInt(TIA_WORD_WIDTH.W))
    val imu_result = Input(UInt(TIA_WORD_WIDTH.W))
    val sm_result = Input(UInt(TIA_WORD_WIDTH.W))
    val retiring_datapath_instruction = Output(new datapath_instruction_t)
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
    io.retiring_datapath_instruction := Module(new zero_datapath_instruction).io
    io.datapath_result := io.alu_result
  }
}
