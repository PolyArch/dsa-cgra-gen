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
    val in = Flipped(DecoupledIO(UInt(data_width.W)))
    val out = DecoupledIO(UInt(data_width.W))
    val delay = Input(UInt(log2Ceil(1 + max_delay).W))
  })

  if(flow_control){// Delay FIFO
    // create fifo use internal lib
    val queue_in : DecoupledIO[UInt] = Wire(DecoupledIO(UInt(data_width.W)))
    // connect input
    queue_in.bits := io.in.bits
    queue_in.valid := io.in.valid
    queue_in.ready <> io.in.ready
    // connect output
    val queue_out = Queue(queue_in,max_delay)
    io.out.bits := queue_out.bits
    io.out.valid := queue_out.valid
    io.out.ready <> queue_out.ready
  }else{// Delay Pipe
    io.in.ready := io.delay < max_delay.U
    // Create flip-flop array to store data
    val pipe = RegInit(VecInit(Seq.fill(max_delay)(0.U((data_width + 1).W))))
    // Create head and tail pointer
    val head_ptr = RegInit(0.U(log2Ceil(max_delay).W))
    val tail_ptr = RegInit(0.U(log2Ceil(max_delay).W))
    // ------ Logic connections ------
    // read and write
    // Out
    io.out.bits := pipe(head_ptr)(data_width-1,0)
    io.out.valid := pipe(head_ptr)(data_width)
    // In
    pipe(tail_ptr) := Cat(io.in.valid,io.in.bits)
    // update the pointer
    head_ptr := head_ptr + 1.U
    tail_ptr := head_ptr + 1.U + io.delay
  }
}
