package cgra.fabric

import cgra.IO._
import chisel3.util._
import cgra.config.system_var
import cgra.config.system_util._
import chisel3._
import cgra.IO.port_generator._
import cgra.config.encoding.{config_module_id_high, config_module_id_low}
import cgra.fabric.common.datapath.Multiplexer
import dsl.{IRPrintable, ssnode}

import scala.collection.mutable
import scala.xml.Elem

class switch extends Module with IRPrintable{
  // Initialize the properties of switch (hardware)
  private val datawidth:Int = getPropByKey("datawidth").asInstanceOf[Int]
  private val granularity = getPropByKey("granularity").asInstanceOf[Int]
  private val num_input:Int = getPropByKey("num_input").asInstanceOf[Int]
  private val num_output:Int = getPropByKey("num_output").asInstanceOf[Int]
  private val decomposer:Int = datawidth / granularity

  // Initialize the I/O port
  val io = IO(new Bundle{
    val input_ports = Flipped(Vec(num_input,Vec(decomposer,ReqAckConf_if(granularity))))
    val output_ports = Vec(num_output,Vec(decomposer,ReqAckConf_if(granularity)))
  })

  // Post process
  def postprocess(): Unit = {

  }
}
