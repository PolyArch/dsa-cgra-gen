package cgra.fabric.Trig_PE_component.common.memory

import chisel3._
import chisel3.util._

class single_port_ram(data_width:Int,depth:Int) extends Module{
  val io = IO(
    new Bundle{
      val read_enable = Input(Bool())
      val write_enable = Input(Bool())
      val index = Input(UInt(log2Ceil(depth).W))
      val read_data = Output(UInt(data_width.W))
      val write_data = Input(UInt(data_width.W))
    }
  )
  val mem = SyncReadMem(depth, UInt(data_width.W))
  when(io.write_enable){
    mem.write(io.index,io.write_data)
  }
  io.read_data := mem.read(io.index, io.read_enable)
}

object initialize_ram extends App {
  chisel3.Driver.execute(args,()=>{new single_port_ram(512,128)})
}