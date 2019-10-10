package cgra.fabric

import cgra.IO._
import dsl.IRPrintable
import chisel3._
import scala.collection.mutable
import cgra.config.encoding._
import _root_.cgra.IR.IRconfigpather.tranverse_config_path
import chisel3.util._

class cgra_fabric(prop:mutable.Map[String, Any]) extends Module
  with IRPrintable {
  // Pre-process
  tranverse_config_path(prop)

  // add the initial property
  apply(prop)

  // Extract External Parameter
  private val data_width = 1 + getPropByKey("data_width").asInstanceOf[Int]
  private val nodes = getPropByKey("nodes").asInstanceOf[List[mutable.Map[String,Any]]]
  private val links = getPropByKey("links").asInstanceOf[List[mutable.Map[String,List[Any]]]]

  // Derived Parameter
  // Calculate config width for Nodes who need config input
  private val allVpNodes = nodes
    .filter(node => node("nodeType") == "vector port")
  private val id2num_port = for (vp <- allVpNodes) yield {
    val id = vp("id").asInstanceOf[Int]
    val num_inport = vp("num_input").asInstanceOf[Int]
    val num_outport = vp("num_output").asInstanceOf[Int]
    (id, num_inport max num_outport, num_inport < num_outport)
  }
  private val id2config_range = {
    val ids = id2num_port.map(_._1)
    val conf_range = get_config_range(
      id2num_port.map(id2num => id2num._2 * id2num._2)
    )
    ids.zip(conf_range)
  }
  // In/Output_vps (id, num_port, is_input)
  private val input_vps = id2num_port.filter(_._3)
  private val output_vps = id2num_port.filter(!_._3)
  private val config_width : Int = 1 + id2config_range.map(_._2._1) max

  // ------ Create Hardware ------

  // Create the I/O port
  val io = IO(new Bundle{
    val input_ports = MixedVec(input_vps.map(vp=>{
      Flipped(DecoupledIO(UInt( (vp._2 * data_width).W )))
    }))
    val output_ports = MixedVec(output_vps.map(vp=>{
      DecoupledIO(UInt( (vp._2 * data_width).W ))
    }))
    val config = Flipped(ValidIO(UInt(config_width.W)))
  })

  // Create the Module
  val nodes_module : Map[Int,VecDecoupledIO]= nodes.map(node => {
    val node_id = node("id").asInstanceOf[Int]
    val nodeType = node("nodeType").toString
    node_id -> (nodeType match {
      case "switch" => Module(new switch(node)).io
      case "function unit" => Module(new function_unit(node)).io
      case "vector port" => Module(new vector_port(node)).io
    })
  }).toMap

  // Connect Everything Up
  for (link <- links){
    println(link)
    val source_id = link("source").head.asInstanceOf[Int]
    val sink_id = link("sink").head.asInstanceOf[Int]
    val source_port_idx = link("source").last.asInstanceOf[Int]
    val sink_port_idx = link("sink").last.asInstanceOf[Int]
    nodes_module(sink_id).input_ports(sink_port_idx) <>
      nodes_module(source_id).output_ports(source_port_idx)
  }

  // Connect the Config Port
  for(id2conf <- id2config_range){
    val id = id2conf._1
    val high_bit = id2conf._2._1
    val low_bit = id2conf._2._2
    val vector_port = nodes_module(id).asInstanceOf[VecDecoupledIO_conf]
    vector_port.config.bits := io.config.bits(high_bit,low_bit)
    vector_port.config.valid := io.config.valid
  }

  // Connect the IO
  // Input
  for (vp <- input_vps){
    val id = vp._1
    val vec_idx = input_vps.indexOf(vp)
    val num_port = vp._2
    val vp_module = nodes_module(id)
    // Bits & Valid
    for(port_idx <- 0 until num_port){
      vp_module.input_ports(port_idx).bits :=
        io.input_ports(vec_idx)
          .bits((port_idx+1)*data_width-1, port_idx * data_width)
      vp_module.input_ports(port_idx).valid :=
        io.input_ports(vec_idx).valid
    }
    // Ready
    io.input_ports(vec_idx).ready :=
      VecInit(vp_module.input_ports.map(_.ready)).asUInt().orR()
  }
  // Output
  for (vp <- output_vps){
    val id = vp._1
    val vec_idx = output_vps.indexOf(vp)
    val num_port = vp._2
    val vp_module = nodes_module(id)
    // Ready
    for(port_idx <- 0 until num_port){
      vp_module.output_ports(port_idx).ready :=
        io.output_ports(vec_idx).ready
    }
    // Bits & Valid
    io.output_ports(vec_idx).bits :=
      vp_module.output_ports.map(_.bits).reverse.reduce(Cat(_,_))
    io.output_ports(vec_idx).valid :=
      VecInit(vp_module.output_ports.map(_.valid)).asUInt().orR()
  }


  override def postprocess(): Unit = print(this)
}

import cgra.IR.IRreader.readIR
import cgra.IR.IRconfigpather.tranverse_config_path

object gen_cgra extends App{

  val cgra = readIR(args(0))

  chisel3.Driver.execute(args,()=>{
    val module = new cgra_fabric(cgra)
    println(module)
    module
  })

}