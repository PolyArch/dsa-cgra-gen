package basic

import chisel3._
import chisel3.util._
import basic.IO_Interface._

import scala.collection.mutable.Map

case class Multiplexer() extends Entity
  with RegisterControlled
  with WithWordWidth {
  def forsyn: Unit = {
    // Initialize the Parameter
    assign_index
    val input_ports = ports.filter(p=>p.io == "INPUT")
    val output_ports = ports.filter(p=>p.io == "OUTPUT")

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

    have("index_config_port",index_config_port)
    have("index_input_data_port",index_input_data_port)
    have("index_output_data_port",index_output_data_port)
    have("select2input",select2index)
  }
}

class Multiplexer_Hw(p:Multiplexer) extends Module {
  val io = IO(get_io(p.ports))

  // Extract Parameter
  val index_config_port = p.get("index_config_port").asInstanceOf[Int]
  val index_input_data_ports = p.get("index_input_data_port").asInstanceOf[List[Int]]
  val index_output_data_ports = p.get("index_output_data_port").asInstanceOf[List[Int]]
  val select2index = p.get("select2input").asInstanceOf[Map[Int,Int]]

  // Calculate Intermediate Parameter
  val num_options = index_input_data_ports.length
  val num_config_bit = log2Ceil(num_options)
  val output_index = index_output_data_ports.head

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
    val select = s2i._1
    val input = s2i._2
    when(config === select.U){
      io(output_index).asInstanceOf[DecoupledIO[UInt]] <> io(input).asInstanceOf[DecoupledIO[UInt]]
    }
  }
}
