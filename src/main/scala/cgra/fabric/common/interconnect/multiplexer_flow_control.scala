package cgra.fabric.common.interconnect

import chisel3._
import chisel3.util._
import dsl.IRPrintable

import scala.collection.mutable

class multiplexer_flow_control (prop:mutable.Map[String,Any])
  extends Module
  with IRPrintable{
  // Apply Initial Property
  apply(prop)

  // External Parameter
  private val in_datawidth = getPropByKey("in_datawidth")
    .asInstanceOf[List[Int]]
  private val out_datawidth = getPropByKey("out_datawidth")
    .asInstanceOf[Int]

  // Derived Parameted
  private val num_input = in_datawidth.length
  private val sel_width = log2Ceil(num_input)

  val io = IO(new Bundle{
    val in = MixedVec(in_datawidth.map(w=>Flipped(DecoupledIO(UInt(w.W)))))
    val out = DecoupledIO(UInt(out_datawidth.W))
    val config = Input(UInt(sel_width.W))
  })

  // Mux Bits
  private val muxBitsLUT = for(idx <- 0 until num_input)yield{
    (idx.U, io.in(idx).bits)
  }
  io.out.bits := MuxLookup(io.config,0.U,muxBitsLUT)

  // Mux Valid
  private val muxValidLUT = for(idx <- 0 until num_input)yield{
    (idx.U, io.in(idx).valid)
  }
  io.out.valid := MuxLookup(io.config,false.B,muxValidLUT)

  // Mux Ready
  for (idx <- 0 until num_input){
    io.in(idx).ready := Mux(io.config === idx.U,io.out.ready,false.B)
  }

  override def postprocess(): Unit = ???

}

object gen_mux_flow_control extends App{
  val prop : mutable.Map[String,Any] = mutable.Map[String,Any]()

  prop += "in_datawidth" -> List(16,32,8,64)
  prop += "out_datawidth" -> 18

  chisel3.Driver.execute(args,()=>{
    val module = new multiplexer_flow_control(prop)
    println(module)
    module
  })
}