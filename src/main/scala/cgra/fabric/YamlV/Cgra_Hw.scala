package cgra.fabric.YamlV

import cgra.IR._
import cgra.config.system
import cgra.config.system.update_system
import chisel3._
import chisel3.util._

import scala.collection.mutable._

class Cgra_Hw(cgra:Cgra) extends Module
  with Has_IO{
  // ------ System Parameter ------
  update_system(cgra.system)
  private val input_ports = system.input_ports
  private val output_ports = system.output_ports
  private val num_input : Int = input_ports.length
  private val num_output : Int = output_ports.length
  private val word_width : Int = system.word_width
  private val AllModules : Map[String,Any] = Map[String,Any]()
  private val topology = cgra.topology

  // ------ Input Output ------
  val io = IO(new Bundle{
    val in = Flipped(Vec(num_input,DecoupledIO(UInt(word_width.W))))
    val out = Vec(num_output,DecoupledIO(UInt(word_width.W)))
  })

  // ------ Vector Ports ------
  private val vector_ports = delete_useless_port(cgra.vector_ports)
  val vector_ports_hw = vector_ports map (iv=> iv._1 -> Module(new VectorPort_Hw(iv._2)))
  AllModules ++= vector_ports_hw

  // ------ Routers ------
  private val routers = delete_useless_port(cgra.routers)
  val routers_hw = routers map (r =>r._1 -> Module(new Router_Hw(r._2)))
  AllModules ++= routers_hw

  // ------ Dedicated PE ------
  private val dedicated_pes = delete_useless_port(cgra.dedicated_pes)
  val dedicated_pes_hw = dedicated_pes map (dp => dp._1 -> Module(new Dedicated_PE_Hw(dp._2)))
  AllModules ++= dedicated_pes_hw

  // ------ Shared PE ------
  private val shared_pes = delete_useless_port(cgra.shared_pes)
  val shared_pes_hw = shared_pes map (sp => sp._1 -> Module(new Shared_PE_Hw(sp._2)))
  AllModules ++= shared_pes_hw

  // ------ Topology ------
  connect_all(AllModules,topology)

  // ------ Util ------
  def get_port (io_t:String,name:String) = {
    io_t match {
      case "in" => io.in(input_ports.indexOf(name))
      case "out" => io.out(output_ports.indexOf(name))
    }
  }
  def get_module (name: String) : Has_IO = {
    val mod = name match {
      case "this" => this
      case _ => AllModules(name)
    }
    mod.asInstanceOf[Has_IO]
  }
  def connect_all(mods:Map[String,Any],cons:List[connection]):Unit={
    cons.foreach(c=>{
      val source_module_name = c.source.module
      val sink_module_name = c.sink.module
      val source_port = c.source.port
      val sink_port = c.sink.port
      val source_mod = get_module(source_module_name)
      val sink_mod = get_module(sink_module_name)
      println(source_module_name + "-port-" + source_port + "--> " +
        sink_module_name + "-port-" + sink_port)
      if (source_mod == this)
        source_mod.get_port("in",source_port) <> sink_mod.get_port("in",sink_port)
      else if (sink_mod == this)
        source_mod.get_port("out",source_port) <> sink_mod.get_port("out",sink_port)
      else
        source_mod.get_port("out",source_port) <> sink_mod.get_port("in",sink_port)
    })
  }
  def delete_useless_port[T](mods:Map[String,T]) ={
    mods.foreach(sm=>{
      val name = sm._1
      val mod = sm._2.asInstanceOf[tile]
      val connected_sink_port = topology.filter(c=>c.sink.module == name).map(c=>c.sink.port)
      val connected_source_port = topology.filter(c=>c.source.module == name).map(c=>c.source.port)
      mod.input_ports = mod.input_ports intersect connected_sink_port
      mod.output_ports = mod.output_ports intersect connected_source_port
    })
    mods
  }
}