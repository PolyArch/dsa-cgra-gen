package cgra.common.datapath

import cgra.common.mmio.mmio_if
import cgra.config.Tile_IO_Bundle
import chisel3._
import chisel3.util._

class delay_pipe(data_width:Int, max_delay:Int) extends Module{
  val io = IO(new Bundle{
    val in = new Tile_IO_Bundle(data_width)
    val out = Flipped(new Tile_IO_Bundle(data_width))
    val host_interface = new mmio_if
  })
  // Pointer
  val head = RegInit(0.U(log2Ceil(max_delay + 1).W))
  val tail = RegInit(0.U(log2Ceil(max_delay + 1).W))

  // Actual FIFO
  val fifo = RegInit(VecInit(Seq.fill(max_delay)(0.U((data_width).W))))

  // Pressure pass immediately
  io.in.ack := io.out.ack
  io.out.req := io.in.req
  io.out.data := fifo(head)
  when (io.out.ack){
    fifo(tail) := io.in.data
    head := head + 1.U
    tail := tail + 1.U
  }

  // --- Configuration ---
  // write-only
  io.host_interface.read_data := 0.U
  io.host_interface.read_ack := false.B
  // no-latency write
  io.host_interface.write_ack := true.B
  when (io.host_interface.write_req) {
    for (i <- 0 until max_delay){
      // flash the pipe
      fifo(i) := 0.U
      tail := io.host_interface.write_data
    }
  }
}
object delay_pipeDriver extends App {
  chisel3.Driver.execute(args, () => new delay_pipe(32,14))
}