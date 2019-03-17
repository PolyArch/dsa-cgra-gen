package cgra.fabric.XmlV.common

import cgra.entity._
import cgra.config.Constant._
import chisel3._
import chisel3.util._
import cgra.IO.IO_Interface._

case class Delay_Pipe() extends Entity
  with RegisterControlled {
  entity_type = this.getClass.getName
  def forsyn :Unit = {
    // Need to define two things
    val word_width = this.get("Word_Width")
    val max_delay = get("Max_Delay").asInstanceOf[Int]
    // Add Port
    Ports += Port(INPUT_TYPE,false,false) += Port(OUTPUT_TYPE,false,false)
    Ports.foreach(p=>{p.have("function","data");p.have("Word_Width",word_width)})
    val config_port = Port(INPUT_TYPE,false,false)
    val config_width = log2Ceil(max_delay + 1)
    have ("config_width",config_width)
    config_port have("Word_Width",config_width);config_port have("function","control")
    Ports += config_port
  }
}



class Delay_Pipe_Hw(p:Entity) extends Module{
  val io  = IO(MixedVec(get_io(p.Ports)))

  val data_width = p.get("Word_Width").asInstanceOf[Int]
  val max_delay = p.get("Max_Delay").asInstanceOf[Int]
  val config_width = p.get("config_width").asInstanceOf[Int]
  val in_index = p.Ports.zipWithIndex.find(p=>p._1.get("function") == "data" && p._1.io == INPUT_TYPE).get._2
  val out_index = p.Ports.zipWithIndex.find(p=>p._1.get("function") == "data" && p._1.io == OUTPUT_TYPE).get._2
  val config_index = p.Ports.zipWithIndex.find(p=>p._1.get("function") == "control" && p._1.io == INPUT_TYPE).get._2

  val in_port = io(in_index).asInstanceOf[UInt]
  val out_port = io(out_index).asInstanceOf[UInt]
  val config_port = io(config_index).asInstanceOf[UInt]

  // Pointer
  val head = RegInit(0.U(log2Ceil(max_delay + 1).W))
  val tail = RegInit(0.U(log2Ceil(max_delay + 1).W))
  val delay =  RegInit(0.U(config_width.W))

  // Actual FIFO
  val fifo = RegInit(VecInit(Seq.fill(max_delay)(0.U((data_width).W))))

  // Pressure pass immediately
  out_port := fifo(head)
  fifo(tail) := in_port
  head := head + 1.U
  tail := tail + 1.U

  // --- Configuration ---
  when (delay =/= config_port) {
    for (i <- 0 until max_delay){
      fifo(i) := 0.U // flash the pipe
    }
    tail := config_port
    delay := config_port
  }
}