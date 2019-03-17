package cgra.fabric.XmlV.common

import chisel3._
import chisel3.util._
import cgra.config.Constant._
import cgra.entity._
import cgra.IO.IO_Interface._

import scala.collection.mutable.Map

case class Multiplexer() extends Entity
  with RegisterControlled
  with WithWordWidth {
  entity_type = this.getClass.getName
  def forsyn: Unit = {
    // Initialize the Parameter and Add Control Port
    val input_ports = Ports.zipWithIndex.filter(p=>p._1.io == INPUT_TYPE)
    val output_ports = Ports.zipWithIndex.filter(p=>p._1.io == OUTPUT_TYPE)
    Ports.foreach(x=>x.have("function","data"))

    val config_port = Port(INPUT_TYPE,false,false)
    config_port have ("function","control")
    config_port have("Word_Width",log2Ceil(input_ports.length + 1))
    this have config_port

    // Assign Virtual Source to Physical Port
    /*
    if(Sources nonEmpty){
      require(Sources.size == input_ports.length)
      for (s <- Sources.zipWithIndex.map(x=>(x._1._1,x._2))){
        val index = s._2
        val source_id = s._1
        Sources(source_id) = input_ports(index)._2
      }
    }
    if(Sinks nonEmpty){
      require(Sinks.size == output_ports.length)
      for (s <- Sinks.zipWithIndex.map(x=>(x._1._1,x._2))){
        val index = s._2
        val sink_id = s._1
        Sinks(sink_id) = output_ports(index)._2
      }
    }
    */

    // Calculate Intermediate Parameters
    val index_config_port = Ports.zipWithIndex
      .find(x=>x._1.get("function") == "control").get._2
    val index_input_data_port = input_ports
      .filter(x=>x._1.get("function") ==  "data")
      .map(_._2).toList
    val index_output_data_port = output_ports
      .filter(x=>x._1.get("function") ==  "data")
      .map(_._2).toList
    val select2index : Map[Int,Int] = Map[Int,Int]()
    for (sel <- index_input_data_port.indices)
      select2index += sel -> input_ports(index_input_data_port(sel))._2

    // Store Parameters
    have("select2input",select2index)
  }
}

class Multiplexer_Hw(p:Entity) extends Module {

  val io  = IO(MixedVec(get_io(p.Ports)))

  // Extract Parameter

  val index_config_port = p.Ports.zipWithIndex
    .find(p=>p._1.get("function") == "control").get._2
  val index_input_data_ports = p.Ports.zipWithIndex
    .filter(p=>p._1.get("IO_Type") == "INPUT" && p._1.get("function") == "data")
    .map(x=>x._2)
  val index_output_data_ports = p.Ports.zipWithIndex
    .find(p=>p._1.get("IO_Type") == "OUTPUT").get
    ._2

  val select2index = p.get("select2input").asInstanceOf[Map[Int,Int]]

  // Calculate Intermediate Parameter
  val num_options = index_input_data_ports.length
  val num_config_bit = log2Ceil(num_options)
  val output_index = index_output_data_ports

  // ------ Hardware Operation ------
  val config = Wire(UInt(num_config_bit.W))
  config := io(index_config_port)


  // default
  io(output_index) match {
    case x:DecoupledIO[UInt] =>
      x.bits:= 0.U;x.valid := 0.U
      for (i<- index_input_data_ports)
        io(i).asInstanceOf[DecoupledIO[UInt]].ready := false.B
    case x:ValidIO[UInt] =>
      x.bits:= 0.U;x.valid := 0.U
    case x:UInt =>
      x := 0.U
  }


  // operation
  for (s2i <- select2index){
    val select = s2i._1.asInstanceOf[Int]
    val input= s2i._2.asInstanceOf[Int]
    when(config === select.U){
      io(output_index) <> io(input)
    }
  }
}
