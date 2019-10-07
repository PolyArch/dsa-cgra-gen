package cgra.fabric

import cgra.IO._
import chisel3.util._
import chisel3._
import dsl.IRPrintable
import scala.collection.mutable
import scala.util.Random
import cgra.config.fullinst._

class cgra_fabric(prop:mutable.Map[String, Any]) extends Module
  with IRPrintable {
  // add the initial property
  apply(prop)

  val num_input = 1
  val num_output = 1

  val datawidth = 64

  val io = IO(new Bundle{
    val input_ports = Flipped(Vec(num_input,Vec(num_input,ReqAckConf_if(datawidth))))
    val output_ports = Vec(num_output,Vec(num_output,ReqAckConf_if(datawidth)))
  })

  override def postprocess(): Unit = ???
}
