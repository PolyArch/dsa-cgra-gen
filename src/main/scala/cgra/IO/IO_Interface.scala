package cgra.IO

import chisel3._
import chisel3.util._

case class mmio_if(index_width:Int,word_width:Int) extends Bundle {
  // DEVICE that store data, **use Flipped(new mmio_if) for those who consume data (like ALU)
  val read_req = Input(Bool())
  val read_ack = Output(Bool())
  val read_index = Input(UInt(index_width.W))
  val read_data = Output(UInt(word_width.W))

  val write_req = Input(Bool())
  val write_ack = Output(Bool())
  val write_index = Input(UInt(index_width.W))
  val write_data = Input(UInt(word_width.W))
}

case class ReqAckConf_if(ww:Int) extends Bundle {
  val valid = Output(Bool())
  val bits = Output(UInt(ww.W))
  val ready = Input(Bool())
  val config = Output(Bool())

  override def cloneType: ReqAckConf_if.this.type = ReqAckConf_if(ww).asInstanceOf[this.type]
}

class VecDecoupledIO_conf(nIn:Int, nOut:Int, w:Int,conf_w:Int)
  extends VecDecoupledIO(nIn, nOut, w){
  val config = Flipped(ValidIO(UInt(conf_w.W)))

  override def cloneType: VecDecoupledIO_conf.this.type =
    new VecDecoupledIO_conf(nIn, nOut, w, conf_w).asInstanceOf[this.type]
}

class EnabledVecDecoupledIO(nIn:Int, nOut:Int, w:Int) extends Bundle {
  val en = Input(Bool()) // Enable

  // Input
  val input_ports =
    Flipped(Vec(nIn, DecoupledIO(UInt(w.W))))

  // Output
  val output_ports =
    Vec(nOut, DecoupledIO(UInt(w.W)))

  override def cloneType: EnabledVecDecoupledIO.this.type =
    new EnabledVecDecoupledIO(nIn, nOut, w).asInstanceOf[this.type]
}

class VecDecoupledIO(nIn:Int, nOut:Int, w:Int) extends Bundle {
  val input_ports =
    Flipped(Vec(nIn, DecoupledIO(UInt(w.W))))
  val output_ports =
    Vec(nOut, DecoupledIO(UInt(w.W)))

  override def cloneType: VecDecoupledIO.this.type =
    new VecDecoupledIO(nIn, nOut, w).asInstanceOf[this.type]
}

case class ReqAckConf_t(ww:Int) extends Bundle{
  val valid : Bool = Bool()
  val bits : UInt = UInt(ww.W)
  val ready : Bool = Bool()
  val config : Bool = Bool()
  override def cloneType: ReqAckConf_t.this.type = ReqAckConf_t(ww).asInstanceOf[this.type]
}

object port_generator {
  def gc_port (p:ReqAckConf_if, t:String):Unit={
    if(!t.contains("Data"))
      p.bits := DontCare
    if(!t.contains("Valid"))
      p.valid := DontCare
    if(!t.contains("Ready"))
      p.ready := DontCare
    if(!t.contains("Config"))
      p.config := DontCare
  }
}

case class config_wire(ww:Int) extends Bundle {
  val bits = UInt(ww.W)
  val config = Bool()
}

class has_bits_io(ww:Int) extends Bundle {
  val bits : UInt = Output(UInt(ww.W))
}

trait has_valid_io extends Bundle {
  val valid : Bool = Output(Bool())
}

trait has_ready_io extends Bundle {
  val ready : Bool = Input(Bool())
}

trait has_config_io extends Bundle {
  val config : Bool = Output(Bool())
}
