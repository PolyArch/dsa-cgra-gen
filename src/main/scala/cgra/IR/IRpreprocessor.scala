package cgra.IR

import scala.collection.mutable
import scala.collection.mutable.{ListBuffer, Map}
import cgra.config.system_var
import cgra.config.system_util._
object IRpreprocessor {
  var topology : List[String] = Nil
  def preprocess(ir:mutable.Map[String,Any]) ={
    if(ir.isDefinedAt("system")){
      set_system(ir("system"))
    }
    if(ir.isDefinedAt("links")){
      topology = ir("links").asInstanceOf[List[String]]
      ir("links") = elaborate_conn
      delete_useless_port(ir)
    }
    ir
  }

  def delete_useless_port(cgra:mutable.Map[String,Any]):Unit = {

    if(cgra.isDefinedAt("vector_ports")) delete_useless_port(cgra("vector_ports"))
    if(cgra.isDefinedAt("dedicated_pes")) delete_useless_port(cgra("dedicated_pes"))
    if(cgra.isDefinedAt("shared_pes")) delete_useless_port(cgra("shared_pes"))
    if(cgra.isDefinedAt("routers")) delete_useless_port(cgra("routers"))
  }

  def delete_useless_port(m:Any):Unit ={
    val mods = m.asInstanceOf[Map[String,Map[String,Any]]]
    mods.foreach(sm=>{
      val name = sm._1
      val mod = sm._2
      val connected_sink_port = topology.filter(c=>parse_conn(c).sink.module == name).map(c=>parse_conn(c).sink.port)
      val connected_source_port = topology.filter(c=>parse_conn(c).source.module == name).map(c=>parse_conn(c).source.port)
      mod("input_ports") = mod("input_ports").asInstanceOf[List[String]] intersect connected_sink_port
      mod("output_ports") = mod("output_ports").asInstanceOf[List[String]] intersect connected_source_port
    })
  }

  def parse_conn(cs_space:String):connection={
    val temp_c = new connection
    val cs = cs_space.replaceAll(" ","")
    if(cs.contains("->")){
      temp_c.source = cs.split("->").head
      temp_c.sink = cs.split("->")(1)
    }else if(cs.contains("<-")){
      temp_c.source = cs.split("<-")(1)
      temp_c.sink = cs.split("<-").head
    }
    temp_c
  }

  def elaborate_conn ={
    val temp = topology.to[ListBuffer]
    for (i <- topology.indices){
      val curr = topology(i)
      if(curr.contains("<->")){
        val a : String = curr.split("<->").head
        val b : String = curr.split("<->")(1)
        temp -= curr
        temp += a + "->" + b
        temp += b + "->" + a
      }
    }
    topology = temp.toList
    topology
  }

  class port_location {
    var module : String = ""
    var port : String = ""
  }
  class connection {
    var source : port_location = new port_location
    var sink : port_location = new port_location
  }
  implicit def convert2ps(s:String):port_location={
    val temp = new port_location
    temp.module = s.split("\\.").head
    temp.port = s.split("\\.")(1)
    temp
  }
}
