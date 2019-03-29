package cgra.fabric

import cgra.IO.{ReqAckConf_if, ReqAckConf_t}
import cgra.config.system
import chisel3._
import chisel3.util._

import scala.collection.mutable


class VectorPort_Hw(pp:(String,Any)) extends Module{
  val p:mutable.Map[String,Any] = pp._2.asInstanceOf[mutable.Map[String,Any]]
  private val module_name = pp._1
  private val input_ports : List[String] = p("input_ports").asInstanceOf[List[String]]
  private val output_ports : List[String] = p("output_ports").asInstanceOf[List[String]]
  private val num_input = input_ports.length
  private val num_output = output_ports.length
  private val channel_buffer : Int = p("channel_buffer").asInstanceOf[Int]
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

        val bit_decoup = Queue(io_in_decoup,channel_buffer)
        val config_decoup = Queue(in_config_decoup,channel_buffer)

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
}
