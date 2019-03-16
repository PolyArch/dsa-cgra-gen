package cgra.fabric

import cgra.IR.vector_port
import chisel3._
import chisel3.util._
import cgra.config.system.word_width


class VectorPort_Hw(iv:vector_port) extends Module
  with Has_IO{
  private val num_input = iv.getInput_ports.length
  private val num_output = iv.getOutput_ports.length

  val io = IO(new Bundle{
    val in = Flipped(Vec(num_input,DecoupledIO(UInt(word_width.W))))
    val out = Vec(num_output,DecoupledIO(UInt(word_width.W)))
  })

  def get_port (io_t:String,name:String) = {
    io_t match {
      case "in" => io.in(iv.input_ports.indexOf(name))
      case "out" => io.out(iv.output_ports.indexOf(name))
    }
  }
}
