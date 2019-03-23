package cgra.fabric.YamlV

import cgra.IO.ReqAckConf_if
import cgra.IR._
import cgra.config.derived_system._
import cgra.config.system
import cgra.config.system.update_system
import chisel3._
import chisel3.util._
import cgra.IR.IRconvertor._

import scala.collection.mutable._
import scala.xml.Elem

class Cgra_Hw(cgra:Cgra) extends Module
  with Has_IO
  with Reconfigurable {
  // ------ System Parameter ------
  val hw_desc : Cgra = cgra
  update_system(cgra.system)
  private val input_ports = system.input_ports
  private val output_ports = system.output_ports
  private val num_input : Int = input_ports.length
  private val num_output : Int = output_ports.length
  private val data_word_width : Int = system.data_word_width
  private val AllModules : Map[String,Any] = Map[String,Any]()
  private val topology:List[connection] = cgra.topology

  // ------ Input Output ------
  val io = IO(new Bundle{
    val in = Flipped(Vec(num_input,ReqAckConf_if(data_word_width)))
    val out = Vec(num_output,ReqAckConf_if(data_word_width))
  })

  // ------ Vector Ports ------
  private val vector_ports = cgra.vector_ports.filter(p => !p._1.startsWith("default"))
  val vector_ports_hw = vector_ports map (iv=> iv._1 -> Module(new VectorPort_Hw(iv)))
  AllModules ++= vector_ports_hw

  // ------ Routers ------
  private val routers = cgra.routers.filter(p => !p._1.startsWith("default"))
  val routers_hw : Map[String,Router_Hw] = routers map (r =>r._1 -> Module(new Router_Hw(r)))
  AllModules ++= routers_hw

  // ------ Dedicated PE ------
  private val dedicated_pes = cgra.dedicated_pes.filter(p => !p._1.startsWith("default"))
  val dedicated_pes_hw : Map[String,Dedicated_PE_Hw] = dedicated_pes map (dp => dp._1 -> Module(new Dedicated_PE_Hw(dp)))
  AllModules ++= dedicated_pes_hw

  // ------ Shared PE ------
  private val shared_pes = cgra.shared_pes.filter(p => !p._1.startsWith("default"))
  val shared_pes_hw : Map[String,Shared_PE_Hw] = shared_pes map (sp => sp._1 -> Module(new Shared_PE_Hw(sp)))
  AllModules ++= shared_pes_hw

  // ------ Topology ------
  connect_all(AllModules,topology)

  // ------ Output Config ------
  scala.xml.XML.save(cgra.config_filename,config2XML,"UTF-8",false,null)

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
      //println(source_module_name + "-port-" + source_port + "--> " + sink_module_name + "-port-" + sink_port)
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

  def config2XML : Elem = {
    <CGRA>
      <Routers>{routers_hw.map(r=>r._2.asInstanceOf[Reconfigurable].config2XML)}</Routers>
      <Dedicated_PEs>{dedicated_pes_hw.map(r=>r._2.asInstanceOf[Reconfigurable].config2XML)}</Dedicated_PEs>
      <Shared_PEs>{shared_pes_hw.map(r=>r._2.asInstanceOf[Reconfigurable].config2XML)}</Shared_PEs>
    </CGRA>
  }
}