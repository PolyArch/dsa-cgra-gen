package cgra.fabric.Shared_PE.control

import chisel3._
import chisel3.util._
import cgra.fabric.Shared_PE.parameters.derived_parameters._

class trigger_resolution_unit extends Module
  {

  val io = IO(
    new Bundle{
      val enable = Input(Bool())
      val execute = Input(Bool())
      val halted = Input(Bool())
      val triggers = Vec(TIA_MAX_NUM_INSTRUCTIONS,Input(new trigger_t))
      val predicates = Input(UInt(TIA_NUM_PREDICATES.W))
      val input_channel_empty_status = Input(UInt(TIA_NUM_INPUT_CHANNELS.W))
      val input_channel_tags = Input(Vec(TIA_NUM_INPUT_CHANNELS,UInt(TIA_TAG_WIDTH.W)))
      val output_channel_full_status = Input(UInt(TIA_NUM_OUTPUT_CHANNELS.W))
      val triggered_instruction_valid = Output(Bool())
      val triggered_instruction_index = Output(UInt(TIA_INSTRUCTION_INDEX_WIDTH.W))
    }
  )

  // Halt-insensitive valid instruction signal.
  val halt_insensitive_triggered_instruction_valid = Wire(Bool())

  // Whether such trigger state is valid or not
  val trigger_states = Wire(Vec(TIA_MAX_NUM_INSTRUCTIONS,Bool()))

  // Trigger Solvers
  val trigger_resolvers = VecInit(Seq.fill(TIA_MAX_NUM_INSTRUCTIONS){ Module(new trigger_resolver()).io })
  for(i <- 0 until TIA_MAX_NUM_INSTRUCTIONS){
    trigger_resolvers(i).trigger := io.triggers(i)
    trigger_resolvers(i).input_channel_empty_status := io.input_channel_empty_status
    trigger_resolvers(i).predicates := io.predicates
    trigger_resolvers(i).input_channel_tags := io.input_channel_tags
    trigger_resolvers(i).output_channel_full_status := io.output_channel_full_status
    trigger_states(i) := trigger_resolvers(i).valid
  }

  val trpe = Module(new trigger_resolution_priority_encoder).io
  trpe.trigger_states := trigger_states
  halt_insensitive_triggered_instruction_valid := trpe.trigger_inst_valid
  io.triggered_instruction_index := trpe.triggered_inst_index

  io.triggered_instruction_valid := io.enable && io.execute && halt_insensitive_triggered_instruction_valid && !io.halted
}

object truDriver extends App
{
  chisel3.Driver.execute(args, () => new trigger_resolution_unit)
}