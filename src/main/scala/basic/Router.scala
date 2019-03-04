package basic

import chisel3._
import chisel3.util._
import basic.IO_Interface._
import basic.Constant._
import scala.collection.mutable.{ListBuffer, Map}

case class Router() extends Entity
  with WithRegisterFile
  with HasDecomposedPorts
  with WithWordWidth{
  entity_type = this.getClass.getName

  def forsyn:Unit = {
    val num_input = get("num_input").asInstanceOf[Int]
    val num_output = get("num_output").asInstanceOf[Int]
    for (o <- 0 until num_output){
      val sink_ports = Ports.filter(p=>p.io == OUTPUT_TYPE &&
        p.get("Port_Index").asInstanceOf[Int] == o)
      for (sink_port <- sink_ports){
        val sink_port_index = sink_port.entity_id
        val sources_port_id = Relationships.filter(r=>r._2 == sink_port_index).map(_._1)
        val source_ports:ListBuffer[Port] = sources_port_id
          .map(i=>Ports.find(p=>p.entity_id == i).get)
        val num_source_port = source_ports.length
        val mux = Multiplexer()
        for (s <- source_ports){
          val temp_port = Port(INPUT_TYPE,true,true)
          temp_port.copyInternalEntity(s)
          mux.Ports += temp_port
        }
        val temp_port = Port(OUTPUT_TYPE,true,true)
        temp_port.copyInternalEntity(sink_port)
        mux.Ports += temp_port
        sources_port_id.foreach(s_id=>{mux.Sources += s_id -> -1})
        mux.Sinks += sink_port_index -> -1
        mux.forsyn

      }
    }
  }
}

class Router_Hw(p:Router) extends Module {
  val io = IO(get_io(p.Ports))



}