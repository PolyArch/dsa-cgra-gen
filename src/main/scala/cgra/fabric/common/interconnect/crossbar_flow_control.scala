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
  val input_data_widths : List[Int] = getPropByKey("input_data_widths")
    .asInstanceOf[List[Int]]
  val output_data_widths : List[Int] = getPropByKey("output_data_widths")
    .asInstanceOf[List[Int]]

  // Derived Parameter
  val num_input : Int = input_data_widths.length
  val num_output : Int = output_data_widths.length
  val config_width : Int = num_output * log2Ceil(num_input)
  val config_ranges : Seq[(Int,Int)] = get_config_range(Seq.fill(num_output)(num_input))

  apply("mux_config_range", config_ranges)

  val io = IO(new Bundle{
    val input_ports = MixedVec(input_data_widths.map(w=>Flipped(DecoupledIO(UInt(w.W)))))
    val output_ports = MixedVec(output_data_widths.map(w=>DecoupledIO(UInt(w.W))))
    val config = Input(UInt(config_width.W))
  })

  val mux_module_io = {
    for(out_idx <- 0 until num_output)yield{
      val mux_prop = mutable.Map[String,Any]()
      mux_prop += "input_data_widths" -> input_data_widths
      mux_prop += "output_data_widths" -> output_data_widths(out_idx)
      Module(new multiplexer_flow_control(mux_prop)).io
    }
  }

  // Connect the Mux IO (Forward)
  for (out_idx <- 0 until num_output){
    // Connect Input
    for (in_idx <- 0 until num_input){
      // Bits
      mux_module_io(out_idx).in(in_idx).bits := io.input_ports(in_idx).bits
      // Valid
      mux_module_io(out_idx).in(in_idx).valid := io.input_ports(in_idx).valid
    }
    // Connect Output
    io.output_ports(out_idx) <> mux_module_io(out_idx).out
    // Connect Config
    val config_range = config_ranges(out_idx)
    if(num_input > 1){
      mux_module_io(out_idx).config := io.config(config_range._1, config_range._2)
    }else{
      mux_module_io(out_idx).config := DontCare
    }
  }

  // Connect the MUX IO (Backward)
  for (in_idx <- 0 until num_input){
    // If any one downstream is ready then ready for upstream
    io.input_ports(in_idx).ready := mux_module_io
      .map(m=>m.in(in_idx).ready).reduce(_ || _)
  }

  override def postprocess(): Unit = ???
}

object gen_xbar_flow_ctl extends App{

  val prop : mutable.Map[String,Any] = mutable.Map[String,Any]()

  prop += "input_data_widths" -> List(16,32,8,64)
  prop += "output_data_widths" -> List(12,16,64,8,32)

  chisel3.Driver.execute(args,()=>{
    val module = new crossbar_flow_control(prop)
    println(module)
    module
  })
}