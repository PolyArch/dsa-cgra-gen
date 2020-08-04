package cgra.fabric.Trig_PE_component.datapath
import cgra.fabric.Trig_PE_component.tia_parameters.derived_parameters._
import cgra.fabric.Trig_PE_component.tia_parameters.fixed_parameters._
import chisel3._
import chisel3.util._

class dequeueing_unit extends Module {
  val io = IO(new Bundle{
    val enable = Input(Bool())
    val icd = Input(UInt(TIA_ICD_WIDTH.W))
    val dequeue_signals = Output(UInt(TIA_NUM_INPUT_CHANNELS.W))
  })
  io.dequeue_signals := Mux(io.enable,io.icd,0.U)

}
