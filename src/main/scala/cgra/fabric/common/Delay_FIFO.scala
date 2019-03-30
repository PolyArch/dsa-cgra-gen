package cgra.fabric.common

import cgra.IO.ReqAckConf_if
import cgra.IO.port_generator.gc_port
import cgra.fabric.Reconfigurable
import chisel3.util._
import chisel3._

import scala.xml.Elem

class Delay_FIFO extends Reconfigurable {
  var config_high : Int = -1
  var config_low : Int = -1
  var max_delay : Int = -1
  var pipe_word_width : Int = -1
  var sink : String = ""
  var subnet : Int = -1
  var operand : Int = -1
  var protocol : String = ""
  def config2XML : Elem = {
    <Delay_Pipe>
      <Config_High_Bit>{config_high}</Config_High_Bit>
      <Config_Low_Bit>{config_low}</Config_Low_Bit>
      <Max_Delay>{max_delay}</Max_Delay>
      <Idx_Operand>{operand}</Idx_Operand>
    </Delay_Pipe>
  }
}

class Delay_FIFO_Hw(p:Delay_FIFO) extends Module{
  val io = IO(new Bundle{
    val in = Flipped(ReqAckConf_if(p.pipe_word_width))
    val out = ReqAckConf_if(p.pipe_word_width)
    val delay = Input(UInt((1 max log2Ceil(1 max p.max_delay)).W))
  })
  gc_port(io.in,p.protocol)
  gc_port(io.out,p.protocol)
  if (p.max_delay > 0){
    if(p.protocol.contains("Ready")){
      // Delay FIFO
      val queue_in : DecoupledIO[UInt] = Wire(DecoupledIO(UInt(p.pipe_word_width.W)))
      queue_in.bits := io.in.bits
      queue_in.valid := io.in.valid
      queue_in.ready <> io.in.ready
      val queue_out = Queue(queue_in,p.max_delay)
      io.out.bits := queue_out.bits
      io.out.valid := queue_out.valid
      io.out.ready <> queue_out.ready
    }else if (p.protocol.contains("Data")){
      // Dalay Pipe
      val head = RegInit(0.U(log2Ceil(p.max_delay).W))
      val tail = RegInit(0.U(log2Ceil(p.max_delay).W))
      head := head + 1.U
      tail := head + 1.U + io.delay
      // Connect Data
      val fifo_bits = Reg(Vec(p.max_delay,UInt(p.pipe_word_width.W)))
      io.out.bits := fifo_bits(head)
      fifo_bits(tail) := io.in.bits
      // Connect Valid
      if(p.protocol.contains("Valid")){
        val fifo_valid = Reg(Vec(p.max_delay,Bool()))
        io.out.valid := fifo_valid(head)
        fifo_valid(tail) := io.in.valid
      }
    }
  }else{
    if(p.protocol.contains("Data"))
      io.out.bits <> io.in.bits
    if(p.protocol.contains("Valid"))
      io.out.valid <> io.in.valid
    if(p.protocol.contains("Ready"))
      io.out.ready <> io.in.ready
  }
}