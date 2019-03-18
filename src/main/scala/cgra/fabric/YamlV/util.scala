package cgra.fabric.YamlV

import cgra.IO.ReqAckConf_if
import chisel3._
import chisel3.util._

trait Has_IO {
  def get_port(io_t:String,name:String) : ReqAckConf_if
}

trait Decomposable {
  def decompose(io_type:String,ports: Vec[ReqAckConf_if]) : List[Vec[DecoupledIO[UInt]]]
}
