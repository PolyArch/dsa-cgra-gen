package cgra.fabric

import cgra.IO._
import cgra.fabric.common.interconnect.{crossbar, crossbar_flow_control}
import chisel3._
import chisel3.util.{Cat, log2Ceil}
import dsl.IRPrintable

import scala.collection.mutable
import scala.util.Random

class vector_port(prop:mutable.Map[String,Any])
  extends Module with IRPrintable {
  // Assign initial properties
  apply(prop)

  // ------ Reconfigurable Variable------

  // Initialize the properties of switch (hardware)
  private val data_width:Int = getPropByKey("data_width").asInstanceOf[Int]
  private val num_input:Int = getPropByKey("num_input").asInstanceOf[Int]
  private val num_output:Int = getPropByKey("num_output").asInstanceOf[Int]
  private val num_port = num_input max num_output
  private val flow_control : Boolean = getPropByKey("flow_control")
    .asInstanceOf[Boolean]

  // Derived Parameter
  val config_width = num_port * log2Ceil(num_port)

  // Create the I/O port
  val io = IO(new Bundle{
    val input_ports = Flipped(Vec(num_port,ReqAckConf_if(data_width)))
    val output_ports = Vec(num_port,ReqAckConf_if(data_width))
    val config = Input(UInt(config_width.W))
  })


  prop += "in_data_width" -> Seq.fill(num_port)(data_width + 1)
  prop += "out_data_width"-> Seq.fill(num_port)(data_width + 1)

  // ------ Logic Connections
  if(flow_control){
    val xbar = Module(new crossbar_flow_control(prop)).io
    xbar.config := io.config
    for (idx <- 0 until num_port){
      // Bits & Config
      xbar.ins(idx).bits := Cat(io.input_ports(idx).bits,io.input_ports(idx).config)
      io.output_ports(idx).bits := xbar.outs(idx).bits(data_width,1)
      io.output_ports(idx).config := xbar.outs(idx).bits(0)
      // Input Control
      io.input_ports(idx).ready := xbar.ins(idx).ready
      xbar.ins(idx).valid := io.input_ports(idx).valid
      // Output Control
      io.output_ports(idx).valid := xbar.outs(idx).valid
      xbar.outs(idx).ready := io.output_ports(idx).ready
    }
  }else{
    val xbar = Module(new crossbar(prop)).io
    xbar.config := io.config
    for (idx <- 0 until num_port){
      // Bits & Config
      xbar.ins(idx) := Cat(io.input_ports(idx).bits,io.input_ports(idx).config)
      io.output_ports(idx).bits := xbar.outs(idx)(data_width,1)
      io.output_ports(idx).config := xbar.outs(idx)(0)
      // DontCare Flow Control
      io.input_ports(idx).ready := DontCare
      io.output_ports(idx).valid := DontCare
    }
  }



  // Post process
  def postprocess(): Unit = {
    print(this)
  }
}


import cgra.IR.IRreader._

object gen_vp extends App{

  val cgra = readIR(args(0))

  val nodes = cgra("nodes")
    .asInstanceOf[List[mutable.Map[String,Any]]]

  for (node <- nodes){
    if(node("nodeType") == "vector port"){
      chisel3.Driver.execute(args,()=>{
        val module = new vector_port(node)
        println(module)
        module
      })
    }
  }
}