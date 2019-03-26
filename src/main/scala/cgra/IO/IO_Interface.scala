package cgra.IO

import chisel3._

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

case class ReqAckConf_t(ww:Int) extends Bundle{
  val valid : Bool = Bool()
  val bits : UInt = UInt(ww.W)
  val ready : Bool = Bool()
  val config : Bool = Bool()
}