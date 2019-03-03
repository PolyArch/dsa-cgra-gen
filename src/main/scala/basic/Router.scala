package basic

import chisel3._
import chisel3.util._
import basic.IO_Interface._
import basic.Constant._
import scala.collection.mutable.{ListBuffer, Map}

case class Router() extends Entity
  with WithRegisterFile
  with WithDecomposer
  with WithWordWidth {
  def forsyn:Unit = {
    entity_type = this.getClass.getName
    var temp_port: ListBuffer[Port] = new ListBuffer[Port]()
    val ori_input_ports:ListBuffer[Port] = Ports.filter(p=>p.io == INPUT_TYPE)
    val ori_output_ports:ListBuffer[Port] = Ports.filter(p=>p.io == OUTPUT_TYPE)
    val ori_control_ports:ListBuffer[Port] = Ports.filter(p=>p.io == MMIO_TYPE)
    val input_decomposer = get("input_decomposer").asInstanceOf[List[Int]]
    val output_decomposer = get("output_decomposer").asInstanceOf[List[Int]]
    val decompoed_input_ports = decompose_ports(ori_input_ports,input_decomposer)
    val decompoed_output_ports = decompose_ports(ori_output_ports,output_decomposer)
    decompoed_input_ports.foreach(temp_port += _)
    decompoed_output_ports.foreach(temp_port += _)
    ori_control_ports.foreach(temp_port += _)
    Ports --= Ports;temp_port.foreach(Ports += _)
    assign_index
  }
  def decompose_ports(ports:ListBuffer[Port],decomp:List[Int]):ListBuffer[Port]={
    require(ports.length == decomp.length)
    val temp_ports: ListBuffer[Port] = new ListBuffer[Port]()
    for(i <- ports.indices){
      val temp_p = decompose_port(ports(i),decomp(i))
      temp_p.foreach(p=>temp_ports += p)
    }
    temp_ports
  }
  def decompose_port(p:Port,de:Int):ListBuffer[Port]={
    val temp_ports: ListBuffer[Port] = new ListBuffer[Port]()
    for (i <- 0 until de){
      val temp_port = Port(p.io,p.hasValid,p.hasReady)
      temp_port.have("Word_Width",p.get("Word_Width").asInstanceOf[Int]/de)
      temp_ports += temp_port
    }
    temp_ports
  }
}

class Router_Hw(p:Router) extends Module {
  val io = IO(get_io(p.Ports))

}