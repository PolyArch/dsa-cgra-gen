package cgra.fabric.common.interconnect

import scala.collection.mutable
import chisel3._
import chisel3.util.{DecoupledIO, MixedVec, log2Ceil}
import dsl.IRPrintable
import cgra.config.encoding._

import scala.collection.mutable

class crossbar_flow_control(prop:mutable.Map[String,Any])extends Module
with IRPrintable{
  // Add initial property
  apply(prop)

  // External Parameter
  val in_datawidth : List[Int] = getPropByKey("in_datawidth")
    .asInstanceOf[List[Int]]
  val out_datawidth : List[Int] = getPropByKey("out_datawidth")
    .asInstanceOf[List[Int]]

  // Derived Parameter
  val num_input = in_datawidth.length
  val num_output = out_datawidth.length
  val config_width = num_output * log2Ceil(num_input)
  val config_ranges = get_config_range(Seq.fill(num_output)(num_input))
  apply("mux_config_range", config_ranges)

  val io = IO(new Bundle{
    val ins = MixedVec(in_datawidth.map(w=>Flipped(DecoupledIO(UInt(w.W)))))
    val outs = MixedVec(out_datawidth.map(w=>DecoupledIO(UInt(w.W))))
    val config = Input(UInt(config_width.W))
  })

  val mux_module_io = {
    for(out_idx <- 0 until num_output)yield{
      val mux_prop = mutable.Map[String,Any]()
      mux_prop += "in_datawidth" -> in_datawidth
      mux_prop += "out_datawidth" -> out_datawidth(out_idx)
      Module(new multiplexer_flow_control(mux_prop)).io
    }
  }

  // Connect the Mux IO (Forward)
  for (out_idx <- 0 until num_output){
    // Connect Input
    for (in_idx <- 0 until num_input){
      // Bits
      mux_module_io(out_idx).in(in_idx).bits := io.ins(in_idx).bits
      // Valid
      mux_module_io(out_idx).in(in_idx).valid := io.ins(in_idx).valid
    }
    // Connect Output
    io.outs(out_idx) <> mux_module_io(out_idx).out
    // Connect Config
    val config_range = config_ranges(out_idx)
    mux_module_io(out_idx).config := io.config(config_range._1, config_range._2)
  }

  // Connect the MUX IO (Backward)
  for (in_idx <- 0 until num_input){
    // If any one downstream is ready then ready for upstream
    io.ins(in_idx).ready := mux_module_io
      .map(m=>m.in(in_idx).ready).reduce(_ || _)
  }

  override def postprocess(): Unit = ???
}

object gen_xbar_flow_ctl extends App{

  val prop : mutable.Map[String,Any] = mutable.Map[String,Any]()

  prop += "in_datawidth" -> List(16,32,8,64)
  prop += "out_datawidth" -> List(12,16,64,8,32)

  chisel3.Driver.execute(args,()=>{
    val module = new crossbar_flow_control(prop)
    println(module)
    module
  })
}