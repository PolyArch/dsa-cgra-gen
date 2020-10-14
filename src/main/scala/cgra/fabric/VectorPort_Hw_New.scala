package cgra.fabric

import cgra.IO.port_generator.gc_port
import cgra.IO.ReqAckConf_if
import cgra.config.system_var
import chisel3._
import chisel3.util._

import scala.collection.mutable

class VectorPort_Hw_New (pp:(String,Any)) extends Module
  with Has_IO{

  val p : mutable.Map[String,Any] = pp._2.asInstanceOf[mutable.Map[String,Any]];
  // Extract Parameter
  val module_name : String = pp._1
  val input_ports : List[String] = p("input_ports").asInstanceOf[List[String]]
  val output_ports : List[String] = p("output_ports").asInstanceOf[List[String]]
  val channel_buffer : Int = try{p("channel_buffer").asInstanceOf[Int]}catch{case _: Throwable => 2}
  val data_word_width : Int = try{p("data_word_width").asInstanceOf[Int]}
  catch{case _:Throwable => try{system_var.data_word_width}catch{case _:Throwable =>64}}
  val decomposer : Int = 1 // Not need to build a decomposable VP here
  val protocol : String = try{p("protocol").toString}catch{case _:Throwable => "DataValidReadyConfig"}
  val vectorMode : String = try{p("vectorMode").toString}catch{case _:Throwable => "Bitmask"}//["Direct", "Map"]

  // Derived Parameter
  val num_input : Int = input_ports.length
  val num_output : Int = output_ports.length
  val num_vector : Int = num_input max num_output
  require(1==(num_input min num_output))
  val common_data_word_width : Int = num_vector * data_word_width

  // Create Hardware
  val io = IO(new Bundle{
    val in = Flipped(Vec(num_input,ReqAckConf_if(common_data_word_width / num_input)))
    val size = Input(UInt(log2Ceil(1 + num_vector).W))
    val config = Input(UInt({
      vectorMode match {
        case "Direct" => log2Ceil(1 + num_vector)
        case "Bitmask" => num_vector
        case "Map" => num_vector * log2Ceil(num_vector + 1)
      }}.W))
    val config_enable = Input(Bool())
    val out = Vec(num_output,ReqAckConf_if(common_data_word_width / num_output))
  })
  io.in.foreach(v=>gc_port(v,protocol))
  io.out.foreach(v=>gc_port(v,protocol))

  var config_wire : Vec[UInt] = vectorMode match{
    case "Direct" => Wire(Vec(1,UInt(log2Ceil(1 + num_vector).W)))
    case "Bitmask" => Wire(Vec(1,UInt(num_vector.W)))
    case "Map" => Wire(Vec(num_vector,UInt(log2Ceil(num_vector + 1).W)))
  }
  var config_register : Vec[UInt] = vectorMode match{
    case "Direct" => RegInit(VecInit(Seq.fill(1)(0.U(log2Ceil(1 + num_vector).W))))
    case "Bitmask" => RegInit(VecInit(Seq.fill(1)(0.U(num_vector.W))))
    case "Map" => RegInit(VecInit(Seq.fill(num_vector)(0.U(log2Ceil(num_vector + 1).W))))
  }
  vectorMode match {
    case "Direct" =>
      when(io.config_enable){config_register(0) := io.config}
      config_wire(0) := config_register(0)
    case "Bitmask" =>
      when(io.config_enable){config_register(0) := io.config}
      config_wire(0) := config_register(0)
    case "Map" =>
      val wid = log2Ceil(num_vector + 1)
      for(i <- 0 until num_vector){
        when(io.config_enable){
          config_register(i) := io.config((i + 1) * wid -1,i * wid)
        }
        config_wire(i) := config_register(i)
      }
  }


  // Create Hardware
  val _head = RegInit(0.U(log2Ceil(channel_buffer * num_vector).W))
  val _tail = RegInit(0.U(log2Ceil(channel_buffer * num_vector).W))
  val isFull : Bool = _tail >= _head
  if(num_output > num_input)
    io.in(0).ready := !isFull

  val MainQueue = RegInit(VecInit(Seq.fill(num_vector*channel_buffer)(0.U(data_word_width.W))))
  val ValidQueue = RegInit(VecInit(Seq.fill(num_vector*channel_buffer)(false.B)))
  val ConfigQueue = RegInit(VecInit(Seq.fill(num_vector*channel_buffer)(false.B)))
  if(num_output > num_input){
    vectorMode match {
      case "Direct" =>
        val vecSize : UInt = config_wire(0)
        // Write In
        when(!isFull && io.in(0).valid){
          for (i <- 0 until num_vector){
            when((i+1).U <= io.size){
              MainQueue(_tail + i.U) := io.in(0).bits((i+1)*data_word_width - 1,i * data_word_width)
              ValidQueue(_tail + i.U) := true.B
              ConfigQueue(_tail + i.U) := io.in(0).config
            }
          }
          _tail := _tail + io.size
        }
        // Write Out
        for (i <- 0 until num_vector){
          when(i.U < vecSize){
            io.out(i).valid := ValidQueue(_head + i.U)
          }.otherwise{
            io.out(i).valid := false.B
          }
        }
        val valids = for (i <- 0 until num_vector)
          yield Mux((_head + i.U) < vecSize,ValidQueue(_head + i.U),true.B)
        val readys = for (i <- 0 until num_vector)
          yield Mux((_head + i.U) < vecSize,io.out(i).ready,true.B)
        val outputValid = valids.reduce(_&&_)
        val outputReady = readys.reduce(_&&_)
        for (i <- 0 until num_vector){
          when(i.U < vecSize){
            io.out(i).bits := MainQueue(_head + i.U)
            io.out(i).config := ConfigQueue(_head + i.U)
          }.otherwise{
            io.out(i).bits := 0.U
            io.out(i).config := false.B
          }
        }
        when(outputValid && outputReady){
          _head := _head + vecSize
        }
      case "Bitmask" =>
        val bitMask : UInt = config_wire(0)
        val vecSize : UInt = PopCount(config_wire(0))
        // Write In
        when(!isFull && io.in(0).valid){
          for (i <- 0 until num_vector){
            when(bitMask(i)){
              MainQueue(_tail + i.U) := io.in(0).bits((i+1)*data_word_width - 1,i * data_word_width)
              ValidQueue(_tail + i.U) := true.B
              ConfigQueue(_tail + i.U) := io.in(0).config
            }
          }
          _tail := _tail + io.size
        }
        // Write Out
        for (i <- 0 until num_vector){
          when(bitMask(i)){
            io.out(i).valid := ValidQueue(_head + i.U)
          }.otherwise{
            io.out(i).valid := false.B
          }
        }
        val valids = for (i <- 0 until num_vector)
          yield Mux(bitMask(_head + i.U),ValidQueue(_head + i.U),true.B)
        val readys = for (i <- 0 until num_vector)
          yield Mux(bitMask(_head + i.U),io.out(i).ready,true.B)
        val outputValid = valids.reduce(_&&_)
        val outputReady = readys.reduce(_&&_)

        for (i <- 0 until num_vector){
          when(bitMask(_head + i.U)){
            io.out(i).bits := MainQueue(_head + i.U)
            io.out(i).config := ConfigQueue(_head + i.U)
          }.otherwise{
            io.out(i).bits := 0.U
            io.out(i).config := false.B
          }
        }
        when(outputValid && outputReady){
          _head := _head + vecSize
        }
      case "Map" =>
        val map = config_wire
        val vecSize = PopCount(for(i <- 0 until num_vector)
          yield map(i) =/= 0.U)
        // Write In
        when(!isFull && io.in(0).valid){
          for (i <- 0 until num_vector){
            when(map(i) =/= 0.U){
              MainQueue(_tail + map(i) - 1.U) := io.in(0).bits((i+1)*data_word_width - 1,i * data_word_width)
              ValidQueue(_tail + map(i) - 1.U) := true.B
              ConfigQueue(_tail + map(i) - 1.U) := io.in(0).config
            }
          }
          _tail := _tail + io.size
        }
        // Write Out
        for (i <- 0 until num_vector){
          when(map(i) =/= 0.U){
            io.out(i).valid := ValidQueue(_head + i.U)
          }.otherwise{
            io.out(i).valid := false.B
          }
        }
        val valids = for (i <- 0 until num_vector)
          yield Mux(map(i)=/=0.U,ValidQueue(_head + i.U),true.B)
        val readys = for (i <- 0 until num_vector)
          yield Mux(map(i)=/=0.U,io.out(i).ready,true.B)
        val outputValid = valids.reduce(_&&_)
        val outputReady = readys.reduce(_&&_)
        for (i <- 0 until num_vector){
          when(map(i)=/=0.U){
            io.out(i).bits := MainQueue(_head + i.U)
            io.out(i).config := ConfigQueue(_head + i.U)
          }.otherwise{
            io.out(i).bits := 0.U
            io.out(i).config := false.B
          }
        }
        when(outputValid && outputReady){
          _head := _head + vecSize
        }
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
