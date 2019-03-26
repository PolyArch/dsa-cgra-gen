package cgra.fabric

import cgra.IO.ReqAckConf_if
import chisel3._
import chisel3.util._

import scala.xml.Elem

trait Has_IO {
  def get_port(io_t:String,name:String) : ReqAckConf_if
}

trait Decomposable {
  def decompose(io_type:String,ports: Vec[ReqAckConf_if]) : List[Vec[DecoupledIO[UInt]]]
}

trait Reconfigurable {
  def config2XML : Elem
}