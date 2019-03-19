package cgra.fabric.YamlV

import cgra.IO.ReqAckConf_if
import cgra.IR.{connection, port_subnet, router, subnet_connection}
import cgra.config.derived_system._
import cgra.config.system
import chisel3._
import chisel3.util.{DecoupledIO, _}
import cgra.config.encoding._

import scala.math._
import scala.collection.mutable.ListBuffer
import scala.util.Random

class Router_Hw(name_p:(String,router)) extends Module  with Has_IO
  with Decomposable{
  // ------ Extract Parameter
  private val module_name = name_p._1
  private val p = name_p._2
  private val num_input = p.getInput_ports.length
  private val num_output = p.getOutput_ports.length
  private val decomposer : Int = p.decomposer
  private val input_ports = p.input_ports
  private val output_ports = p.output_ports
  private val data_word_width = system.data_word_width

  // ------ Define Input Output
  val io = IO(new Bundle{
    val in = Flipped(Vec(num_input,ReqAckConf_if(data_word_width)))
    val out = Vec(num_output,ReqAckConf_if(data_word_width))
  })

  // Config Wiring
  private val config_input_port = p.config_input_port
  private val config_output_port = p.config_output_port
  val config_enable : Bool= io.in(input_ports.indexOf(config_input_port)).config


  // ------ Function
  val decomposed_input_ports = decompose("in",io.in)
  val decomposed_output_ports = decompose("out",io.out)

  // ------ Test
  /*
  val r = new Random()
  for(d <- 0 until decomposer;i <- 0 until num_input){
    decomposed_input_ports(d)(i).ready :=
      decomposed_output_ports(d)(r.nextInt(num_output)).ready ^ decomposed_output_ports(d)(r.nextInt(num_input)).ready
  }
  for(d <- 0 until decomposer;o <- 0 until num_output){
    decomposed_output_ports(d)(o).bits :=
      decomposed_input_ports(d)(r.nextInt(num_input)).bits - decomposed_input_ports(d)(r.nextInt(num_input)).bits
    decomposed_output_ports(d)(o).valid :=
      decomposed_input_ports(d)(r.nextInt(num_input)).valid - decomposed_input_ports(d)(r.nextInt(num_input)).valid
  }
  */

  private val all_in_port_subnet: ListBuffer[port_subnet] = new ListBuffer[port_subnet]()
  private val all_out_port_subnet: ListBuffer[port_subnet] = new ListBuffer[port_subnet]()
  private val inter_subnet_connection : ListBuffer[subnet_connection] = new ListBuffer[subnet_connection]()
  for (subnet <- 0 until decomposer){
    for (in <- input_ports;out <- output_ports){
      val temp_connection = new subnet_connection
      temp_connection.source = all_in_port_subnet.find(p=>p.port == in && p.subnet == subnet).getOrElse({
        val temp_port_subnet = new port_subnet
        temp_port_subnet.subnet = subnet;temp_port_subnet.port = in
        all_in_port_subnet += temp_port_subnet;temp_port_subnet
      })
      temp_connection.sink = all_out_port_subnet.find(p=>p.port == out && p.subnet == subnet).getOrElse({
        val temp_port_subnet = new port_subnet
        temp_port_subnet.subnet = subnet;temp_port_subnet.port = out
        all_out_port_subnet += temp_port_subnet;temp_port_subnet
      })
      inter_subnet_connection += temp_connection
    }
  }
  inter_subnet_connection ++= p.inter_subnet_connection
  // Create MUXes
  val all_sink_port_subnet : ListBuffer[port_subnet] = inter_subnet_connection.map(i=>i.sink).distinct
  val all_source_port_subnet : ListBuffer[port_subnet] = inter_subnet_connection.map(i=>i.source).distinct
  val all_muxes = all_sink_port_subnet.map(s=>{
    val mux = new Multiplexer
    mux.sink = s
    mux.sources = inter_subnet_connection.filter(i=>i.sink == s).map(s=>s.source).toList
    mux
  }).toList
  // Arrange MUX config location
  var pre_high_bit = -1
  for (m <- all_muxes.indices){
    val mux = all_muxes(m)
    mux.config_low = pre_high_bit + 1
    mux.config_high = mux.config_low + (1 max log2Ceil(mux.sources.length)) - 1
    pre_high_bit = mux.config_high
  }
  // Create Config Wire
  val config_width : Int = 1 + pre_high_bit
  val config_wire = Wire(UInt(config_width.W))
  // Connect MUX and Select by index
  all_muxes.foreach(m=>{
    val select2source_bits =
      m.sources.zipWithIndex.map(mi=>mi._2.U -> decomposed_input_ports(mi._1.subnet)(input_ports.indexOf(mi._1.port)).bits)
    val select2source_valid =
      m.sources.zipWithIndex.map(mi=>mi._2.U -> decomposed_input_ports(mi._1.subnet)(input_ports.indexOf(mi._1.port)).valid)
    decomposed_output_ports(m.sink.subnet)(output_ports.indexOf(m.sink.port)).bits :=
      MuxLookup(config_wire(m.config_high,m.config_low),0.U,select2source_bits)
    decomposed_output_ports(m.sink.subnet)(output_ports.indexOf(m.sink.port)).valid :=
      MuxLookup(config_wire(m.config_high,m.config_low),0.U,select2source_valid)
  })
  // Connect Ready Signal
  all_source_port_subnet.foreach(s=>{
    val connect_muxes = all_muxes.filter(m=>m.sources.contains(s))
    val combined_ready = connect_muxes.map(cm=>
      Mux(config_wire(cm.config_high,cm.config_low) === cm.sources.indexOf(s).U,
        decomposed_output_ports(cm.sink.subnet)(output_ports.indexOf(cm.sink.port)).ready,
        true.B))
    decomposed_input_ports(s.subnet)(input_ports.indexOf(s.port)).ready := combined_ready.reduce(_&&_)
  })

  // ------ Calculate Config Encoding
  val config_idx_data_width = config_module_id_low
  def calculate_config_idx_data_width(num_idx:Int, config_width:Int, config_idx_data_width:Int):Int={
    val config_width_per_idx : Int = ceil(config_width.toDouble / num_idx.toDouble).toInt
    val idx_width = log2Ceil(num_idx)
    if(idx_width + config_width_per_idx > config_idx_data_width)
      calculate_config_idx_data_width(num_idx+1,config_width,config_idx_data_width)
    else if (idx_width >= config_idx_data_width)
      throw new Exception("Can not fold config data into register file, too many configurations")
    else
      num_idx
  }
  val num_idx : Int = calculate_config_idx_data_width(1,config_width,config_idx_data_width)
  val idx_width : Int = log2Ceil(num_idx) max 1
  val config_idx_high : Int = config_module_id_low - 1
  val config_idx_low : Int = config_idx_high - idx_width + 1
  val config_width_per_idx : Int = ceil(config_width.toDouble / num_idx.toDouble).toInt
  val config_data_high : Int = config_width_per_idx - 1
  val config_data_low = 0

  // ------ Create Config Register File and Connect to Config Wire
  val config_register_file = RegInit(VecInit(Seq.fill(num_idx)(0.U(config_width_per_idx.W))))
  config_wire := config_register_file.reduce(Cat(_,_))(config_width - 1,0)

  // Update Config Register when configured in config port
  println("module name = " + module_name)
  println("config_input_port = " + config_input_port + ", config_output_port = " + config_output_port)
  println("input_ports = " + input_ports)
  val config_device_word : UInt= io.in(input_ports.indexOf(config_input_port)).bits
  val config_module_id = config_device_word(config_module_id_high,config_module_id_low)
  val module_id_match : Bool = config_module_id === p.module_id.U
  val config_idx = config_device_word(config_idx_high,config_idx_low)
  val config_data = config_device_word(config_data_high,config_data_low)
  when(config_enable && module_id_match){
    config_register_file(config_idx) := config_data
  }

  // ------ Utility
  def get_port (io_t:String,name:String) = {
    io_t match {
      case "in" => io.in(input_ports.indexOf(name))
      case "out" => io.out(output_ports.indexOf(name))
    }
  }
  def decompose(io_type:String,ports: Vec[ReqAckConf_if]) : List[Vec[DecoupledIO[UInt]]] = {
    val num_ports = ports.length
    val sub_word_width = data_word_width / decomposer
    val decomposed_ports =
      List.fill[Vec[DecoupledIO[UInt]]](decomposer)(Wire(Vec(num_ports,DecoupledIO(UInt(sub_word_width.W)))))

    io_type match{
      case "in" =>
        for(idx_port <- 0 until num_ports){
          for (subnet <- 0 until decomposer){
            decomposed_ports(subnet)(idx_port).bits :=
              ports(idx_port).bits((subnet + 1) * sub_word_width - 1, subnet * sub_word_width)
            decomposed_ports(subnet)(idx_port).valid :=
              ports(idx_port).valid
          }
          ports(idx_port).ready := decomposed_ports.map(vp=>vp(idx_port).ready).reduce(_ && _)
        }
      case "out" =>
        for(idx_port <- 0 until num_ports){
          // Connect Decomposed Port to Output Register
          val readyreg = Reg(Vec(decomposer,Bool()))
          for (subnet <- 0 until decomposer){
            decomposed_ports(subnet)(idx_port).ready := readyreg(subnet)
          }
          val bitsreg = Reg(UInt(data_word_width.W))
          bitsreg := decomposed_ports.map(vp=>vp(idx_port).bits).reduce(Cat(_,_))
          val validreg = Reg(Bool())
          validreg := decomposed_ports.map(vp=>vp(idx_port).valid).reduce(_ && _)

          // If this port is an output config port
          if (idx_port == output_ports.indexOf(config_output_port)){
            // Then when configured, connect directly with input config port
            when (config_enable){
              for (subnet <- 0 until decomposer)
                readyreg(subnet) := false.B
              ports(idx_port) <> io.in(input_ports.indexOf(config_input_port))
            }otherwise{ // Otherwise perform as a data port
              for (subnet <- 0 until decomposer) {
                readyreg(subnet) := ports(idx_port).ready
              }
              ports(idx_port).bits := bitsreg
              ports(idx_port).valid := validreg
              ports(idx_port).config := io.in(input_ports.indexOf(config_input_port)).config
            }
          }else{
            // Update Output Port (non-config port)
            for (subnet <- 0 until decomposer) {
              readyreg(subnet) := ports(idx_port).ready
            }
            ports(idx_port).bits := bitsreg
            ports(idx_port).valid := validreg
            ports(idx_port).config := false.B
          }
        }
    }
    decomposed_ports
  }

}

class Multiplexer {
  var config_high : Int = -1
  var config_low : Int = -1
  var sources : List[port_subnet] = Nil
  var sink : port_subnet = new port_subnet
  var operand : Int = -1
}