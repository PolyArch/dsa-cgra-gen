package cgra.fabric

import java.lang.Throwable

import cgra.IO.{ReqAckConf_if, ReqAckConf_t}
import cgra.config.system
import chisel3._
import chisel3.util._
import cgra.IO.port_generator._
import cgra.fabric.common.datapath.{Delay_FIFO, Delay_FIFO_Hw}

import scala.collection.mutable


class VectorPort_Hw(pp:(String,Any)) extends Module
  with Has_IO{
  val p:mutable.Map[String,Any] = pp._2.asInstanceOf[mutable.Map[String,Any]]
  // Extract Parameter
  val module_name : String = pp._1
  val input_ports : List[String] = p("input_ports").asInstanceOf[List[String]]
  val output_ports : List[String] = p("output_ports").asInstanceOf[List[String]]
  val channel_buffer : Int = try{p("channel_buffer").asInstanceOf[Int]}catch{case _: Throwable => 2}
  val data_word_width : Int = try{p("data_word_width").asInstanceOf[Int]}
  catch{case _:Throwable => try{system.data_word_width}catch{case _:Throwable =>64}}
  val decomposer : Int = 1 // Not need to build a decomposable VP here
  val protocol : String = try{p("protocol").toString}catch{case _:Throwable => "DataValidReadyConfig"}
  // Derived Parameter
  val num_input : Int = input_ports.length
  val num_output : Int = output_ports.length
  require(1==(num_input min num_output))


  val io = IO(new Bundle{
    val in = Flipped(Vec(num_input,ReqAckConf_if(data_word_width)))
    val out = Vec(num_output,ReqAckConf_if(data_word_width))
  })
  io.in.foreach(v=>gc_port(v,protocol))
  io.out.foreach(v=>gc_port(v,protocol))

  val num_vector : Int = num_input max num_output
  val vector_idx = RegInit(0.U(log2Ceil(num_vector).W))

  // Calculate Hardware Configuration
  val Delay_FIFOs : Array[Delay_FIFO] = Array.fill(num_vector)(new Delay_FIFO)
  for (i <- 0 until num_vector){
    Delay_FIFOs(i).pipe_word_width = data_word_width
    Delay_FIFOs(i).max_delay = channel_buffer
    Delay_FIFOs(i).protocol = if(protocol.contains("Ready")) protocol else protocol + "Ready"
  }
  val Delay_FIFO_Hws  = VecInit(Delay_FIFOs.map(p=>Module(new Delay_FIFO_Hw(p)).io))
  Delay_FIFO_Hws.foreach(dw=>dw.delay := DontCare)

  // Create Hardware
  if (num_output >= num_input){// ------ Input Vector Port ------
    for (i <- 0 until num_vector){
      if(protocol.contains("Data")){
        Delay_FIFO_Hws(i).in.bits := Mux(vector_idx === i.U,io.in.head.bits,0.U)
        io.out(i).bits := Delay_FIFO_Hws(i).out.bits
      }else{
        Delay_FIFO_Hws(i).in.bits := 0.U
      }
      if(protocol.contains("Valid")){
        Delay_FIFO_Hws(i).in.valid := Mux(vector_idx === i.U,io.in.head.valid,false.B)
        io.out(i).valid := Delay_FIFO_Hws(i).out.valid
      }else{
        Delay_FIFO_Hws(i).in.valid := true.B
      }
      if(protocol.contains("Config")){
        Delay_FIFO_Hws(i).in.config := Mux(vector_idx === i.U,io.in.head.config,false.B)
        io.out(i).config := Delay_FIFO_Hws(i).out.config
      }else{
        Delay_FIFO_Hws(i).in.config := false.B
      }
      if(protocol.contains("Ready")){
        Delay_FIFO_Hws(i).out.ready := io.out(i).ready
      }
    }
    if(protocol.contains("Ready")){
      val select_ready = Array.range(0,num_vector).map(idx=>idx.U -> Delay_FIFO_Hws(idx).in.ready)
      io.in.head.ready := MuxLookup(vector_idx,false.B,select_ready)
    }
    // Update Vector Select
    val this_channel_finished : Bool = Wire(Bool())
    if(protocol.contains("Ready")){
      this_channel_finished := io.out(vector_idx).ready && Delay_FIFO_Hws(vector_idx).out.valid
    }else if(protocol.contains("Valid")){
      this_channel_finished := Delay_FIFO_Hws(vector_idx).out.valid
    }else{
      this_channel_finished := true.B
    }
    when(this_channel_finished){
      vector_idx := vector_idx + 1.U
    }
  }
  else{
    // Create Hardware
    for (i <- 0 until num_vector){
      if(protocol.contains("Data")){
        Delay_FIFO_Hws(i).in.bits := io.in(i).bits
      }else{
        Delay_FIFO_Hws(i).in.bits := 0.U
      }
      if(protocol.contains("Valid")){
        Delay_FIFO_Hws(i).in.valid := io.in(i).valid
      }else{
        Delay_FIFO_Hws(i).in.valid := true.B
      }
      if(protocol.contains("Config")){
        Delay_FIFO_Hws(i).in.config := io.in(i).config
      }else{
        Delay_FIFO_Hws(i).in.config := false.B
      }
      if(protocol.contains("Ready")){
        io.in(i).ready := Delay_FIFO_Hws(i).in.ready
        Delay_FIFO_Hws(i).out.ready := Mux(vector_idx === i.U,io.out.head.ready,false.B)
      }
    }
    if(protocol.contains("Data")){
      val select_data = Array.range(0,num_vector).map(idx=>idx.U -> Delay_FIFO_Hws(idx).out.bits)
      io.out.head.bits := MuxLookup(vector_idx,0.U,select_data)
    }
    if(protocol.contains("Valid")){
      val select_valid = Array.range(0,num_vector).map(idx=>idx.U -> Delay_FIFO_Hws(idx).out.valid)
      io.out.head.valid := MuxLookup(vector_idx,false.B,select_valid)
    }
    if(protocol.contains("Config")){
      val select_config = Array.range(0,num_vector).map(idx=>idx.U -> Delay_FIFO_Hws(idx).out.config)
      io.out.head.config := MuxLookup(vector_idx,false.B,select_config)
    }
    // Update Vector Select
    val this_channel_finished : Bool = Wire(Bool())
    if(protocol.contains("Ready")){
      this_channel_finished := io.out.head.ready && Delay_FIFO_Hws(vector_idx).out.valid
    }else if(protocol.contains("Valid")){
      this_channel_finished := Delay_FIFO_Hws(vector_idx).out.valid
    }else{
      this_channel_finished := true.B
    }
    when(this_channel_finished){
      vector_idx := vector_idx + 1.U
    }
  }

  // Get Port
  def get_port(io_t:String,name:String) : Vec[ReqAckConf_if] = {
    io_t match {
      case "in" => VecInit(io.in(input_ports.indexOf(name)))
      case "out" => VecInit(io.out(output_ports.indexOf(name)))
    }
  }
  def get_port_protocol(io_t:String,name:String) : String = {
    protocol
  }
}

import cgra.IR.global_var._

object test_vp extends App{
  system.data_word_width = 32
  val p: mutable.Map[String,Any] = mutable.Map[String,Any]()
  p += "input_ports" -> List("v1")
  p += "output_ports" -> List("v1","v2","v3")
  p += "channel_buffer" ->3
  chisel3.Driver.execute(args,()=>{new VectorPort_Hw("test_vp",p)})
}
