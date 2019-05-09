package cgra.fabric.common.interconnect

import cgra.IO.ReqAckConf_if
import chisel3.util._
import chisel3._
import cgra.IO.port_generator._
import scala.collection.mutable

object Decomp_Adapter {
  def connect(source_port:Vec[ReqAckConf_if],
              sink_port:Vec[ReqAckConf_if],
              source_protocol:String,
              sink_protocol: String,
              common_decomposer : Int):Unit={
    source_port.foreach(p=>gc_port(p,source_protocol))
    sink_port.foreach(p=>gc_port(p,sink_protocol))
    for(subnet <- 0 until common_decomposer){
      if(source_protocol.contains("Ready"))
        source_port(subnet).ready := (
          if(sink_protocol.contains("Ready"))
            sink_port(subnet).ready
          else
            true.B)
      if(sink_protocol.contains("Data")){
        val data_reg = RegNext(
          if(source_protocol.contains("Data"))
            source_port(subnet).bits
          else
            0.U)
        sink_port(subnet).bits := data_reg
      }
      if(sink_protocol.contains("Valid"))
        sink_port(subnet).valid := (
          if(source_protocol.contains("Valid"))
            source_port(subnet).valid
          else
            true.B)
      if(sink_protocol.contains("Config"))
        sink_port(subnet).config := (
          if(source_protocol.contains("Config"))
            source_port(subnet).config
          else
            false.B)
    }
  }
  def connect(source_port:Vec[ReqAckConf_if],
              sink_port:Vec[ReqAckConf_if],
              p : mutable.Map[String,Any]): Decomp_Adapter_Hw ={
    val decomp_adapter = Module(new Decomp_Adapter_Hw(p))
    decomp_adapter.io.input_ports <> source_port
    decomp_adapter.io.output_ports <> sink_port
    decomp_adapter
  }
  def connect(source_port:Vec[ReqAckConf_if],
              sink_port:Vec[ReqAckConf_if],
              source_data_word_width : Int,
              sink_data_word_width : Int,
              source_decomposer : Int,
              sink_decomposer : Int,
              source_protocol : String,
              sink_protocol : String): Decomp_Adapter_Hw ={
    val p : mutable.Map[String,Any] = mutable.Map[String,Any]()
    p += "source_data_word_width" -> source_data_word_width
    p += "sink_data_word_width" -> sink_data_word_width
    p += "source_decomposer" -> source_decomposer
    p += "sink_decomposer" -> sink_decomposer
    p += "source_protocol" -> source_protocol
    p += "sink_protocol" -> sink_protocol
    connect(source_port,sink_port,p)
  }

}

class Decomp_Adapter_Hw(p:mutable.Map[String,Any]) extends Module {
  // Extract Necessary Parameter
  val source_data_word_width : Int = p("source_data_word_width").asInstanceOf[Int]
  val sink_data_word_width : Int = p("sink_data_word_width").asInstanceOf[Int]
  val source_decomposer : Int = p("source_decomposer").asInstanceOf[Int]
  val sink_decomposer : Int = p("sink_decomposer").asInstanceOf[Int]
  val source_protocol : String = p("source_protocol").toString
  val sink_protocol : String = p("sink_protocol").toString
  // Requirement Check
  require(source_data_word_width == sink_data_word_width,"" +
    "source and sink should have same word width")
  // Derived Parameter
  val source_decomp_word_width : Int = source_data_word_width/source_decomposer
  val sink_decomp_word_width : Int = sink_data_word_width/sink_decomposer
  // ------ IO ------
  val io = IO(new Bundle{
    val input_ports = Flipped(Vec(source_decomposer,ReqAckConf_if(source_decomp_word_width)))
    val output_ports = Vec(sink_decomposer,ReqAckConf_if(sink_decomp_word_width))
  })
  io.input_ports.foreach(ip=>gc_port(ip,source_protocol))
  io.output_ports.foreach(op=>gc_port(op,sink_protocol))
  // ------ Connect ------
  // -- Forward --
  val Input_All_Data : UInt = io.input_ports.map(_.bits).reduce(Cat(_,_))
  for (out_idx <- 0 until sink_decomposer){
    // Connect Data
    if(sink_protocol.contains("Data")){
      if(source_protocol.contains("Data")){
        val Input_All_Data_Reg = RegNext(Input_All_Data)
        io.output_ports(out_idx).bits :=
          Input_All_Data_Reg((out_idx + 1) * sink_decomp_word_width - 1,out_idx * sink_decomp_word_width)
      }else{
        io.output_ports(out_idx).bits := 0.U
      }
    }
    // Connect Valid
    if(sink_protocol.contains("Valid")){
      if(source_protocol.contains("Valid")){
        val validUInt : UInt = VecInit(io.input_ports.map(_.valid)).asUInt
        val scaledValidUInt : UInt = scale(validUInt,source_decomposer,sink_decomposer)
        io.output_ports(out_idx).valid := scaledValidUInt(out_idx)
      }else{
        io.output_ports(out_idx).valid := true.B
      }
    }
    // Connect Config
    if(sink_protocol.contains("Config")){
      if(source_protocol.contains("Config")){
        val configUInt : UInt = VecInit(io.input_ports.map(_.config)).asUInt
        val scaledConfigUInt : UInt = scale(configUInt,source_decomposer,sink_decomposer)
        io.output_ports(out_idx).config := scaledConfigUInt(out_idx)
      }else{
        io.output_ports(out_idx).config := false.B
      }
    }
  }
  // -- Backward --
  // Connect Ready
  for (in_idx <- 0 until source_decomposer){
    if(source_protocol.contains("Ready")){
      if(sink_protocol.contains("Ready")){
        val readyUInt : UInt = VecInit(io.output_ports.map(_.ready)).asUInt()
        val scaledReadyUInt : UInt = scale(readyUInt,sink_decomposer,source_decomposer)
        io.input_ports(in_idx).ready := scaledReadyUInt(in_idx)
      }else{
        io.input_ports(in_idx).ready := true.B
      }
    }
  }
  // ------ Util ------
  def scale(fromdata:UInt,fromWidth:Int,toWidth:Int) :UInt ={
    val todata : Vec[Bool] = Wire(Vec(toWidth,Bool()))
    for(toBit <- 0 until toWidth){
      if(fromWidth > toWidth){
        val from_to_ratio = fromWidth / toWidth
        val seq_bools : Seq[Bool] = fromdata((toBit + 1) * from_to_ratio - 1,toBit * from_to_ratio).toBools
        todata(toBit) := seq_bools.reduce(_&&_)
      }else{
        val to_from_ratio = toWidth / fromWidth
        todata(toBit) := fromdata(toBit / to_from_ratio)
      }
    }
    todata.asUInt()
  }
}
object tester_adapter extends App{
  // Knob Parameters
  /*
  val source_data_word_width : Int = p("source_data_word_width").asInstanceOf[Int]
  val sink_data_word_width : Int = p("sink_data_word_width").asInstanceOf[Int]
  val source_decomposer : Int = p("source_decomposer").asInstanceOf[Int]
  val sink_decomposer : Int = p("sink_decomposer").asInstanceOf[Int]
  val source_protocol : String = p("source_protocol").toString
  val sink_protocol : String = p("sink_protocol").toString
  */
  val p : mutable.Map[String,Any] = mutable.Map[String,Any]()
  p += "source_data_word_width" -> 64
  p += "sink_data_word_width" -> 64

  p += "source_decomposer" -> 8
  p += "sink_decomposer" -> 4
  p += "source_protocol" -> "DataValidReadyConfig"
  p += "sink_protocol" -> "DataValidReadyConfig"
  //p += "inter_subnet_connection" -> List("south_1 <-> north_0","northwest_0 <-> east _1")
  chisel3.Driver.execute(args,()=>{new Decomp_Adapter_Hw(p)})
}