package cgra.fabric.YamlV

import cgra.IO.ReqAckConf_if
import cgra.IR.shared_pe
import cgra.config.derived_system._
import cgra.config.system
import chisel3._
import chisel3.util._

import scala.xml.Elem

class Shared_PE_Hw(name_p:(String,shared_pe)) extends Module
  with Has_IO
  with Reconfigurable {
  private val module_name = name_p._1
  private val p = name_p._2
  private val num_input = p.input_ports.length
  private val num_output = p.output_ports.length
  private val data_word_width = system.data_word_width

  // ------ Define Input Output
  val io = IO(new Bundle{
    val in = Flipped(Vec(num_input,ReqAckConf_if(data_word_width)))
    val out = Vec(num_output,ReqAckConf_if(data_word_width))
  })

  def get_port (io_t:String,name:String) = {
    io_t match {
      case "in" => io.in(p.input_ports.indexOf(name))
      case "out" => io.out(p.output_ports.indexOf(name))
    }
  }


  // ----- Test

  for(i <- 0 until num_input)
    io.in(i) <> io.out(num_input - 1 - i)

  def config2XML : Elem = {
    <Shared_PE>
      <Module_Name>{module_name}</Module_Name>
      <Module_ID>{p.module_id}</Module_ID>
    </Shared_PE>
  }
}
