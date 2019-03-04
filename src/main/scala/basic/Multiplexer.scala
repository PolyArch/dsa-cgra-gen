package basic

import chisel3._
import chisel3.util._
import basic.IO_Interface._
import basic.Constant._

import scala.collection.mutable.Map

case class Multiplexer() extends Entity
  with RegisterControlled
  with WithWordWidth {
  entity_type = this.getClass.getName
  def forsyn: Unit = {
    // Initialize the Parameter
    assign_index(Ports)
    val input_ports = Ports.filter(p=>p.io == INPUT_TYPE)
    val output_ports = Ports.filter(p=>p.io == OUTPUT_TYPE)

    // Assign Virtual Source to Physical Port
    if(Sources nonEmpty){
      require(Sources.size == input_ports.length)
      for (s <- Sources.zipWithIndex.map(x=>(x._1._1,x._2))){
        val index = s._2
        val source_id = s._1
        Sources(source_id) = input_ports(index).get("Index").asInstanceOf[Int]
      }
    }
    if(Sinks nonEmpty){
      require(Sinks.size == output_ports.length)
      for (s <- Sinks.zipWithIndex.map(x=>(x._1._1,x._2))){
        val index = s._2
        val sink_id = s._1
        Sinks(sink_id) = output_ports(index).get("Index").asInstanceOf[Int]
      }
    }

    // Calculate Intermediate Parameters
    val index_config_port = input_ports.find(x=>x.get("function") == "control").get.get("Index")
    val index_input_data_port = input_ports
      .filter(x=>x.get("function") ==  "data")
      .map(_.get("Index").asInstanceOf[Int]).toList
    val index_output_data_port = output_ports
      .filter(x=>x.get("function") ==  "data")
      .map(_.get("Index").asInstanceOf[Int]).toList
    val select2index : Map[Int,Int] = Map[Int,Int]()
    for (sel <- index_input_data_port.indices)
      select2index += sel -> input_ports(index_input_data_port(sel)).get("Index").asInstanceOf[Int]

    // Store Parameters
    have("select2input",select2index)
  }
}

class Multiplexer_Hw(p:Entity) extends Module {
  val io = IO(get_io(p.Ports))
  // Extract Parameter

  val index_config_port = p.Ports
    .filter(p=>p.get("function").asInstanceOf[String] == "control")
    .head.get("Index").asInstanceOf[Int]
  val index_input_data_ports = p.Ports
    .filter(p=>p.get("IO_Type").asInstanceOf[String] == "INPUT" && p.get("function").asInstanceOf[String] == "data")
    .map(x=>x.get("Index").asInstanceOf[Int])
  val index_output_data_ports = p.Ports
    .filter(p=>p.get("IO_Type").asInstanceOf[String] == "OUTPUT")
    .map(x=>x.get("Index").asInstanceOf[Int]).head

  val select2index = p.get("select2input").asInstanceOf[Map[PValue,PValue]]

  // Calculate Intermediate Parameter
  val num_options = index_input_data_ports.length
  val num_config_bit = log2Ceil(num_options)
  val output_index = index_output_data_ports

  // ------ Hardware Operation ------
  val config = Wire(UInt(num_config_bit.W))
  config := io(index_config_port)
  // default
  io(output_index).asInstanceOf[DecoupledIO[UInt]].bits := 0.U
  io(output_index).asInstanceOf[DecoupledIO[UInt]].valid := 0.U
  for (i<- index_input_data_ports)
    io(i).asInstanceOf[DecoupledIO[UInt]].ready := false.B

  // operation
  for (s2i <- select2index){
    val select = s2i._1.value.asInstanceOf[Int]
    val input= s2i._2.value.asInstanceOf[Int]
    when(config === select.U){
      io(output_index).asInstanceOf[DecoupledIO[UInt]] <> io(input).asInstanceOf[DecoupledIO[UInt]]
    }
  }
}
