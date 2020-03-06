package cgra.memory

import chisel3._
import chisel3.util._

class scratchpad(memory_size : Int, // memory size in Byte
                 line_size : Int)   // line size of the spm in Byte
  extends Module{
  // Require
  require(isPow2(memory_size))
  require(isPow2(line_size))

  // Calculate Internal Parameter
  val num_line : Int = memory_size / line_size
  val num_addr_bit : Int = log2Ceil(num_line)
  val num_line_bit : Int = line_size * 8

  val io = IO(new Bundle{
    // Enable
    val read_enable : Bool = Input(Bool())
    val write_enable : Bool = Input(Bool())
    // Read
    val read_addr : UInt = Input(UInt(num_addr_bit.W))
    val read_data : UInt = Output(UInt(num_line_bit.W))
    // Write
    val write_addr : UInt = Input(UInt(num_addr_bit.W))
    val write_data : UInt = Input(UInt(num_line_bit.W))
  })

  // Memory
  val mem = SyncReadMem(num_line, 0.U(num_line_bit.W))

  // Read
  io.read_data := mem.read(io.read_addr,io.read_enable)

  // Write
  mem.write(io.write_addr, io.write_data)
}
