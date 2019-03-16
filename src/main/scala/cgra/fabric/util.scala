package cgra.fabric

import chisel3.util._
import chisel3._

trait Has_IO {
  def get_port(io_t:String,name:String) : DecoupledIO[UInt]
}
