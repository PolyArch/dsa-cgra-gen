package cgra.component

import chisel3._
import chisel3.util._

class subnet_shifter (decomposer:Int,granularity:Int)
  extends Module{

  // Derived Parameter
  val datawidth = decomposer * granularity

  // Hardware
  val io = IO(
    new Bundle{
      val en = Input(Bool())
      val offset = Input(UInt(log2Ceil(decomposer).W))
      val input_data = Input(UInt(datawidth.W))
      val output_data = Output(UInt(datawidth.W))
    }
  )



  if(decomposer > 1){
    when(io.en){
      when(io.offset === 0.U){
        io.output_data := io.input_data
      }.otherwise{
        val mux_cycle_shift = for(offset <- 1 until decomposer) yield {
          offset.U -> Cat(// Notice that this is a left cyclic shift
            io.input_data(datawidth - 1 - offset * granularity,0),
            io.input_data(datawidth - 1,datawidth - offset * granularity)
          )
        }
        io.output_data := MuxLookup(io.offset,io.input_data,mux_cycle_shift)
      }
    }.otherwise{
      io.output_data := 0.U
    }
  }else{
    when(io.en){
      io.output_data := io.input_data
    }.otherwise{
      io.output_data := 0.U
    }
  }
}

object gen_subnet_shift extends App{
  chisel3.Driver.execute(args,()=>{
    new subnet_shifter(8,16)
  })

}