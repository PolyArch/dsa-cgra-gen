package cgra.fabric

import cgra.IO._
import dsl.IRPrintable
import chisel3._
import scala.collection.mutable
import scala.util.Random
import cgra.config.fullinst._
import cgra.fabric.common.datapath.general_alu
import chisel3.util._

class cgra_fabric(prop:mutable.Map[String, Any]) extends Module
  with IRPrintable {
  // add the initial property
  apply(prop)

  // Extract External Parameter
  private val num_input = getPropByKey("num_input").asInstanceOf[Int]
  private val num_output = getPropByKey("num_output").asInstanceOf[Int]
  private val data_width = getPropByKey("data_width").asInstanceOf[Int]
  private val nodes = getPropByKey("nodes").asInstanceOf[List[mutable.Map[String,Any]]]
  private val links = getPropByKey("links").asInstanceOf[List[mutable.Map[String,Any]]]


  // ------ Create Hardware ------

  // Create the I/O port
  val io = IO(new Bundle{
    val input_ports = Flipped(Vec(num_input,ReqAckConf_if(data_width)))
    val output_ports = Vec(num_output,ReqAckConf_if(data_width))
  })

  val nodes_module : Map[Int,Bundle]= nodes.map(node => {
    val node_id = node("id").asInstanceOf[Int]
    val nodeType = node("nodeType").toString
    node_id -> (nodeType match {
      case "switch" => Module(new switch(node)).io
      case "function unit" => Module(new function_unit(node)).io
      case "vector port" => Module(new vector_port(node)).io
    })
  }).toMap

  override def postprocess(): Unit = print(this)
}
