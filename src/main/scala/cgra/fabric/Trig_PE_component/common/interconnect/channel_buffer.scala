package cgra.fabric.Trig_PE_component.common.interconnect


import cgra.fabric.Trig_PE_component.tia_parameters.derived_parameters._
import cgra.fabric.Trig_PE_component.tia_parameters.fixed_parameters._
import chisel3._
import chisel3.util._

class channel_buffer extends Module{
  val bufferDepth = TIA_CHANNEL_BUFFER_FIFO_DEPTH
  val io = IO(new Bundle{
    val enable = Input(Bool())
    val sender = new channel_if_sender
    val receiver = new channel_if_receiver
  })

  // Initialize FIFO
  val fifo = RegInit(VecInit(Seq.fill(bufferDepth)(0.U((TIA_TAG_WIDTH+TIA_WORD_WIDTH).W))))

  // Interal state
  val count = RegInit(0.U(log2Ceil(bufferDepth + 1).W))
  val head = RegInit(0.U(log2Ceil(bufferDepth).W))
  val neck:UInt = head + 1.U
  val tail = RegInit(0.U(log2Ceil(bufferDepth).W))

  val isEmpty:Bool = count === 0.U
  val isFull:Bool = count === bufferDepth.U
  val deq:Bool = io.sender.dequeue
  val enq:Bool = io.receiver.enqueue

  // Output tag and data
  val out_tag_data = Wire(UInt((TIA_TAG_WIDTH+TIA_WORD_WIDTH).W))
  val out_tag = Wire(UInt(TIA_TAG_WIDTH.W))
  val out_data = Wire(UInt(TIA_WORD_WIDTH.W))
  out_tag := out_tag_data(TIA_TAG_WIDTH + TIA_WORD_WIDTH - 1,TIA_WORD_WIDTH)
  out_data := out_tag_data(TIA_WORD_WIDTH - 1,0)

  // Output next tag and data
  val outNext_tag_data = Wire(UInt((TIA_TAG_WIDTH+TIA_WORD_WIDTH).W))
  val outNext_tag = Wire(UInt(TIA_TAG_WIDTH.W))
  val outNext_data = Wire(UInt(TIA_WORD_WIDTH.W))
  outNext_tag := outNext_tag_data(TIA_TAG_WIDTH + TIA_WORD_WIDTH - 1,TIA_WORD_WIDTH)
  outNext_data := outNext_tag_data(TIA_WORD_WIDTH - 1,0)

  // output from channel
  out_tag_data := fifo(head)
  outNext_tag_data := Mux(count>1.U,fifo(neck),0.U)
  io.sender.pack.tag := out_tag
  io.sender.pack.data := out_data
  io.sender.next_pack.tag := outNext_tag
  io.sender.next_pack.data := outNext_data
  io.sender.empty := isEmpty
  io.sender.count := count

  // input to channel
  val in_tag_data = Wire(UInt((TIA_TAG_WIDTH+TIA_WORD_WIDTH).W))
  in_tag_data := Cat(io.receiver.pack.tag,io.receiver.pack.data)
  io.receiver.full := isFull
  io.receiver.count := count

  // Logic
  when(reset.toBool()){
    count := 0.U
    head := 0.U
    tail := 0.U
  }.elsewhen(io.enable){
    when(deq){// dequeue
      when(!isEmpty){
        when(enq){ // deq + enq when not full
          fifo(tail) := in_tag_data
          head := head + 1.U
          tail := tail + 1.U
        }.otherwise{ // only deq
          head := head + 1.U
          count := count - 1.U
        }
      }
    }.elsewhen(enq && !isFull){ // enq when not full
      fifo(tail) := in_tag_data
      tail := tail + 1.U
      count := count + 1.U
    }
  }
}

class output_channel_buffer extends Module {
  val io = IO(
    new Bundle {
      val enable = Input(Bool())
      val in = new channel_if_receiver
      val out = new link_if_out(TIA_TAG_WIDTH,TIA_WORD_WIDTH)
      val quiescent = Output(Bool())
    }
  )

  val channel_buffer = Module(new channel_buffer).io

  // capitulate to link
  io.out.packet.tag := channel_buffer.sender.pack.tag
  io.out.packet.data := channel_buffer.sender.pack.data
  channel_buffer.sender.dequeue := io.out.valid
  io.out.ready := !channel_buffer.sender.empty

  // match interface
  channel_buffer.enable := io.enable
  channel_buffer.receiver <> io.in
  io.quiescent := channel_buffer.sender.empty
}

class input_channel_buffer extends Module {
  val io = IO(
    new Bundle {
      val enable = Input(Bool())
      val in = new link_if_in(TIA_TAG_WIDTH,TIA_WORD_WIDTH)
      val out = new channel_if_sender
      val quiescent = Output(Bool())
    }
  )

  val channel_buffer = Module(new channel_buffer).io

  // capitulate to link
  channel_buffer.receiver.enqueue := io.in.valid
  channel_buffer.receiver.pack.tag := io.in.packet.tag
  channel_buffer.receiver.pack.data := io.in.packet.data
  io.in.ready := !channel_buffer.receiver.full

  // match interface
  channel_buffer.enable := io.enable
  io.out <> channel_buffer.sender
  io.quiescent := channel_buffer.sender.empty
}