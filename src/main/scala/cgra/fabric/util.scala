package cgra.fabric

import cgra.IO.ReqAckConf_if
import chisel3._
import chisel3.util._

import scala.xml.Elem

trait Has_IO {
  /*
  val input_ports : List[String]
  val output_ports : List[String]
  val io :chisel3.Bundle{val input_ports:Vec[Vec[ReqAckConf_if]];val output_ports:Vec[Vec[ReqAckConf_if]]}
  */
  val data_word_width : Int
  val decomposer : Int
  val protocol : String
  def get_port(io_t:String,name:String) : Vec[ReqAckConf_if]
  def get_port_protocol(io_t:String,name:String) : String
  /*
  = {
    io_t match {
      case "in" => io.input_ports(input_ports.indexOf(name))
      case "out" => io.output_ports(output_ports.indexOf(name))
    }
  }
  */
  //def get_port(io_t:String,name:String,subnet:Int) : ReqAckConf_if
  /*
  ={
    io_t match {
      case "in" => io.input_ports(input_ports.indexOf(name))(subnet)
      case "out" => io.output_ports(output_ports.indexOf(name))(subnet)
    }
  }
  */
}

trait Reconfigurable {
  def config2XML : Elem
}