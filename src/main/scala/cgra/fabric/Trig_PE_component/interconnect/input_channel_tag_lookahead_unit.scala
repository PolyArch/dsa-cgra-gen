package cgra.fabric.Trig_PE_component.interconnect



import cgra.fabric.Trig_PE_component.tia_parameters.derived_parameters._
import cgra.fabric.Trig_PE_component.tia_parameters.fixed_parameters._
import chisel3._

class input_channel_tag_lookahead_unit extends Module {

  val io = IO(new Bundle{
    val pending_dequeue_signals = Input(UInt(TIA_NUM_INPUT_CHANNELS.W))
    val original_tags = Input(Vec(TIA_NUM_INPUT_CHANNELS,UInt(TIA_TAG_WIDTH.W)))
    val next_tags = Input(Vec(TIA_NUM_INPUT_CHANNELS,UInt(TIA_TAG_WIDTH.W)))
    val resolved_tags = Output(Vec(TIA_NUM_INPUT_CHANNELS,UInt(TIA_TAG_WIDTH.W)))
  })

  for (i <- 0 until TIA_NUM_INPUT_CHANNELS)
    io.resolved_tags(i) := Mux(io.pending_dequeue_signals(i),io.next_tags(i),io.original_tags(i))
}
