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
  val in_data_width : List[Int] = getPropByKey("in_data_width")
    .asInstanceOf[List[Int]]
  val out_data_width : List[Int] = getPropByKey("out_data_width")
    .asInstanceOf[List[Int]]

  // Derived Parameter
  val num_input = in_data_width.length
  val num_output = out_data_width.length
  val config_width = num_output * log2Ceil(num_input)
  val config_ranges = get_config_range(Seq.fill(num_output)(num_input))
  apply("mux_config_range", config_ranges)

  val io = IO(new Bundle{
    val ins = MixedVec(in_data_width.map(w=>Input(UInt(w.W))))
    val outs = MixedVec(out_data_width.map(w=>Output(UInt(w.W))))
    val config = Input(UInt(config_width.W))
  })

  for(out_idx <- 0 until num_output){
    val mux_prop : mutable.Map[String, Any] = mutable.Map[String,Any]()
    val mux_config_range = config_ranges(out_idx)
    mux_prop += "in_data_width" -> in_data_width
    mux_prop += "out_data_width" -> out_data_width(out_idx)
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

  prop += "in_data_width" -> List(16,32,8,64)
  prop += "out_data_width" -> List(12,16,64,8,32)

  chisel3.Driver.execute(args,()=>{
    val module = new crossbar(prop)
    println(module)
    module
  })
}