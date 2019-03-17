package cgra.fabric.YamlV

import cgra.IR.dedicated_pe
import cgra.config.system.word_width
import chisel3._
import chisel3.util._

class Dedicated_PE_Hw(p:dedicated_pe) extends Module with Has_IO{
  private val num_input = p.getInput_ports.length
  private val num_output = p.getOutput_ports.length
  val io = IO(new Bundle{
    val in = Flipped(Vec(num_input,DecoupledIO(UInt(word_width.W))))
    val out = Vec(num_output,DecoupledIO(UInt(word_width.W)))
  })

  // ------ Util
  def get_port (io_t:String,name:String) = {
    io_t match {
      case "in" => io.in(p.input_ports.indexOf(name))
      case "out" => io.out(p.output_ports.indexOf(name))
    }
  }
  // ----- Test
  for (i <- 0 until num_input)
    io.in(i).ready := false.B
  for (o <- 0 until num_output){
    io.out(o).bits := 0.U
    io.out(o).valid := false.B
  }
}