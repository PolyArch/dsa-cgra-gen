package cgra.fabric.Shared_PE_component.common.interconnect


import cgra.fabric.Shared_PE_component.tia_parameters.derived_parameters._
import cgra.fabric.Shared_PE_component.tia_parameters.fixed_parameters._
import chisel3._
import chisel3.util._

class channel_if_sender extends Bundle{
  // data packet
  val pack = Output(new packet_t(TIA_TAG_WIDTH,TIA_WORD_WIDTH))
  val next_pack = Output(new packet_t(TIA_TAG_WIDTH,TIA_WORD_WIDTH))
  // channel action
  val dequeue = Input(Bool())
  // channel status
  val empty = Output(Bool())
  val count = Output(UInt(TIA_CHANNEL_BUFFER_COUNT_WIDTH.W))

}

class channel_if_receiver extends Bundle{
  // data packet
  val pack = Input(new packet_t(TIA_TAG_WIDTH,TIA_WORD_WIDTH))
  // channel action
  val enqueue = Input(Bool())
  // channel status
  val full = Output(Bool())
  val count = Output(UInt(TIA_CHANNEL_BUFFER_COUNT_WIDTH.W))
}

class channel_if_sender_t extends Bundle {
  val pack = new packet_t(TIA_TAG_WIDTH,TIA_WORD_WIDTH)
  val next_pack = new packet_t(TIA_TAG_WIDTH,TIA_WORD_WIDTH)
  val dequeue = Bool()
  val empty = Bool()
  val count = UInt(TIA_CHANNEL_BUFFER_COUNT_WIDTH.W)
}

class channel_if_receiver_t extends Bundle {
  val pack = new packet_t(TIA_TAG_WIDTH,TIA_WORD_WIDTH)
  val enqueue = Bool()
  val full = Bool()
  val count = UInt(TIA_CHANNEL_BUFFER_COUNT_WIDTH.W)
}

class link_if_out(tag_width:Int,word_width:Int) extends ReqAckIO {
  // packet
  val packet = Output(new packet_t(tag_width,word_width))

  override def cloneType: link_if_out.this.type = new link_if_out(tag_width,word_width).asInstanceOf[this.type]
}

class link_if_in(tag_width:Int,word_width:Int) extends ReqAckIO {
  // packet
  val packet = Input(new packet_t(tag_width,word_width))
  override def cloneType =
    new link_if_in(tag_width,word_width).asInstanceOf[this.type]
}

class ReqAckIO extends Bundle {
  val valid = Input(Bool())
  val ready = Output(Bool())
}

class packet_t(tag_width:Int,word_width:Int) extends Bundle {
  val tag = UInt(tag_width.W)
  val data = UInt(word_width.W)
  override def cloneType =
    new packet_t(tag_width,word_width).asInstanceOf[this.type]
}