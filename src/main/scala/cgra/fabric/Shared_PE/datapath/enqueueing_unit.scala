package cgra.fabric.Shared_PE.datapath
import chisel3._
import chisel3.util._
import cgra.fabric.Shared_PE.parameters.derived_parameters._

class enqueueing_unit extends Module{
  val io = IO(new Bundle{
    val enable = Input(Bool())
    val oci = Input(UInt(TIA_OCI_WIDTH.W))
    val oct = Input(UInt(TIA_OCT_WIDTH.W))
    val enqueue_signals = Output(UInt(TIA_NUM_OUTPUT_CHANNELS.W))
    val outout_channel_tags = Output(Vec(TIA_NUM_OUTPUT_CHANNELS,UInt(TIA_OCT_WIDTH.W)))
  })
  io.enqueue_signals := Mux(io.enable,io.oci,0.U)
  when(io.enable){
    for (i <- 0 until TIA_NUM_OUTPUT_CHANNELS){
      io.outout_channel_tags(i) := Mux(io.enqueue_signals(i),io.oct,0.U)
    }
  }.otherwise{
    for (i <- 0 until TIA_NUM_OUTPUT_CHANNELS)
      io.outout_channel_tags(i) := 0.U
  }
}
