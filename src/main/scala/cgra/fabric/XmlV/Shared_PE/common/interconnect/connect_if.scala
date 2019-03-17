package cgra.fabric.XmlV.Shared_PE.common.interconnect

import cgra.entity.Entity
import cgra.fabric.XmlV.Shared_PE.parameters.derived_parameters
import chisel3._
import chisel3.util._

class channel_if_sender(p:Entity) extends Bundle with derived_parameters{
  parameter_update(p)
  // data packet
  val pack = Output(new packet_t(TIA_TAG_WIDTH,TIA_WORD_WIDTH))
  val next_pack = Output(new packet_t(TIA_TAG_WIDTH,TIA_WORD_WIDTH))
  // channel action
  val dequeue = Input(Bool())
  // channel status
  val empty = Output(Bool())
  val count = Output(UInt(TIA_CHANNEL_BUFFER_COUNT_WIDTH.W))
  override def cloneType =
    new channel_if_sender(p).asInstanceOf[this.type]
}

class channel_if_receiver(p:Entity) extends Bundle with derived_parameters{
  parameter_update(p)
  // data packet
  val pack = Input(new packet_t(TIA_TAG_WIDTH,TIA_WORD_WIDTH))
  // channel action
  val enqueue = Input(Bool())
  // channel status
  val full = Output(Bool())
  val count = Output(UInt(TIA_CHANNEL_BUFFER_COUNT_WIDTH.W))
  override def cloneType =
    new channel_if_receiver(p).asInstanceOf[this.type]
}

class channel_if_sender_t(p:Entity) extends Bundle with derived_parameters{
  parameter_update(p)
  val pack = new packet_t(TIA_TAG_WIDTH,TIA_WORD_WIDTH)
  val next_pack = new packet_t(TIA_TAG_WIDTH,TIA_WORD_WIDTH)
  val dequeue = Bool()
  val empty = Bool()
  val count = UInt(TIA_CHANNEL_BUFFER_COUNT_WIDTH.W)
  override def cloneType =
    new channel_if_sender_t(p).asInstanceOf[this.type]
}

class channel_if_receiver_t(p:Entity) extends Bundle with derived_parameters{
  parameter_update(p)
  val pack = new packet_t(TIA_TAG_WIDTH,TIA_WORD_WIDTH)
  val enqueue = Bool()
  val full = Bool()
  val count = UInt(TIA_CHANNEL_BUFFER_COUNT_WIDTH.W)
  override def cloneType =
    new channel_if_receiver_t(p).asInstanceOf[this.type]
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
  val req = Input(Bool())
  val ack = Output(Bool())
}

class packet_t(tag_width:Int,word_width:Int) extends Bundle {

  val tag = UInt(tag_width.W)
  val data = UInt(word_width.W)
  override def cloneType =
    new packet_t(tag_width,word_width).asInstanceOf[this.type]
}