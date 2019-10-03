package cgra.fabric

import cgra.IO.ReqAckConf_if
import chisel3._
import chisel3.util._

class delay(datawidth:Int,
            max_delay:Int,
            flow_control:Boolean) extends Module{
  // ------ Create Hardware ------
  // create IO
  val io = IO(new Bundle{
    val in = Flipped(ReqAckConf_if(datawidth))
    val out = ReqAckConf_if(datawidth)
    val delay = Input(UInt(log2Ceil(1 + max_delay).W))
  })
  // Dont Care the config bit
  io.in.config := DontCare;io.out.config := DontCare

  if(flow_control){// Delay FIFO
    // create fifo use internal lib
    val queue_in : DecoupledIO[UInt] = Wire(DecoupledIO(UInt(datawidth.W)))
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
    //Don't Care control bit
    io.in.valid := DontCare; io.out.valid := DontCare
    io.in.ready := DontCare; io.out.ready := DontCare
    // Create flip-flop array to store data
    val pipe = RegInit(VecInit(Seq.fill(max_delay)(0.U(datawidth.W))))
    // Create head and tail pointer
    val head_ptr = RegInit(0.U(log2Ceil(max_delay).W))
    val tail_ptr = RegInit(0.U(log2Ceil(max_delay).W))
    // ------ Logic connections ------
    // read and write
    io.out.bits := pipe(head_ptr)
    pipe(tail_ptr) := io.in.bits
    // update the pointer
    head_ptr := head_ptr + 1.U
    tail_ptr := head_ptr + 1.U + io.delay
  }
}
