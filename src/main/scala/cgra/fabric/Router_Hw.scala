package cgra.fabric

import java.nio.file.{Files, Paths, StandardCopyOption}

import cgra.IO._
import chisel3.util._
import cgra.config.system_var
import cgra.config.system_util._
import chisel3._
import cgra.IO.port_generator._
import cgra.config.encoding.{config_module_id_high, config_module_id_low}
import cgra.fabric.common.datapath.Multiplexer

import scala.collection.mutable
import scala.xml.Elem

class Router_Hw(pp:(String,Any)) extends Module
  with Has_IO
  with Reconfigurable {
  val p:mutable.Map[String,Any] = pp._2.asInstanceOf[mutable.Map[String,Any]]
  // Knob Parameters
  val module_name : String = pp._1
  println("Initialize " + module_name)
  val module_id : Int = try{p("module_id").asInstanceOf[Int]}catch{case _:Throwable => get_new_id}
  val use_global : Boolean = try{p("use_global").asInstanceOf[Boolean]}
  catch {case _: Throwable => false}
  val data_word_width : Int = try {if(use_global) system_var.data_word_width else p("data_word_width").asInstanceOf[Int]}
  catch{case _:Throwable => 64}
  val input_ports : List[String] = try{p("input_ports").asInstanceOf[List[String]]}
  catch{case _:Throwable => List("north","south","east","west","northwest")}
  val output_ports : List[String] = try{p("output_ports").asInstanceOf[List[String]]}
  catch{case _:Throwable => List("north","south","east","west","northeast","northwest","southeast","southwest")}
  val protocol : String = try{p("protocol").toString}
  catch {case _:Throwable => "Data"}
  val back_pressure_fifo_depth : Int = if(protocol.contains("Ready")){
    try p("back_pressure_fifo_depth").asInstanceOf[Int] catch{case _:Throwable => 1}}else{0}
  val isDecomposed : Boolean = try {p("isDecomposed").asInstanceOf[Boolean]}catch{case _:Throwable => false}
  val decomposer : Int = if(isDecomposed){try{p("decomposer").asInstanceOf[Int]}
  catch{case _:Throwable => 1}}else{1}
  val isShared : Boolean = try{p("isShared").asInstanceOf[Boolean]}catch{case _:Throwable => false}
  val shared_slot_size : Int = if(isShared){try{p("shared_slot_size").asInstanceOf[Int]}
  catch{case _:Throwable => 32}}else{0}
  val inter_subnet_connection : List[String]= try{p("inter_subnet_connection").asInstanceOf[List[String]]}
  catch{case _:Throwable => Nil}
  val config_input_port : List[String] = try p("config_input_port").asInstanceOf[List[String]]
  catch{case _:Throwable => List(input_ports.head)} // To support automatic config path builder
  // we only allow every node to have single config input port
  val config_output_port : List[String] = try p("config_output_port").asInstanceOf[List[String]]
  catch{case _:Throwable => output_ports}

  // Derived Variables
  val decomped_data_word_width : Int = data_word_width / decomposer
  val num_input : Int = input_ports.length
  val num_output : Int = output_ports.length
  val input_ports_subnet : List[String] = (for(subnet<- 0 until decomposer;port<-input_ports) yield port + "_" + subnet).toList
  val output_ports_subnet : List[String] = (for(subnet<- 0 until decomposer;port<-output_ports) yield port + "_" + subnet).toList
  val input_ports_protocol : List[String] = input_ports.map(p=>{if(p == config_input_port) protocol + "Config" else protocol})
  val output_ports_protocol : List[String] = output_ports.map(p=>{if(p == config_output_port) protocol + "Config" else protocol})
  val IO_LookUpTable : Array[Array[Boolean]]= Array.ofDim[Boolean](num_output * decomposer,num_input * decomposer)

  // ------ Configuration ------
  // Add default Connection
  for(in<-input_ports;out<-output_ports;subnet<-0 until decomposer){
    val in_port_subnet : String = in + "_" + subnet;val col = input_ports_subnet.indexOf(in_port_subnet)
    val out_port_subnet : String = out + "_" + subnet;val row = output_ports_subnet.indexOf(out_port_subnet)
    IO_LookUpTable(row)(col) = true
  }
  // Add Intersubnet Connection
  for (conn <- inter_subnet_connection){
    val connection : String = conn.replaceAll(" ","")
    val in_port_subnet : String = connection.split("<->").head
    val out_port_subnet : String = connection.split("<->")(1)
    val col = input_ports_subnet.indexOf(in_port_subnet)
    val row = output_ports_subnet.indexOf(out_port_subnet)
    IO_LookUpTable(row)(col) = true
  }

  // ------ Hardware ------
  // --- IO
  val io = IO(new Bundle{
    val input_ports = Flipped(Vec(num_input,Vec(decomposer,ReqAckConf_if(decomped_data_word_width))))
    val output_ports = Vec(num_output,Vec(decomposer,ReqAckConf_if(decomped_data_word_width)))
  })
  // Connect Useless Port with DontCare
  for(p_idx <- input_ports.indices;subnet <- 0 until decomposer){
    val port_type = input_ports_protocol(p_idx)
    val port = io.input_ports(p_idx)(subnet)
    gc_port(port,port_type)
  }
  for(p_idx <- output_ports.indices; subnet <- 0 until decomposer){
    val port_type = output_ports_protocol(p_idx)
    val port = io.output_ports(p_idx)(subnet)
    gc_port(port,port_type)
  }

  // ------ Calculate Hardware Configuration
  // Outer Loop, because each subnet is relative independent
  // Calculate MUXes configuration
  var config_register_files_width : Int = -1
  val all_MUXes : Array[Multiplexer] = new Array[Multiplexer](IO_LookUpTable.length);var mux_c = 0
  for (subnet <- 0 until decomposer){
    val output_name_idxs : List[(String,Int)] = output_ports_subnet.zipWithIndex.filter(_._1.endsWith(subnet.toString))
    var pre_high_bit : Int = -1
    for (output_name_idx <- output_name_idxs){
      // for configuration
      val mux : Multiplexer = new Multiplexer;all_MUXes(mux_c) = mux;mux_c += 1
      val sources_idx : Array[(String,Int)] = IO_LookUpTable(output_name_idx._2).zipWithIndex
        .filter(_._1).map(_._2).map(input_ports_subnet.zipWithIndex)
      mux.sources = sources_idx.map(_._1).toList
      mux.sink = output_name_idx._1
      val num_source = mux.sources.length
      mux.config_low = pre_high_bit + 1
      mux.config_high = mux.config_low + log2Ceil(num_source) - 1
      pre_high_bit = mux.config_high
    }
    config_register_files_width = (1 + pre_high_bit) max config_register_files_width
  }
  val config_register_files : Vec[UInt] = RegInit(VecInit(Seq.fill(decomposer)(0.U(config_register_files_width.W))))


  // ------ Config Wire
  // Extract Config Port based on Index
  val input_config_ports : List[Vec[ReqAckConf_if]]= config_input_port.map(ip=>input_ports.indexOf(ip)).map(io.input_ports)
  val output_config_ports : List[Vec[ReqAckConf_if]] = config_output_port.map(op=>output_ports.indexOf(op)).map(io.output_ports)
  // Create Config Wire
  val in_config_wire = Wire(config_wire(data_word_width))
  val out_config_wire = Wire(config_wire(data_word_width))
  // Connect Config Port with Config Wiring
  in_config_wire.bits := input_config_ports.head.map(_.bits).reduce(Cat(_,_)) // Assume That only have one config input port
  in_config_wire.config := input_config_ports.head.map(_.config).reduce(_&&_) // Assume That only have one config input port
  /*
  output_config_ports.zipWithIndex.foreach(op=>op._1.zipWithIndex.foreach(p=>{
    val output_port_idx = op._2
    val subnet_idx = p._2
    output_config_ports(output_port_idx)(subnet_idx).bits :=
      out_config_wire.bits((subnet_idx + 1) * decomped_data_word_width - 1,subnet_idx * decomped_data_word_width)
    output_config_ports(output_port_idx)(subnet_idx).config := out_config_wire.config
  }))
  */
  // Connect Input and Output Wire
  out_config_wire := in_config_wire

  // ------ Update Configuration
  val module_id_wire : UInt = in_config_wire.bits(config_module_id_high,config_module_id_low)
  val config_enable : Bool = in_config_wire.config && module_id.U === module_id_wire
  val subnet_select_wire = if(isDecomposed && decomposer > 1){Wire(UInt(log2Ceil(decomposer).W))}else{Wire(UInt(1.W))}
  val slot_select_wire = if(isShared && shared_slot_size > 1){Wire(UInt(log2Ceil(shared_slot_size).W))}else{Wire(UInt(1.W))}
  var config_subnet_high : Int = config_module_id_low
  var config_subnet_low : Int = config_module_id_low
  var config_slot_high : Int = config_module_id_low
  var config_slot_low : Int = config_module_id_low
  if(isDecomposed && decomposer > 1){
    // Specify Wiring
    config_subnet_high = config_module_id_low - 1;config_subnet_low = config_subnet_high - log2Ceil(decomposer) + 1
    subnet_select_wire := in_config_wire.bits(config_subnet_high,config_subnet_low)
  }else{
    subnet_select_wire := 0.U
  }
  if(isShared && shared_slot_size > 1){
    // Specify Wiring
    config_slot_high = config_subnet_low - 1
    config_slot_low = config_slot_high - log2Ceil(shared_slot_size) + 1
    slot_select_wire := in_config_wire.bits(config_slot_high,config_slot_low)
  }else{
    slot_select_wire := 0.U
  }
  // Specift Config Data Wiring
  var config_data_high : Int = config_slot_low - 1
  var config_data_low : Int = 0
  require(config_data_high + 1 > config_register_files_width,"Write Config Data / Instruction should be wider than Config Register")
  val config_data_wire : UInt = Wire(UInt((config_data_high + 1).W))
  config_data_wire := in_config_wire.bits(config_data_high,config_data_low)
  if(isShared){
    // Create Slot File
    val config_slot_files = RegInit( VecInit ( Seq.fill(decomposer) (VecInit(Seq.fill(shared_slot_size)(0.U(config_register_files_width.W)))) ) )
    val config_slot_counter =RegInit(VecInit(Seq.fill(decomposer)(0.U(log2Ceil(shared_slot_size).W))))
    config_slot_counter.zipWithIndex.foreach(c => {
      val counter = c._1;val subnet = c._2
      when(config_slot_files(subnet)(counter) === 0.U){
        counter := 0.U
      }.otherwise{counter := counter + 1.U}
    })
    for(subnet <- 0 until decomposer){
      config_register_files(subnet) := config_slot_files(subnet)(config_slot_counter(subnet))
    }
    // When Config Enabled
    when(config_enable){
      config_slot_files(subnet_select_wire)(slot_select_wire) := config_data_wire
      config_slot_counter(subnet_select_wire) := 0.U // Reset Counter When Slot updated
    }
  }else{
    when(config_enable){
      config_register_files(subnet_select_wire) := config_data_wire
    }
  }

  // ------ Create Hardware -------
  // Building the interface of MUXes (mux_out)
  val muxes_out_interface = Wire(Vec(all_MUXes.length,
    DecoupledIO(UInt(decomped_data_word_width.W))))
  for (mux_idx <- all_MUXes.indices){
    val mux_out = muxes_out_interface(mux_idx)
    val mux = all_MUXes(mux_idx)
    val out_port_name = mux.sink.split("_").head
    val out_port_idx:Int=output_ports.indexOf(out_port_name)
    val subnet : Int = mux.sink.split("_")(1).toInt
    // Get source index
    val sources = mux.sources
    val current_input_ports = sources.map(ps=>{
      val port = ps.split("_").head;val port_idx = input_ports.indexOf(port)
      val subnet = ps.split("_")(1).toInt
      io.input_ports(port_idx)(subnet)
    }).zipWithIndex
    val select_wire : UInt = config_register_files(subnet)(
      mux.config_high,mux.config_low)
    // Connect Data
    if(protocol.contains("Data")){
      val bits_select = current_input_ports.map(p =>  p._2.U -> p._1.bits)
      mux_out.bits := MuxLookup(select_wire,0.U,bits_select)
    }
    // Connect Valid
    if(protocol.contains("Valid")){
      val valid_select = current_input_ports.map(p=>  p._2.U -> p._1.valid)
      mux_out.valid := MuxLookup(select_wire,false.B,valid_select)
    }else{
      mux_out.valid := DontCare
    }
    // Connect Ready
    if(protocol.contains("Ready")){
      for (in_port_subnet <- input_ports_subnet){
        val in_port_subnet_idx = input_ports_subnet.indexOf(in_port_subnet)
        val connected_output_lookup : Array[(Array[Boolean],Int)] =
          IO_LookUpTable.zipWithIndex.filter(p=>p._1(in_port_subnet_idx))
        val connect_MUXes : Array[Multiplexer] = connected_output_lookup.map(_._2).map(all_MUXes)
        val connect_select_wire : Array[UInt] = connect_MUXes.map(m=>{
          val subnet = m.sink.split("_")(1).toInt;config_register_files(subnet)(m.config_high,m.config_low)
        })
        val connect_bridges : Array[DecoupledIO[UInt]] = connect_MUXes.map(m=>all_MUXes.indexOf(m)).map(muxes_out_interface)
        val connect_select_value : Array[Int] = connect_MUXes.map(m=>m.sources.indexOf(in_port_subnet))

        val back_pressure_signal : Bool = (for(m_idx <- connect_MUXes.indices)
          yield Mux(connect_select_wire(m_idx) === connect_select_value(m_idx).U,connect_bridges(m_idx).ready,true.B))
          .reduce(_&&_)
        val in_port_name :String = in_port_subnet.split("_").head;val in_port_idx : Int = input_ports.indexOf(in_port_name)
        val subnet : Int = in_port_subnet.split("_")(1).toInt
        io.input_ports(in_port_idx)(subnet).ready := back_pressure_signal
      }
    }else{
      mux_out.ready := DontCare
    }

    when(!config_enable){
      // Considering Backpressure FIFO
      if(back_pressure_fifo_depth > 0) {
        val queue_out = Queue(mux_out, back_pressure_fifo_depth)
        if (protocol.contains("Data"))
          io.output_ports(out_port_idx)(subnet).bits := queue_out.bits
        if (protocol.contains("Valid"))
          io.output_ports(out_port_idx)(subnet).valid := queue_out.valid
        if (protocol.contains("Ready"))
          io.output_ports(out_port_idx)(subnet).ready <> queue_out.ready
      }
      else {
        if(protocol.contains("Data"))
          io.output_ports(out_port_idx)(subnet).bits := mux_out.bits
        if(protocol.contains("Valid"))
          io.output_ports(out_port_idx)(subnet).valid := mux_out.valid
        if(protocol.contains("Ready"))
          io.output_ports(out_port_idx)(subnet).ready <> mux_out.ready
      }
    }otherwise{
      io.output_ports(out_port_idx)(subnet).valid := DontCare
      mux_out.ready := DontCare
      if(config_output_port.contains(out_port_name)){
        io.output_ports(out_port_idx)(subnet).bits :=
          out_config_wire.bits((subnet + 1) * decomped_data_word_width - 1,subnet * decomped_data_word_width)
        io.output_ports(out_port_idx)(subnet).config := out_config_wire.config
      }else{
        io.output_ports(out_port_idx)(subnet).bits := DontCare
        io.output_ports(out_port_idx)(subnet).config := DontCare
      }
    }
  }

  // Print for Debug
  if(module_name == "router_1"){
    for(port <- input_ports;subnet <- 0 until decomposer){
      printf(p"Input Port : Port = $port, Subnet = $subnet, " +
        p"Bits = ${io.input_ports(input_ports.indexOf(port))(subnet).bits}, " +
        p"Valid = ${io.input_ports(input_ports.indexOf(port))(subnet).valid}, " +
        p"Ready = ${io.input_ports(input_ports.indexOf(port))(subnet).ready}, " +
        p"Config = ${io.input_ports(input_ports.indexOf(port))(subnet).config}\n")
    }
  }

  // Configuration Output
  def config2XML : Elem = {
    <Router>
      <Module_Name>{module_name}</Module_Name>
      <Module_ID>{module_id}</Module_ID>
      <Input_Ports>{input_ports_subnet.zipWithIndex.map(p=>{<Index>{p._2}</Index><Port>{p._1}</Port>})}</Input_Ports>
      <Output_Ports>{output_ports_subnet.zipWithIndex.map(p=>{<Index>{p._2}</Index><Port>{p._1}</Port>})}</Output_Ports>
      <MUXes>{all_MUXes.map(b=>b.config2XML)}</MUXes>
    </Router>
  }
  // Get Port
  def get_port(io_t:String,name:String) : Vec[ReqAckConf_if] = {
    io_t match {
      case "in" => io.input_ports(input_ports.indexOf(name))
      case "out" => io.output_ports(output_ports.indexOf(name))
    }
  }
  def get_port_protocol(io_t:String,name:String) : String = {
    io_t match {
      case "in" => input_ports_protocol(input_ports.indexOf(name))
      case "out" => output_ports_protocol(output_ports.indexOf(name))
    }
  }
}


import cgra.config.system_var
import cgra.config.system_util._

object tester_router extends App{
  // Knob Parameters
  system_var.data_word_width = 64
  val p : mutable.Map[String,Any] = mutable.Map[String,Any]()
  p += "module_name" -> "Router_Test"
  p += "module_id" -> {
    for(i <- 0 until 60)
      get_new_id
    get_new_id
  }

  p += "output_ports" -> List("A","B")
  p += "output_ports" -> List("A","B")
  p += "protocol" -> "DataValidReady"
  p += "decomposer" -> 2

  p += "config_output_port" -> List("A")
  p += "isDecomposed" -> true
  p += "back_pressure_fifo_depth" -> 2
  p += "isShared" -> false
  p += "shared_slot_size" -> 2
  //p += "inter_subnet_connection" -> List("south_1 <-> north_0","northwest_0 <-> east _1")
  update
  chisel3.Driver.execute(args,()=>{new Router_Hw("test",p)})
}

object build_power_area_model_for_dedicated_router extends App {
  // Knob Parameters
  system_var.data_word_width = 64
  val p : mutable.Map[String,Any] = mutable.Map[String,Any]()
  p += "module_name" -> "Router_Test"
  p += "module_id" -> {
    for(i <- 0 until 60)
      get_new_id
    get_new_id
  }

  p += "config_output_port" -> List("A")
  p += "isDecomposed" -> true
  p += "back_pressure_fifo_depth" -> 2
  p += "isShared" -> false
  p += "shared_slot_size" -> 2

  val loop_for_input_ports = List(
    List("A")
    //List("A","B"), List("A","B","C","D"),List("A","B","C","D","E","F"),
    //List("A","B","C","D","E","F","G","H"),
    //List("A","B","C","D","E","F","G","H","I","J")
  )
  val loop_for_output_ports = List(
    List("A"),
    List("A","B"), List("A","B","C","D"),List("A","B","C","D","E","F"),
    List("A","B","C","D","E","F","G","H"),
    List("A","B","C","D","E","F","G","H","I","J")
  )
  val loop_protocol = List("DataValidReady","Data")

  val loop_decomposer = List(1,2,4,8)

  for(ip <- loop_for_input_ports;
      op <- loop_for_output_ports;
      protocol <- loop_protocol;
      decomposer <- loop_decomposer){
    p += "input_ports" -> ip
    p += "output_ports" -> op
    p += "protocol" -> protocol
    p += "decomposer" -> decomposer
    update
    chisel3.Driver.execute(args,()=>{new Router_Hw("test",p)})
    moveRenameFile("Router_Hw.v",
      "Router_Hw_i_" + ip.length + "_o_" + op.length +
    "_d_" + decomposer + "_f_" + (protocol == "DataValidReady") + ".v")
  }
  def moveRenameFile(source: String, destination: String): Unit = {
    Files.move(
      Paths.get(source),
      Paths.get(destination),
      StandardCopyOption.REPLACE_EXISTING
    )
  }
}
