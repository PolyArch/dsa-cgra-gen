package cgra.fabric.common.interconnect

import chisel3._
import chisel3.util.{MixedVec, MuxLookup, log2Ceil}
import dsl.IRPrintable

import scala.collection.mutable

class multiplexer(prop:mutable.Map[String,Any]) extends Module
with IRPrintable{
  apply(prop)

  // External Parameter
  private val input_data_widths = getPropByKey("input_data_widths")
    .asInstanceOf[List[Int]]
  private val output_data_widths = getPropByKey("output_data_widths")
    .asInstanceOf[Int]

  // Internal Parameter
  private val num_input = input_data_widths.length
  private val sel_width = log2Ceil(num_input)

  val io = IO(new Bundle{
    val in = MixedVec(input_data_widths.map(w=>Input(UInt(w.W))))
    val out = Output(UInt(output_data_widths.W))
    val config = Input(UInt(sel_width.W))
  })

  if(num_input > 1){
    val muxLUT = for(idx <- 0 until num_input)yield{
      (idx.U, io.in(idx))
    }
    io.out := MuxLookup(io.config,0.U,muxLUT)
  }else{
    io.out <> io.in.head
  }


  override def postprocess(): Unit = ???
}

object gen_mux extends App{
  val prop : mutable.Map[String,Any] = mutable.Map[String,Any]()

  prop += "input_data_widths" -> List(16,32,8,64)
  prop += "output_data_widths" -> 18

  chisel3.Driver.execute(args,()=>{
    val module = new multiplexer(prop)
    println(module)
    module
  })
}