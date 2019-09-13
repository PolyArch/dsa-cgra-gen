package cgra.fabric

import java.lang.Throwable

import cgra.IO.{ReqAckConf_if, ReqAckConf_t}
import cgra.config.system_var
import cgra.config.system_util._
import chisel3._
import chisel3.util._
import cgra.IO.port_generator._
import cgra.fabric.common.datapath.{Delay_FIFO, Delay_FIFO_Hw}
import chisel3.iotesters.PeekPokeTester

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
  catch{case _:Throwable => try{system_var.data_word_width}catch{case _:Throwable =>64}}
  val decomposer : Int = 1 // Not need to build a decomposable VP here
  val protocol : String = try{p("protocol").toString}catch{case _:Throwable => "DataValidReadyConfig"}

  // Derived Parameter
  val num_input : Int = input_ports.length
  val num_output : Int = output_ports.length
  require(1==(num_input min num_output))

  // Create Hardware
  val io = IO(new Bundle{
    val in = Flipped(Vec(num_input,ReqAckConf_if(data_word_width)))
    val out = Vec(num_output,ReqAckConf_if(data_word_width))
  })
  io.in.foreach(v=>gc_port(v,protocol))
  io.out.foreach(v=>gc_port(v,protocol))

  val num_vector : Int = 1 max num_input max num_output
  val vector_idx = RegInit(0.U(log2Ceil(num_vector max 2).W))

  // Calculate Hardware Configuration
  val Delay_FIFOs : Array[Delay_FIFO] = Array.fill(num_vector)(new Delay_FIFO)
  for (i <- 0 until num_vector){
    Delay_FIFOs(i).sink = module_name
    Delay_FIFOs(i).pipe_word_width = data_word_width
    Delay_FIFOs(i).max_delay = channel_buffer
    Delay_FIFOs(i).protocol = if(protocol.contains("Ready")) protocol else protocol + "Ready"
  }
  val Delay_FIFO_Hws  = VecInit(Delay_FIFOs.map(p=>Module(new Delay_FIFO_Hw(p)).io))
  Delay_FIFO_Hws.foreach(dw=>dw.delay := DontCare)

  // Create Hardware
  // Update Vector Select
  val this_channel_finished : Vec[Bool] = Wire(Vec(num_vector,Bool()))
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
        Delay_FIFO_Hws(i).out.ready := ((num_vector-1).U === vector_idx) && io.out(i).ready
      }
      if(protocol.contains("Ready")){
        this_channel_finished(i) := Delay_FIFO_Hws(i).in.ready // Delay_FIFO_Hws(i).in.valid // && io.out(vector_idx).ready
      }else if(protocol.contains("Valid")){
        this_channel_finished(i) := true.B // Delay_FIFO_Hws(i).out.valid
      }else{
        this_channel_finished(i) := true.B
      }
    }
    if(protocol.contains("Ready")){
      val select_ready = Array.range(0,num_vector).map(idx=>idx.U -> Delay_FIFO_Hws(idx).in.ready)
      io.in.head.ready := MuxLookup(vector_idx,false.B,select_ready)
    }
    vector_idx := vector_idx + Mux(this_channel_finished(vector_idx),1.U,0.U)
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
      if(protocol.contains("Ready")){
        this_channel_finished(i) := io.out.head.ready && Delay_FIFO_Hws(vector_idx).out.valid
      }else if(protocol.contains("Valid")){
        this_channel_finished(i) := Delay_FIFO_Hws(vector_idx).out.valid
      }else{
        this_channel_finished(i) := true.B
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
    when(this_channel_finished(vector_idx)){
      vector_idx := vector_idx + 1.U
    }
  }

  // Print
  if(module_name.contains("in_1")){
    printf(p"input_ports = $input_ports\n")
    printf(p"output_ports = $output_ports\n")
    printf(p"channel_buffer = $channel_buffer\n")
    printf(p"data_word_width = $data_word_width\n")
    printf(p"decomposer = $decomposer\n")
    printf(p"protocol = $protocol\n")
    printf(p"----- Start of $module_name -----\n")
    printf(p"VecPort $module_name : vector_idx increased - Pointer ${this_channel_finished(vector_idx)} - Value $vector_idx\n")
    printf(p"VecPort $module_name : vector_idx = $vector_idx, finished = $this_channel_finished\n")
    printf(p"VecPort $module_name : Add result = ${vector_idx + Mux(this_channel_finished(vector_idx),1.U,0.U)}\n")
    for(port <- input_ports) {
      printf(p"VecPort $module_name : Input Port - $port - " +
        p"bits - ${io.in(input_ports.indexOf(port)).bits} - " +
        p"valid - ${io.in(input_ports.indexOf(port)).valid} - " +
        p"ready - ${io.in(input_ports.indexOf(port)).ready} - " +
        p"config - ${io.in(input_ports.indexOf(port)).config}\n")
    }
    for(port <- output_ports) {
      printf(p"VecPort $module_name : Output Port - $port - " +
        p"bits - ${io.out(output_ports.indexOf(port)).bits} - " +
        p"valid - ${io.out(output_ports.indexOf(port)).valid} - " +
        p"ready - ${io.out(output_ports.indexOf(port)).ready} - " +
        p"config - ${io.out(output_ports.indexOf(port)).config}\n")
    }
    for(fifo <- 0 until num_vector){
      printf(p"VecPort $module_name : FIFO Buffer - $fifo || IN : ${Delay_FIFO_Hws(fifo).in} | " +
        p"OUT : ${Delay_FIFO_Hws(fifo).out}\n")
    }
    printf(p"VecPort $module_name : vector_idx - $vector_idx \n")
    //printf(p"----- End of $module_name -----\n")
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

import cgra.config.system_var
import cgra.config.system_util._

class vp_tester(vp: VectorPort_Hw) extends PeekPokeTester(vp){
  poke(vp.io.in(0).bits,11)
  poke(vp.io.in(0).valid,true.B)
  poke(vp.io.out(0).ready,true.B)
  poke(vp.io.out(1).ready,true.B)
  step(1)
  println(" --------------- Cycle 1 ----------------")
  poke(vp.io.in(0).bits,12)
  poke(vp.io.in(0).valid,true.B)
  poke(vp.io.out(0).ready,true.B)
  poke(vp.io.out(1).ready,true.B)
  step(1)
  println(" --------------- Cycle 2 ----------------")
  poke(vp.io.in(0).bits,13)
  poke(vp.io.in(0).valid,true.B)
  poke(vp.io.out(0).ready,true.B)
  poke(vp.io.out(1).ready,true.B)
  step(1)
  println(" --------------- Cycle 3 ----------------")
  poke(vp.io.in(0).bits,15)
  poke(vp.io.in(0).valid,true.B)
  poke(vp.io.out(0).ready,true.B)
  poke(vp.io.out(1).ready,true.B)
  step(1)
  println(" --------------- Cycle 4 ----------------")
  poke(vp.io.in(0).bits,17)
  poke(vp.io.in(0).valid,true.B)
  poke(vp.io.out(0).ready,true.B)
  poke(vp.io.out(1).ready,true.B)
  step(1)
  println(" --------------- Cycle 5 ----------------")
}


object test_vp extends App{
  /*
protocol = DataValidReadyConfig
decomposer = 1
data_word_width = 32
channel_buffer = 3
output_ports = List(v1, v2)
input_ports = List(v1)
   */
  system_var.data_word_width = 32
  val p: mutable.Map[String,Any] = mutable.Map[String,Any]()
  p += "input_ports" -> List("v0")
  p += "output_ports" -> List("v0","v1")
  p += "channel_buffer" ->3
  iotesters.Driver.execute(args, () =>
    new VectorPort_Hw("vec_in_1",p)
  ){
    c => new vp_tester(c)
  }
}

object initialize_vp extends App{
  system_var.data_word_width = 32
  val p: mutable.Map[String,Any] = mutable.Map[String,Any]()
  p += "input_ports" -> List("v1")
  p += "output_ports" -> List("v1","v2","v3")
  p += "channel_buffer" ->3
  chisel3.Driver.execute(args,()=>{new VectorPort_Hw("test_vp",p)})
}
