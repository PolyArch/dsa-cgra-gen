package cgra.common.datapath

import cgra.common.mmio.mmio_if
import cgra.tia.mmio._
import cgra.tia.parameters.derived_parameters._
import chisel3._
import chisel3.iotesters.PeekPokeTester

class register_file extends Module{
  val io = IO(
    new Bundle{
      val enable = Input(Bool())
      val host_interface = new mmio_if

      val read_indexes = Input(Vec(TIA_NUM_SOURCE,UInt(TIA_REGISTER_INDEX_WIDTH.W)))
      val read_data = Output(Vec(TIA_NUM_SOURCE,UInt(TIA_WORD_WIDTH.W)))

      val write_enable = Input(Bool())
      val write_index = Input(UInt(TIA_REGISTER_INDEX_WIDTH.W))
      val write_data = Input(UInt(TIA_WORD_WIDTH.W))
    }
  )
  val registers = Mem(TIA_NUM_REGISTERS,UInt(TIA_WORD_WIDTH.W))

  // register file write only
  io.host_interface.read_data := 0.U
  io.host_interface.read_ack := io.host_interface.read_req

  // register write with no latency
  io.host_interface.write_ack := io.host_interface.write_req


  for(i <-  0 until TIA_NUM_SOURCE)
    io.read_data(i) := registers(io.read_indexes(i))

  when(io.enable){
    when(io.host_interface.write_req){
      registers(io.host_interface.write_index) := io.host_interface.write_data
    }.elsewhen(io.write_enable){
      registers(io.write_index) := io.write_data
    }
  }



  for (i <- 0 until TIA_NUM_REGISTERS)
    printf(p"Memory ${i} data is = ${registers(i)}\n")
  printf("--------------------------------\n")
}

class regFileTester(m: register_file) extends PeekPokeTester(m){
  private val mem = m
  poke(mem.io.enable,true.B)
  poke(mem.io.write_enable,true.B)
  poke(mem.io.write_index,4)
  poke(mem.io.write_data,1352)
  step(1)
  poke(mem.io.enable,true.B)
  poke(mem.io.write_enable,false.B)
  poke(mem.io.write_index,7)
  poke(mem.io.write_data,434354)
  step(2)
  poke(mem.io.enable,false.B)
  poke(mem.io.write_enable,true.B)
  poke(mem.io.write_index,1)
  poke(mem.io.write_data,135476)
  step(1)
  poke(mem.io.enable,true.B)
  poke(mem.io.write_enable,true.B)
  poke(mem.io.write_index,2)
  poke(mem.io.write_data,476)
  step(2)
  poke(mem.io.read_indexes(0),2)
  step(1)
  expect(mem.io.read_data(0),476)
}

object memMain extends App {
  iotesters.Driver.execute(args, () => new register_file) {
    c => new regFileTester(c)
  }
}

object MemDriver extends App
{
  chisel3.Driver.execute(args, () => new register_file)
}