package cgra.fabric.Shared_PE_component.common.mmio

import cgra.IO.mmio_if
import cgra.fabric.Shared_PE_component.tia_parameters.derived_parameters._
import cgra.fabric.Shared_PE_component.tia_parameters.fixed_parameters._
import chisel3._
/*
class mmio_if(p:Entity) extends Bundle with derived_parameters{
  parameter_update(p)

  // DEVICE that store data, **use Flipped(new mmio_if) for those who consume data (like ALU)

  val read_req = Input(Bool())
  val read_ack = Output(Bool())
  val read_index = Input(UInt(TIA_MMIO_INDEX_WIDTH.W))
  val read_data = Output(UInt(TIA_MMIO_DATA_WIDTH.W))

  val write_req = Input(Bool())
  val write_ack = Output(Bool())
  val write_index = Input(UInt(TIA_MMIO_INDEX_WIDTH.W))
  val write_data = Input(UInt(TIA_MMIO_DATA_WIDTH.W))
}
*/
class mmio_if_t extends Bundle{
  val read_req = Bool()
  val read_ack = Bool()
  val read_index = UInt(TIA_MMIO_INDEX_WIDTH.W)
  val read_data = UInt(TIA_MMIO_DATA_WIDTH.W)

  val write_req = Bool()
  val write_ack = Bool()
  val write_index = UInt(TIA_MMIO_INDEX_WIDTH.W)
  val write_data = UInt(TIA_MMIO_DATA_WIDTH.W)

}

class unused_host_interface extends Module{
  val io = IO(mmio_if(TIA_MMIO_INDEX_WIDTH,TIA_MMIO_DATA_WIDTH))
  io.read_ack := false.B
  io.read_data := 0.U
  io.write_ack := false.B
}