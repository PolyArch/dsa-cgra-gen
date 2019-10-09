package cgra.fabric.common.interconnect

import chisel3._
import chisel3.util.{MixedVec, MuxLookup, log2Ceil}
import dsl.IRPrintable

import scala.collection.mutable

class multiplexer(prop:mutable.Map[String,Any]) extends Module
with IRPrintable{
  apply(prop)

  // External Parameter
  private val in_data_width = getPropByKey("in_data_width")
    .asInstanceOf[List[Int]]
  private val out_data_width = getPropByKey("out_data_width")
    .asInstanceOf[Int]

  // Internal Parameter
  private val num_input = in_data_width.length
  private val sel_width = log2Ceil(num_input)

  val io = IO(new Bundle{
    val in = MixedVec(in_data_width.map(w=>Input(UInt(w.W))))
    val out = Output(UInt(out_data_width.W))
    val config = Input(UInt(sel_width.W))
  })

  val muxLUT = for(idx <- 0 until num_input)yield{
    (idx.U, io.in(idx))
  }
  io.out := MuxLookup(io.config,0.U,muxLUT)

  override def postprocess(): Unit = ???
}

object gen_mux extends App{
  val prop : mutable.Map[String,Any] = mutable.Map[String,Any]()

  prop += "in_data_width" -> List(16,32,8,64)
  prop += "out_data_width" -> 18

  chisel3.Driver.execute(args,()=>{
    val module = new multiplexer(prop)
    println(module)
    module
  })
}