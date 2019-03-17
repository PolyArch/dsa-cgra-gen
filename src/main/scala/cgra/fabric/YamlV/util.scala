package cgra.fabric.YamlV

import chisel3._
import chisel3.util._

trait Has_IO {
  def get_port(io_t:String,name:String) : DecoupledIO[UInt]
}
