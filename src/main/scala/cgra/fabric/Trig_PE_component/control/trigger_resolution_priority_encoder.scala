package cgra.fabric.Trig_PE_component.control
import cgra.fabric.Trig_PE_component.tia_parameters.derived_parameters._
import cgra.fabric.Trig_PE_component.tia_parameters.fixed_parameters._
import chisel3._
import chisel3.util._

class trigger_resolution_priority_encoder extends Module{
  val io = IO(
    new Bundle{
      val trigger_states = Input(Vec(TIA_MAX_NUM_INSTRUCTIONS,Bool()))
      val trigger_inst_valid = Output(Bool())
      val triggered_inst_index = Output(UInt(TIA_INSTRUCTION_INDEX_WIDTH.W))
    }
  )
  val triggered_inst_index = Wire(UInt(TIA_INSTRUCTION_INDEX_WIDTH.W))
  triggered_inst_index := PriorityEncoder(io.trigger_states)

  when(triggered_inst_index === TIA_MAX_NUM_INSTRUCTIONS.U){
    when(io.trigger_states(TIA_MAX_NUM_INSTRUCTIONS - 1)){
      io.trigger_inst_valid := true.B
      io.triggered_inst_index := triggered_inst_index
    }.otherwise{
      io.trigger_inst_valid := false.B
      io.triggered_inst_index := 0.U
    }
  }.otherwise{
    io.trigger_inst_valid := true.B
    io.triggered_inst_index := triggered_inst_index
  }
  printf(p"trigger states = ${io.trigger_states}\n")
  printf(p"the triggered instruction index is = ${triggered_inst_index}\n")
  printf("-------------------------\n")
}
