package cgra.component

import chisel3._
import chisel3.util._
import scala.collection.mutable

class duplicatorN (num_output: Int,data_width:Int)
  extends Module{
  val io = IO(
    new Bundle{
      val en = Input(Bool())
      val input_port =
        Flipped(DecoupledIO(UInt(data_width.W)))
      val output_ports =
        Vec(num_output, DecoupledIO(UInt(data_width.W)))
    }
  )

  private val enable = io.en

  // Broadcast the data bits
  for(output_bits <- io.output_ports.map(_.bits)){
    output_bits := Mux(enable, io.input_port.bits, 0.U)
  }

  // Broadcast the data valid bit
  for(output_valid <- io.output_ports.map(_.valid)){
    output_valid := Mux(enable, io.input_port.valid, false.B)
  }

  // When all downstream are ready (AND)
  // then tell upstream that ready
  io.input_port.ready := Mux(enable,
    io.output_ports.map(_.ready).reduce(_ && _), false.B)
}

object gen_dupN extends App{
  chisel3.Driver.execute(args,()=>{
    new duplicatorN(3,64)
  })

}