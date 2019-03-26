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
    if (num_output >= num_input){
      for (i <- 0 until num_vector){
        val io_in_decoup = Wire(DecoupledIO(UInt(data_word_width.W)))
        val in_config_decoup = Wire(DecoupledIO(Bool()))

        io_in_decoup.bits <> io.in.head.bits;   in_config_decoup.bits <> io.in.head.config
        io_in_decoup.valid := (io.in.head.valid && (i.U === distribute_counter))
        in_config_decoup.valid := (io.in.head.valid && (i.U === distribute_counter))
        io_in_decoup.ready <> io.in.head.ready; in_config_decoup.ready <> io.in.head.ready

        val bit_decoup = Queue(io_in_decoup,p.channel_buffer)
        val config_decoup = Queue(in_config_decoup,p.channel_buffer)

        io.out(i).bits <> bit_decoup.bits
        io.out(i).config <> config_decoup.bits
        io.out(i).valid <> bit_decoup.valid
        io.out(i).valid <> config_decoup.valid
        io.out(i).ready <> bit_decoup.ready
        io.out(i).ready <> config_decoup.ready
      }
    }else{
      val vector_registers = Reg(Vec(num_vector,ReqAckConf_t(data_word_width)))
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
