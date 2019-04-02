package cgra.fabric

import cgra.IO.{ReqAckConf_if, config_wire}
import cgra.IO.port_generator.gc_port
import cgra.config.system_var
import cgra.config.system_util._
import cgra.config.encoding.{config_module_id_high, config_module_id_low}
import cgra.config.fullinst._
import chisel3._
import chisel3.util._

import scala.collection.mutable
import scala.collection.mutable.ListBuffer
import cgra.fabric.common.datapath._

import scala.xml.Elem

class Dedicated_PE_Hw(name_p:(String,Any)) extends Module with Has_IO
  with Reconfigurable {

  // Extract Parameter
  val module_name = name_p._1
  println("Initialize " + module_name)
  private val p = name_p._2.asInstanceOf[mutable.Map[String,Any]]
  val module_id : Int = try{p("module_id").asInstanceOf[Int]}catch{case _:Throwable => get_new_id}
  val use_global : Boolean = try{p("use_global").asInstanceOf[Boolean]}
  catch {case _: Throwable => false}
  val input_ports : List[String] = try{p("input_ports").asInstanceOf[List[String]]}
  catch{case _:Throwable => List("northeast","southeast","northwest","southwest")}
  val output_ports : List[String] = try{p("output_ports").asInstanceOf[List[String]]}
  catch{case _:Throwable => List("southeast")}
  val protocol : String = try{p("protocol").toString}
  catch {case _:Throwable => "Data"}
  val delay_fifo_depth : Int = try p("delay_fifo_depth").asInstanceOf[Int] catch{case _:Throwable => 0}
  val isDecomposed : Boolean = try {p("isDecomposed").asInstanceOf[Boolean]}catch{case _:Throwable => false}
  val decomposer : Int = if(isDecomposed){try{p("decomposer").asInstanceOf[Int]}
  catch{case _:Throwable => 1}}else{1}
  val isShared : Boolean = try{p("isShared").asInstanceOf[Boolean]}catch{case _:Throwable => false}
  val shared_slot_size : Int = if(isShared){try{p("shared_slot_size").asInstanceOf[Int]}
  catch{case _:Throwable => 32}}else{0}
  val output_select_mode : String = if(output_ports.length >1){
    try{p("output_select_mode")toString}catch{case _: Throwable => "Universal"}
  }else{"Universal"}
  val register_file_size : Int = if(isShared){try{p("register_file_size").asInstanceOf[Int]}
  catch{case _:Throwable => 8}}else{0}
  val data_word_width : Int = try {if(use_global) system_var.data_word_width else p("data_word_width").asInstanceOf[Int]}
  catch{case _:Throwable => 64}
  val config_input_port : String = try p("config_input_port").toString catch{case _:Throwable => input_ports.head}
  val config_output_port : String = try p("config_output_port").toString catch{case _:Throwable => output_ports.head}
  private val instructions = p("instructions").asInstanceOf[List[String]]

  // Derived Variables
  val decomped_data_word_width : Int = data_word_width / decomposer
  val num_input : Int = input_ports.length
  val num_output : Int = output_ports.length
  val input_ports_subnet : List[String] = (for(subnet<- 0 until decomposer;port<-input_ports) yield port + "_" + subnet).toList
  val output_ports_subnet : List[String] = (for(subnet<- 0 until decomposer;port<-output_ports) yield port + "_" + subnet).toList
  val input_ports_protocol : List[String] = input_ports.map(p=>{if(p == config_input_port) protocol + "Config" else protocol})
  val output_ports_protocol : List[String] = output_ports.map(p=>{if(p == config_output_port) protocol + "Config" else protocol})

  // ------ Define Input Output
  val io = IO(new Bundle{
    val input_ports = Flipped(Vec(num_input,Vec(decomposer,ReqAckConf_if(decomped_data_word_width))))
    val output_ports = Vec(num_output,Vec(decomposer,ReqAckConf_if(decomped_data_word_width)))
  })
  // Connect Useless Port with DontCare
  for(p_idx <- input_ports.indices;subnet <- 0 until decomposer){
    val port_type : String = input_ports_protocol(p_idx)
    val port : ReqAckConf_if = io.input_ports(p_idx)(subnet)
    gc_port(port,port_type)
  }
  for(p_idx <- output_ports.indices; subnet <- 0 until decomposer){
    val port_type = output_ports_protocol(p_idx)
    val port = io.output_ports(p_idx)(subnet)
    gc_port(port,port_type)
  }

  // ------- Calculate Hardware Configuration
  var config_register_files_width : Int = -1
  val instruction_properties = instructions.map(p=>insts_prop(p))
  val max_num_operand : Int = instruction_properties.map(i=>i.numOperands) max
  val all_MUXes : Array[Multiplexer] = new Array[Multiplexer](decomposer * max_num_operand);var mux_c = 0
  val all_Delay_Channels : Array[Delay_FIFO] = new Array[Delay_FIFO](decomposer * max_num_operand);var dp_c = 0
  val all_ALUs : Array[Arithmetic_Logic_Unit] = new Array[Arithmetic_Logic_Unit](decomposer);var alu_c = 0
  for(subnet <- 0 until decomposer){
    var pre_high_bit : Int = -1
    for (operand_idx <- 0 until max_num_operand){
      // ------ Add MUX
      val mux : Multiplexer = new Multiplexer;all_MUXes(mux_c) = mux;mux_c += 1
      mux.operand = operand_idx
      mux.subnet = subnet
      mux.sources = input_ports_subnet.filter(s=>s.endsWith(subnet.toString))
      if(isShared){ // Add Source as MUX source if it is shared
        val temp = mux.sources.to[ListBuffer]
        for(r_idx <- 0 until register_file_size)
          temp += "reg_" + r_idx
        mux.sources = temp.toList
      }
      val num_source = mux.sources.length
      mux.config_low = pre_high_bit + 1
      mux.config_high = mux.config_low + log2Ceil(num_source) - 1
      pre_high_bit = mux.config_high
      // ------ Add Delay Pipe
      val dp : Delay_FIFO = new Delay_FIFO;all_Delay_Channels(dp_c) = dp;dp_c += 1
      dp.operand = operand_idx;dp.subnet = subnet
      dp.pipe_word_width = decomped_data_word_width
      dp.max_delay = delay_fifo_depth
      if(dp.max_delay > 0){
        dp.config_low = pre_high_bit + 1
        dp.config_high = dp.config_low + log2Ceil(1 + dp.max_delay) - 1
        pre_high_bit = dp.config_high
      }
      dp.protocol = protocol
    }
    // ------ Add Arithmetic_Logic_Unit
    val alu : Arithmetic_Logic_Unit = new Arithmetic_Logic_Unit;all_ALUs(alu_c) = alu;alu_c +=1
    alu.max_num_operand = max_num_operand
    alu.subnet = subnet
    alu.inst = instructions
    alu.alu_word_width = decomped_data_word_width
    alu.protocol = protocol
    if(instructions.length > 1){
      alu.opcode_config_low = pre_high_bit + 1
      alu.opcode_config_high = alu.opcode_config_low + log2Ceil(instructions.length) - 1
      pre_high_bit = alu.opcode_config_high
    }
    if(output_select_mode=="Individual"){
      val temp : ListBuffer[String] = alu.sink.to[ListBuffer]
      for(output_port <- output_ports)
        temp += output_port
      alu.sink = temp.toList
    }else if(output_select_mode=="Universal"){
      alu.sink = List("Universal Output")
    }
    if(isShared){
      val temp : ListBuffer[String] = alu.sink.to[ListBuffer]
      for(reg_idx <- 0 until register_file_size)
        temp += "reg_" + subnet + "_"+ reg_idx
      alu.sink = temp.toList
    }
    val num_alu_output = alu.sink.length
    if(num_alu_output > 1){
      alu.output_select_config_low = pre_high_bit + 1
      alu.output_select_config_high = alu.output_select_config_low + log2Ceil(num_alu_output) - 1
      pre_high_bit = alu.output_select_config_high
    }
    config_register_files_width = (1 + pre_high_bit) max config_register_files_width
  }
  // Initialize Hardware when Configuration computation is ready
  val muxes_out_interface = Wire(Vec(all_MUXes.length,DecoupledIO(UInt(decomped_data_word_width.W))))
  val all_alu_hw = all_ALUs.map(a=>Module(new Arithmetic_Logic_Unit_Hw(a)).io)
  val all_dp_hw = all_Delay_Channels.map(d=>Module(new Delay_FIFO_Hw(d)).io)
  val config_register_files : Vec[UInt] = RegInit(VecInit(Seq.fill(decomposer)(0.U(config_register_files_width.W))))

  // ------- Config Wire
  // Extract Config Port Name and Index
  val in_config_port_idx :List[(String,Int)] = input_ports_subnet.zipWithIndex
    .filter(p=>p._1.startsWith(config_input_port))
  val out_config_port_idx :List[(String,Int)]= output_ports_subnet.zipWithIndex
    .filter(p=>p._1.startsWith(config_output_port))
  // Extract Config Port based on Index
  val input_config_ports = io.input_ports(input_ports.indexOf(config_input_port))
  val output_config_ports = io.output_ports(output_ports.indexOf(config_output_port))
  // Create Config Wire
  val in_config_wire = Wire(config_wire(data_word_width))
  val out_config_wire = Wire(config_wire(data_word_width))
  // Connect Config Port with Config Wiring
  in_config_wire.bits := input_config_ports.map(_.bits).reduce(Cat(_,_))
  in_config_wire.config := input_config_ports.map(_.config).reduce(_&&_)
  output_config_ports.zipWithIndex.foreach(p=>{
    val idx = p._2
    output_config_ports(idx).bits := out_config_wire.bits((idx + 1) * decomped_data_word_width - 1,idx * decomped_data_word_width)
    output_config_ports(idx).config := out_config_wire.config
  })
  // Connect Input and Output Wire
  out_config_wire := in_config_wire

  // ------- Update Configuration
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
  require(config_data_high + 1 >= config_register_files_width,"Write Config Data / Instruction " +
    s"should be wider than Config Register, now we have $config_register_files_width bit config reg," +
    s"but incoming config data is just ${1+config_data_high} bit wide")
  val config_data_wire : UInt = Wire(UInt((config_data_high + 1).W))
  config_data_wire := in_config_wire.bits(config_data_high,config_data_low)
  if(isShared){
    // Create Slot File
    val config_slot_files =
      RegInit(VecInit(Seq.fill(decomposer)(VecInit(Seq.fill(shared_slot_size)(0.U(config_register_files_width.W))))))
    val config_slot_counter =
      RegInit(VecInit(Seq.fill(decomposer)(0.U(log2Ceil(shared_slot_size).W))))
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

  // ------- Create Hardware
  // Create Register File
  val register_file : Vec[Vec[UInt]] = if(isShared){
    RegInit(VecInit(Seq.fill(decomposer)(VecInit(Seq.fill(register_file_size)(0.U(decomped_data_word_width.W))))))
  }else{
    RegInit(VecInit(Seq.fill(1)(VecInit(Seq.fill(1)(0.U(1.W)))))) // if not shared, create a small 1 bit flip-flop, just for grammar check
  }
  // Create Datapath for each subnet
  for (subnet <- 0 until decomposer){
    // --- Extract ALU; GC port; connect config wire
    val alu = all_ALUs.find(a=>a.subnet == subnet).get
    val alu_hw = all_alu_hw(all_ALUs.indexOf(alu))
    alu_hw.in.foreach(gc_port(_,protocol));gc_port(alu_hw.out,protocol)
    if(alu.inst.length > 1){
      alu_hw.opcode := config_register_files(subnet)(alu.opcode_config_high,alu.opcode_config_low)
    }else{
      alu_hw.opcode := 0.U
    }

    val alu_sinks : List[String] = alu.sink
    val alu_output_select_wire = if(alu_sinks.length > 1)
      Wire(UInt(log2Ceil(alu.sink.length).W))else
      Wire(UInt(1.W)) // Not used, just for grammar check
    // ------ ALU -> Output port / Register File
    if(alu_sinks.length > 1){
      alu_output_select_wire := config_register_files(subnet)(alu.output_select_config_high,alu.output_select_config_low)
      // Write to Output Port
      if(alu_sinks.contains("Universal Output")){
        val selected_all_output_port : Bool = alu_output_select_wire === alu_sinks.indexOf("Universal Output").U
        if(protocol.contains("Data"))
          io.output_ports.foreach(ps=>ps(subnet).bits := Mux(selected_all_output_port,alu_hw.out.bits,0.U))
        if(protocol.contains("Valid"))
          io.output_ports.foreach(ps=>ps(subnet).valid := Mux(selected_all_output_port,alu_hw.out.valid,false.B))
        if(protocol.contains("Ready")){
          val output_backpressure_signal = (for(output <- output_ports)
            yield io.output_ports(output_ports.indexOf(output))(subnet).ready).reduce(_&&_)
          alu_hw.out.ready := Mux(selected_all_output_port,output_backpressure_signal,true.B)
        }
      }else{
        for(output_port <- output_ports){
          val port_idx = output_ports.indexOf(output_port)
          val selected_this_output_port : Bool = alu_output_select_wire === alu_sinks.indexOf(output_port).U
          if(protocol.contains("Data"))
            io.output_ports(port_idx)(subnet).bits := Mux(selected_this_output_port,alu_hw.out.bits,0.U)
          if(protocol.contains("Valid"))
            io.output_ports(port_idx)(subnet).valid := Mux(selected_this_output_port,alu_hw.out.valid,false.B)
          if(protocol.contains("Ready"))
            alu_hw.out.ready := Mux(selected_this_output_port,io.output_ports(port_idx)(subnet).ready,true.B)
        }
      }
      // Write to Register File
      if(isShared){
        val all_target_regs = alu_sinks.filter(a=>a.startsWith("reg"))
        for(target_reg <- all_target_regs){
          val reg_subnet : Int = target_reg.split("_")(1).toInt
          val reg_idx : Int = target_reg.split("_")(2).toInt
          val select_this_reg : Bool = if(protocol.contains("Valid"))
            alu_output_select_wire === alu_sinks.indexOf(target_reg).U && alu_hw.out.valid
          else alu_output_select_wire === alu_sinks.indexOf(target_reg).U
          when(select_this_reg){
            register_file(reg_subnet)(reg_idx) := alu_hw.out.bits
          }
        }
      }
    }else{ // Universal Output and Not Shared
      alu_output_select_wire := DontCare
      // Forward: ALU -> Output
      for (output_port <- output_ports){
        val port_idx = output_ports.indexOf(output_port)
        if(protocol.contains("Data"))
          io.output_ports(port_idx)(subnet).bits := alu_hw.out.bits
        if(protocol.contains("Valid"))
          io.output_ports(port_idx)(subnet).valid := alu_hw.out.valid
      }
      // Backward: Output -> ALU
      if(protocol.contains("Ready")){
        val backpressure_signal = (for(output <- output_ports)
          yield io.output_ports(output_ports.indexOf(output))(subnet).ready).reduce(_&&_)
        alu_hw.out.ready := backpressure_signal
      }
    }

    // --- Create datapath for each operand
    for (operand_idx <- 0 until max_num_operand){
      // Extract Delay Pipe; GC port; connect config wire
      val dp = all_Delay_Channels.find(d=>d.subnet == subnet && d.operand == operand_idx).get
      val dp_hw = all_dp_hw(all_Delay_Channels.indexOf(dp))
      gc_port(dp_hw.in,protocol);gc_port(dp_hw.out,protocol)
      if(dp.max_delay > 0){
        dp_hw.delay := config_register_files(subnet)(dp.config_high,dp.config_low)
      }else{
        dp_hw.delay := 0.U
      }
      // Extract MUX
      val mux = all_MUXes.find(m=>m.operand == operand_idx && m.subnet == subnet).get
      val mux_out = muxes_out_interface(all_MUXes.indexOf(mux))
      val sources = mux.sources
      val select_wire : UInt = config_register_files(subnet)(mux.config_high,mux.config_low)
      // ----- Pass Down Data
      if(protocol.contains("Data")){
        // Input / Register (Shared)  -> MUX
        val select_bits = sources.map(s=>{
          if(s.startsWith("reg")){
            val reg_idx = s.split("_")(1).toInt
            register_file(subnet)(reg_idx)
          }else{
            val port_name = s.split("_").head;val port_idx = input_ports.indexOf(port_name)
            io.input_ports(port_idx)(subnet).bits
          }}).zipWithIndex.map(p=> p._2.U -> p._1)
        // MUX -> Delay Pipe
        mux_out.bits := MuxLookup(select_wire,0.U,select_bits)
        dp_hw.in.bits := mux_out.bits
        // Delay Pipe -> ALU
        alu_hw.in(operand_idx).bits := dp_hw.out.bits
      }else{mux_out.bits := DontCare}
      // ----- Pass down valid
      if(protocol.contains("Valid")){
        // Input / Register (Shared)  -> MUX
        val select_valid = sources.map(s=>{
          if(s.startsWith("reg")){
            true.B
          }else{
            val port_name = s.split("_").head;val port_idx = input_ports.indexOf(port_name)
            io.input_ports(port_idx)(subnet).valid
          }}).zipWithIndex.map(p=> p._2.U -> p._1)
        // MUX -> Delay Pipe
        mux_out.valid := MuxLookup(select_wire,false.B,select_valid)
        dp_hw.in.valid := mux_out.valid
        // Delay Pipe -> ALU
        alu_hw.in(operand_idx).valid := dp_hw.out.valid
      }else{mux_out.valid := DontCare}
      // ----- Pass Back Ready
      if(protocol.contains("Ready")){
        // Delay Pipe <- ALU
        dp_hw.out.ready := alu_hw.in(operand_idx).ready
        // MUX <- Delay Pipe
        mux_out.ready := dp_hw.in.ready
      }else{mux_out.ready := DontCare}
    }
  }
  // ----- Pass Back Ready
  if(protocol.contains("Ready")){
    // Input <- MUX
    for(input_subnet <- input_ports_subnet){
      val port_name = input_subnet.split("_").head;val port_idx = input_ports.indexOf(port_name)
      val subnet = input_subnet.split("_")(1).toInt
      val connect_MUXes = all_MUXes.zipWithIndex.filter(m=>m._1.sources.exists(p=>p.startsWith(port_name))
        && m._1.subnet == subnet)
      val connect_select_value = connect_MUXes.map(m=>m._1.sources.indexOf(input_subnet))
      val connect_select_wire = connect_MUXes.map(m=>{
        val mux = m._1;val m_subnet = mux.subnet
        config_register_files(m_subnet)(mux.config_high,mux.config_low)
      })
      val connect_bridges = connect_MUXes.map(_._2).map(muxes_out_interface)
      val backpressure_signal : Bool = (for(m_idx <- connect_MUXes.indices)
        yield Mux(connect_select_wire(m_idx) === connect_select_value(m_idx).U,connect_bridges(m_idx).ready,true.B))
        .reduce(_&&_)
      io.input_ports(port_idx)(subnet).ready := backpressure_signal
    }
  }else{
    for(mux_out <- muxes_out_interface)
      mux_out.ready := DontCare
  }

  def get_num_max_operand(insts:List[String]):Int = {
    val subnet_word_width = data_word_width / decomposer
    insts.map(i=>insts_prop(i).numOperands) max
  }

  // ------ Print Configuration
  def config2XML : Elem = {
    <Dedicated_PE>
      <Module_Name>{module_name}</Module_Name>
      <Module_ID>{module_id}</Module_ID>
      <Input_Ports>{input_ports.zipWithIndex.map(p=>{<Index>{p._2}</Index><Port>{p._1}</Port>})}</Input_Ports>
      <Output_Ports>{output_ports.zipWithIndex.map(p=>{<Index>{p._2}</Index><Port>{p._1}</Port>})}</Output_Ports>
      <Width_Register_File>{config_register_files_width}</Width_Register_File>
      <MUXes>{all_MUXes.map(b=>b.config2XML)}</MUXes>
      <Delay_Pipes>{all_Delay_Channels.map(d=>d.config2XML)}</Delay_Pipes>
      <Alues>{all_ALUs.map(a=>a.config2XML)}</Alues>
    </Dedicated_PE>
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

object tester_pe extends App{
  system_var.data_word_width = 64
  val p : mutable.Map[String,Any] = mutable.Map[String,Any]()
  p += "module_name" -> "PE_Test"
  p += "module_id" -> {get_new_id;get_new_id;get_new_id;get_new_id;get_new_id;get_new_id;get_new_id;get_new_id}

  p += "protocol" -> "DataValidReady"
  p += "delay_fifo_depth" -> 4
  p += "instructions" -> List("Add", "Sub", "BOr", "BAnd")

  p += "isDecomposed" -> false
  p += "decomposer" -> 1

  p += "isShared" -> true
  p += "shared_slot_size" -> 32
  p += "register_file_size" -> 8

  chisel3.Driver.execute(args,()=>{new Dedicated_PE_Hw("test",p)})
}