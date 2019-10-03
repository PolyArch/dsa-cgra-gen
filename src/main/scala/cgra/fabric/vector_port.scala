package cgra.fabric

import cgra.IO._
import chisel3._
import dsl.IRPrintable
import scala.collection.mutable
import scala.util.Random

class vector_port(prop:mutable.Map[String,Any])
  extends Module with IRPrintable {
  // Assign initial properties
  apply(prop)

  // ------ Reconfigurable Variable------

  // Initialize the properties of switch (hardware)
  private val datawidth:Int = getPropByKey("datawidth").asInstanceOf[Int]
  private val num_input:Int = getPropByKey("num_input").asInstanceOf[Int]
  private val num_output:Int = getPropByKey("num_output").asInstanceOf[Int]
  private val num_port = num_input max num_output

  // Create the I/O port
  val io = IO(new Bundle{
    val input_ports = Flipped(Vec(num_port,ReqAckConf_if(datawidth)))
    val output_ports = Vec(num_port,ReqAckConf_if(datawidth))
  })

  // ------ Logic Connections
  for (idx <- 0 until num_port){
    io.input_ports(idx) <> io.output_ports(idx)
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