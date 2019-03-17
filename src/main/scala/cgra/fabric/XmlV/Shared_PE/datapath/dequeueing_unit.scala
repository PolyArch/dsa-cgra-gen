package cgra.fabric.XmlV.Shared_PE.datapath
import cgra.entity.Entity
import cgra.fabric.XmlV.Shared_PE.parameters.derived_parameters
import chisel3._
import chisel3.util._

class dequeueing_unit(p:Entity) extends Module with derived_parameters{
  parameter_update(p)
  val io = IO(new Bundle{
    val enable = Input(Bool())
    val icd = Input(UInt(TIA_ICD_WIDTH.W))
    val dequeue_signals = Output(UInt(TIA_NUM_INPUT_CHANNELS.W))
  })
  io.dequeue_signals := Mux(io.enable,io.icd,0.U)

}
