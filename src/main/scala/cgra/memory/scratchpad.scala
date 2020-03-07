package cgra.memory

import chisel3._
import chisel3.util._

class scratchpad(memory_size : Int, // memory size in Byte
                 line_size : Int,
                 mask_write_enable : Boolean)   // line size of the spm in Byte
  extends Module{
  // Require
  require(isPow2(memory_size))
  require(isPow2(line_size))

  // Calculate Internal Parameter
  val num_line : Int = memory_size / line_size
  val num_addr_bit : Int = log2Ceil(num_line)

  val io = IO(new Bundle{
    // Enable
    val read_enable : Bool = Input(Bool())
    val write_enable : Bool = Input(Bool())
    // Read
    val read_addr : UInt = Input(UInt(num_addr_bit.W))
    val read_data : Vec[UInt] = Output(Vec(line_size, UInt(8.W)))
    // Write
    val write_addr : UInt = Input(UInt(num_addr_bit.W))
    val write_data : Vec[UInt] = Input(Vec(line_size, UInt(8.W)))
    val write_mask : Vec[Bool] = Input(Vec(line_size, Bool()))
  })

  // Memory
  val mem = SyncReadMem(num_line, Vec(line_size, UInt(8.W)))

  // Read
  io.read_data := mem.read(io.read_addr,io.read_enable)

  // Write
  val mask : Seq[Bool]= if(mask_write_enable){
    io.write_mask
  }else{
    io.write_mask := DontCare
    Seq.fill(line_size)(true.B)
  }

  when(io.write_enable){
    mem.write(io.write_addr, io.write_data, mask)
  }
}
