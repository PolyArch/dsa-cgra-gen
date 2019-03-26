package cgra.fabric

import cgra.IO.{ReqAckConf_if, ReqAckConf_t}
import cgra.IR.vector_port
import cgra.config.system
import chisel3._
import chisel3.util._


class VectorPort_Hw(name_p:(String,vector_port)) extends Module
  with Has_IO{
  private val module_name = name_p._1
  private val p = name_p._2
  private val num_input = p.input_ports.length
  private val num_output = p.output_ports.length
  private val data_word_width = system.data_word_width

  val io = IO(new Bundle{
    val in = Flipped(Vec(num_input,ReqAckConf_if(data_word_width)))
    val out = Vec(num_output,ReqAckConf_if(data_word_width))
  })

  private val num_vector = num_input max num_output

  if(num_vector > 1){
    val distribute_counter = RegInit(0.U(log2Ceil(num_vector).W))
    val vector_registers = Reg(Vec(num_vector,ReqAckConf_t(data_word_width)))

    if (num_output >= num_input){
      for (i <- 0 until num_vector)
        io.out(i) <>  vector_registers(i)
      vector_registers(distribute_counter) <> io.in.head
    }else{
      for (i <- 0 until num_vector)
        vector_registers(i) <> io.in(i)
      io.out.head <> vector_registers(distribute_counter)
    }

    distribute_counter := distribute_counter + 1.U
  }else{
    io.out.head <> io.in.head
  }

  def get_port (io_t:String,name:String) = {
    io_t match {
      case "in"   => io.in(p.input_ports.indexOf(name))
      case "out"  => io.out(p.output_ports.indexOf(name))
    }
  }
}
