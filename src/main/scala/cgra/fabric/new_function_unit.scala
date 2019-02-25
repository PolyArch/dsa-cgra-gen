package cgra.fabric

import chisel3._
import chisel3.util._
import cgra.common.mmio._
import cgra.config._

class Dedicated_PE(p:TileParams) extends Module {
  val param = p.asInstanceOf[DedicatedPeParams]
  val io = IO(new Bundle{
    //val tile_io = param.get_tile_bundle
    //val host_interface = new mmio_if
    val test = Input(Bool())
  })

}