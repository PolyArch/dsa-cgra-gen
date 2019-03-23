package cgra.IR

import scala.collection.mutable
import scala.collection.mutable.Map
import cgra.IR.IRconvertor._

object IRpreprocessor {

  var topology:List[connection] = null

  def preprocess(cgra:mutable.Map[String,Any]):Unit={
    delete_useless_port(cgra)
  }

  def delete_useless_port(cgra:mutable.Map[String,Any]):Unit = {
    topology = cgra("topology").asInstanceOf[List[Map[String,Any]]]
    delete_useless_port(cgra("vector_ports"))
    delete_useless_port(cgra("dedicated_pes"))
    delete_useless_port(cgra("shared_pes"))
    delete_useless_port(cgra("routers"))
  }

  def delete_useless_port(m:Any):Unit ={
    val mods = m.asInstanceOf[Map[String,Map[String,Any]]]
    mods.foreach(sm=>{
      val name = sm._1
      val mod = sm._2
      val connected_sink_port = topology.filter(c=>c.sink.module == name).map(c=>c.sink.port)
      val connected_source_port = topology.filter(c=>c.source.module == name).map(c=>c.source.port)
      mod("input_ports") = mod("input_ports").asInstanceOf[List[String]] intersect connected_sink_port
      mod("output_ports") = mod("output_ports").asInstanceOf[List[String]] intersect connected_source_port
    })
  }
}
