package cgra.fabric.Trig_PE_component.common.datapath

import cgra.IO.mmio_if
import cgra.fabric.Trig_PE_component.common.memory._
import cgra.fabric.Trig_PE_component.tia_parameters.derived_parameters._
import cgra.fabric.Trig_PE_component.tia_parameters.fixed_parameters._
import chisel3._
import chisel3.util._

class scratchpad extends Module {
  val io = IO(new Bundle {
      val opcode = Input(UInt(TIA_OP_WIDTH.W))
      val hostInterface = mmio_if(TIA_MMIO_INDEX_WIDTH,TIA_MMIO_DATA_WIDTH)
      val operand0 = Input(UInt(TIA_WORD_WIDTH.W))
      val operand1 = Input(UInt(TIA_WORD_WIDTH.W))
      val result = Output(UInt(TIA_WORD_WIDTH.W))
    }
  )

  val write_data = Wire(UInt(TIA_WORD_WIDTH.W))
  val read_enable = Wire(Bool())
  val write_enable = Wire(Bool())
  val index = Wire(UInt(log2Ceil(TIA_SPM_DEPTH).W))

  val spram = Module(new single_port_ram(TIA_WORD_WIDTH,TIA_SPM_DEPTH))
  spram.io.read_enable := read_enable
  spram.io.write_enable := write_enable
  spram.io.index := index
  io.result := spram.io.read_data
  spram.io.write_data := write_data

  // Read from host is not available
  io.hostInterface.read_data := 0.U
  io.hostInterface.read_ack := io.hostInterface.read_req

  // write can be registered immediately
  io.hostInterface.write_ack := io.hostInterface.write_req

  //
  write_data := Mux(io.hostInterface.write_req,io.hostInterface.write_data,io.operand0)

  when(io.hostInterface.read_req){
    read_enable := false.B
    write_enable := false.B
    index := 0.U
  }.elsewhen(io.hostInterface.write_req){
    read_enable := false.B
    write_enable := true.B
    index := io.hostInterface.write_index(TIA_SPM_INDEX_WIDTH-1,0)
  }.otherwise{
    when(io.opcode === TIA_OP_LSW.U){
      read_enable := true.B
      write_enable := false.B
      index := io.operand0(TIA_SPM_INDEX_WIDTH-1,0)
    }.elsewhen(io.opcode === TIA_OP_SSW.U){
      read_enable := false.B
      write_enable := true.B
      index := io.operand1(TIA_SPM_INDEX_WIDTH-1,0)
    }.otherwise{
      read_enable := false.B
      write_enable := false.B
      index := 0.U
    }
  }

}
/*
object spmDriver extends App
{
  chisel3.Driver.execute(args, () => new scratchpad)
}
*/