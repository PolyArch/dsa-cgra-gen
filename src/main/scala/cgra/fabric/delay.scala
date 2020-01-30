package cgra.fabric

import cgra.IO.ReqAckConf_if
import chisel3._
import chisel3.util._

class delay(data_width:Int,
            max_delay:Int,
            flow_control:Boolean) extends Module{
  // ------ Create Hardware ------
  // create IO
  val io = IO(new Bundle{
    val en = Input(Bool())
    val in = Flipped(DecoupledIO(UInt(data_width.W)))
    val out = DecoupledIO(UInt(data_width.W))
    val delay = Input(UInt(log2Ceil(1 + max_delay).W))
  })

  var printable_message : Printable = p"hello\n"

  val pipe : Vec[UInt]= if(flow_control) {
    RegInit(VecInit(Seq.fill(1)(0.U(1.W))))
  }else {
    RegInit(VecInit(Seq.fill(max_delay)(0.U((data_width + 1).W))))
  }
  val head_ptr, tail_ptr = if(flow_control) {
    RegInit(0.U(1.W))
  }else {
    RegInit(0.U({log2Ceil(max_delay) max 1}.W))
  }

  if(flow_control){// Delay FIFO
    // create fifo use internal lib
    val queue_in : DecoupledIO[UInt] = Wire(DecoupledIO(UInt(data_width.W)))
    // connect input
    queue_in.bits := io.in.bits
    queue_in.valid := io.in.valid && io.en
    queue_in.ready <> io.in.ready
    // connect output
    val queue_out = Queue(queue_in,max_delay)
    io.out.bits := queue_out.bits
    io.out.valid := queue_out.valid
    io.out.ready <> queue_out.ready

    printable_message = {
      p"---- queue ----\n"+
        p"OUT: bits = ${io.out.bits}, valid = ${io.out.valid}, ready = ${io.out.ready}\n" +
        p"IN : bits = ${io.in.bits}, valid = ${io.in.valid}, ready = ${io.in.ready}\n" +
        p"enable = ${io.en}" +
        p"---- queue ----\n"
    }
  }else{// Delay Pipe
    io.in.ready := io.delay < max_delay.U
    // ------ Logic connections ------
    // read
    io.out.bits := pipe(head_ptr)(data_width-1,0)
    io.out.valid := pipe(head_ptr)(data_width)
    when(io.en){ // Move forward

      // In
      pipe(tail_ptr) := Cat(io.in.valid,io.in.bits)
      // update the pointer
      val nxt_head_ptr = head_ptr + 1.U
      val nxt_tail_ptr = head_ptr + 1.U + io.delay
      head_ptr := Mux(head_ptr === (max_delay - 1).U,0.U,nxt_head_ptr)
      tail_ptr := Mux(nxt_tail_ptr > (max_delay - 1).U,nxt_tail_ptr-max_delay.U,nxt_tail_ptr)
    }.otherwise{ // flush the pipe when not enable (clean pipe when reconfigured)
      for(loc <- 0 until max_delay){
        pipe(loc) := 0.U
      }
      head_ptr := 0.U
      tail_ptr := 0.U
    }

    printable_message = {
      val pipe_info = for(pipe_ptr <- 0 until max_delay) yield {
        p"$pipe_ptr : bits = ${pipe(pipe_ptr)(data_width-1,0)}, " +
          p"valid = ${pipe(pipe_ptr)(data_width)}\n"
      }
        p"---- pipe ----\n"+
          p"OUT: bits = ${io.out.bits}, valid = ${io.out.valid}, ready = ${io.out.ready}\n" +
          p"head = $head_ptr, tail = $tail_ptr\n" +
          pipe_info.reduce(_ + _) +
          p"IN : bits = ${io.in.bits}, valid = ${io.in.valid}, ready = ${io.in.ready}\n" +
          p"enable = ${io.en}, delay = ${io.delay}\n"+
          p"---- pipe ----\n"
    }
  }
  when(io.en){
    printf(printable_message)
  }
}



