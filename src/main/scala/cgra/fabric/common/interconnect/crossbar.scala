package cgra.fabric.common.interconnect

import chisel3._
import chisel3.util.{MixedVec, log2Ceil}
import dsl.IRPrintable
import cgra.config.encoding._
import scala.collection.mutable

class crossbar(prop:mutable.Map[String,Any]) extends Module
with IRPrintable{
  // Add initial property
  apply(prop)

  // External Parameter
  val input_data_widths : List[Int] = getPropByKey("input_data_widths")
    .asInstanceOf[List[Int]]
  val output_data_widths : List[Int] = getPropByKey("output_data_widths")
    .asInstanceOf[List[Int]]

  // Derived Parameter
  val num_input = input_data_widths.length
  val num_output = output_data_widths.length
  val config_width = num_output * log2Ceil(num_input)
  val config_ranges = get_config_range(Seq.fill(num_output)(num_input))
  apply("mux_config_range", config_ranges)

  val io = IO(new Bundle{
    val ins = MixedVec(input_data_widths.map(w=>Input(UInt(w.W))))
    val outs = MixedVec(output_data_widths.map(w=>Output(UInt(w.W))))
    val config = Input(UInt(config_width.W))
  })

  for(out_idx <- 0 until num_output){
    val mux_prop : mutable.Map[String, Any] = mutable.Map[String,Any]()
    val mux_config_range = config_ranges(out_idx)
    mux_prop += "input_data_widths" -> input_data_widths
    mux_prop += "output_data_widths" -> output_data_widths(out_idx)
    val mux_io = Module(new multiplexer(mux_prop)).io

    // Connect Mux IO
    io.outs(out_idx) := mux_io.out
    for(in_idx <- 0 until num_input){
      mux_io.in(in_idx) := io.ins(in_idx)
    }
    if(num_input>1){
      mux_io.config := io.config(mux_config_range._1, mux_config_range._2)
    }else{
      mux_io.config := DontCare
    }
  }

  override def postprocess(): Unit = ???
}

object gen_xbar extends App{

  val prop : mutable.Map[String,Any] = mutable.Map[String,Any]()

  prop += "input_data_widths" -> List(16,32,8,64)
  prop += "output_data_widths" -> List(12,16,64,8,32)

  chisel3.Driver.execute(args,()=>{
    val module = new crossbar(prop)
    println(module)
    module
  })
}