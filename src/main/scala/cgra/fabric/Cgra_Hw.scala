package cgra.fabric

import cgra.IR._
import cgra.config.system
import chisel3._
import chisel3.util._
import cgra.config.system.update_system

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

  // ------ Input Output ------
  val io = IO(new Bundle{
    val in = Flipped(Vec(num_input,DecoupledIO(UInt(word_width.W))))
    val out = Vec(num_output,DecoupledIO(UInt(word_width.W)))
  })

  // ------ Vector Ports ------
  private val vector_ports = cgra.vector_ports
  val vector_ports_hw = vector_ports map (iv=> iv._1 -> Module(new VectorPort_Hw(iv._2)))
  AllModules ++= vector_ports_hw

  // ------ Routers ------
  private val routers = cgra.routers
  val routers_hw = routers map (r =>r._1 -> Module(new Router_Hw(r._2)))
  AllModules ++= routers_hw

  // ------ Dedicated PE ------
  private val dedicated_pes = cgra.dedicated_pes
  val dedicated_pes_hw = dedicated_pes map (dp => dp._1 -> Module(new Dedicated_PE_Hw(dp._2)))
  AllModules ++= dedicated_pes_hw

  // ------ Shared PE ------
  private val shared_pes = cgra.shared_pes
  val shared_pes_hw = shared_pes map (sp => sp._1 -> Module(new Shared_PE_Hw(sp._2)))
  AllModules ++= shared_pes_hw

  // ------ Topology ------
  private val topology = cgra.topology
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
      source_mod.get_port("out",source_port) <> sink_mod.get_port("in",sink_port)
    })
  }
}