package cgra.common.interconnect

import cgra.tia.parameters.derived_parameters._
import chisel3._
import chisel3.util._

class channel_if_sender(bufferDepth :Int) extends Bundle{
  // data packet
  val pack = Output(new packet_t)
  val next_pack = Output(new packet_t)
  // channel action
  val dequeue = Input(Bool())
  // channel status
  val empty = Output(Bool())
  val count = Output(UInt(log2Ceil(bufferDepth + 1).W))
  override def cloneType =
    new channel_if_sender(bufferDepth).asInstanceOf[this.type]
}

class channel_if_receiver(bufferDepth :Int) extends Bundle {
  // data packet
  val pack = Input(new packet_t)
  // channel action
  val enqueue = Input(Bool())
  // channel status
  val full = Output(Bool())
  val count = Output(UInt(log2Ceil(bufferDepth + 1).W))
  override def cloneType =
    new channel_if_receiver(bufferDepth).asInstanceOf[this.type]
}

class channel_if_sender_t(bufferDepth:Int) extends Bundle {
  val pack = new packet_t
  val next_pack = new packet_t
  val dequeue = Bool()
  val empty = Bool()
  val count = UInt(log2Ceil(bufferDepth + 1).W)
  override def cloneType =
    new channel_if_sender_t(bufferDepth).asInstanceOf[this.type]
}

class channel_if_receiver_t(bufferDepth :Int) extends Bundle {
  val pack = new packet_t
  val enqueue = Bool()
  val full = Bool()
  val count = UInt(log2Ceil(bufferDepth + 1).W)
  override def cloneType =
    new channel_if_receiver_t(bufferDepth).asInstanceOf[this.type]
}

class links_if_in(numLinks:Int) extends Bundle {
  val in_links = Vec(numLinks,new link_if_in)
  override def cloneType =
    new links_if_in(numLinks).asInstanceOf[this.type]
}

class link_if_out extends ReqAckIO {
  // packet
  val packet = Output(new packet_t)
}

class link_if_in extends ReqAckIO {
  // packet
  val packet = Input(new packet_t)
}

class ReqAckIO extends Bundle {
  val req = Input(Bool())
  val ack = Output(Bool())
}

class packet_t extends Bundle{
  val tag = UInt(TIA_TAG_WIDTH.W)
  val data = UInt(TIA_WORD_WIDTH.W)
}