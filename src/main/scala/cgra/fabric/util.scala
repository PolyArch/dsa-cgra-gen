package cgra.fabric

import cgra.IO.ReqAckConf_if
import chisel3._
import chisel3.util._

import scala.xml.Elem

trait Has_IO {
  val data_word_width : Int
  val decomposer : Int
  val protocol : String
  def get_port(io_t:String,name:String) : Vec[ReqAckConf_if]
  def get_port_protocol(io_t:String,name:String) : String
}

trait Reconfigurable {
  def config2XML : Elem
}