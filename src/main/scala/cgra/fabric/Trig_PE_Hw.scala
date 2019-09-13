package cgra.fabric

import cgra.IO.ReqAckConf_if
import cgra.config.system_var
import cgra.config.system_util._
import chisel3._
import scala.xml.Elem
import cgra.fabric.Trig_PE_component.common.datapath.{arithmetic_logic_unit, register_file, scratchpad}
import cgra.fabric.Trig_PE_component.common.interconnect._
import cgra.fabric.Trig_PE_component.common.mmio.{mmio_if_t, unused_host_interface}
import cgra.fabric.Trig_PE_component.interconnect._
import cgra.fabric.Trig_PE_component.mmio._
import cgra.fabric.Trig_PE_component.instruction._
import cgra.fabric.Trig_PE_component.control._
import cgra.fabric.Trig_PE_component.datapath._
import cgra.IO.mmio_if
import cgra.fabric.Trig_PE_component.tia_parameters.derived_parameters._
import cgra.fabric.Trig_PE_component.tia_parameters.fixed_parameters._
import chisel3._
import chisel3.util._

import scala.collection.mutable

class Trig_PE_Hw(name_p:(String,Any)) extends Module
  with Has_IO
  with Reconfigurable {
  private val module_name = name_p._1
  private val module_id : Int = try{p("module_id").asInstanceOf[Int]}catch{case _:Throwable => get_new_id}
  private val p = name_p._2.asInstanceOf[mutable.Map[String,Any]]
  parameter_update(p)
  val input_ports : List[String] = try{p("input_ports").asInstanceOf[List[String]]}
  catch{case _:Throwable => List("northeast","southeast","northwest","southwest")}
  val output_ports : List[String] = try{p("output_ports").asInstanceOf[List[String]]}
  catch{case _:Throwable => List("northeast","southeast","northwest","southwest")}
  private val num_input = input_ports.length
  private val num_output = output_ports.length
  val data_word_width : Int = system_var.data_word_width
  val decomposer : Int = 1 // TODO : Triggered Inst. + Decomposability
  val protocol : String = "DataValidReadyConfig" // TODO : Explore possible other protocol ?

  // ------ Define Input Output

  val io = IO(new Bundle {
    val enable = Input(Bool())
    val execute = Input(Bool())
    val halted = Output(Bool())
    val chan_quies = Output(Bool())
    val hostInterface = mmio_if(TIA_MMIO_INDEX_WIDTH,TIA_MMIO_DATA_WIDTH)
    val input_channel_links = Vec(TIA_NUM_INPUT_CHANNELS,Flipped(ReqAckConf_if(TIA_WORD_WIDTH)))
    val output_channel_links = Vec(TIA_NUM_OUTPUT_CHANNELS,ReqAckConf_if(TIA_WORD_WIDTH))
  })

  val io_enable:Bool = io.enable
  val io_execute:Bool = io.execute
  val io_halted:Bool = io.halted
  val io_chan_quies:Bool = io.chan_quies
  val io_hostinterface:mmio_if = io.hostInterface
  val io_input_channel_links : Vec[link_if_t] = Wire(Vec(TIA_NUM_INPUT_CHANNELS,new link_if_t(TIA_TAG_WIDTH,TIA_WORD_WIDTH)))
  for(in_idx <- 0 until TIA_NUM_INPUT_CHANNELS){
    io_input_channel_links(in_idx).packet.data := io.input_channel_links(in_idx).bits
    io_input_channel_links(in_idx).packet.tag := io.input_channel_links(in_idx).config
    io_input_channel_links(in_idx).valid := io.input_channel_links(in_idx).valid
    io.input_channel_links(in_idx).ready := io_input_channel_links(in_idx).ready
  }
  val io_output_channel_links : Vec[link_if_t] = Wire(Vec(TIA_NUM_OUTPUT_CHANNELS,new link_if_t(TIA_TAG_WIDTH,TIA_WORD_WIDTH)))
  for(out_idx <- 0 until TIA_NUM_OUTPUT_CHANNELS){
    io.output_channel_links(out_idx).bits := io_output_channel_links(out_idx).packet.data
    io.output_channel_links(out_idx).config := io_output_channel_links(out_idx).packet.tag
    io_output_channel_links(out_idx).valid := io.output_channel_links(out_idx).ready
    io.output_channel_links(out_idx).valid := io_output_channel_links(out_idx).ready
  }//io.output_channel_links

  // --- Internal Logic and Wiring ---

  // MMIO Wiring
  val unused_host_interface = Module(new unused_host_interface).io
  val moniter_interface = Wire(new mmio_if_t)
  val performance_interface = Wire(new mmio_if_t)
  val register_file_interface = Wire(new mmio_if_t)
  val instruction_memory_interface = Wire(new mmio_if_t)
  val scratchpad_interface = Wire(new mmio_if_t)

  val input_channel_buffer_modules = for (i <- 0 until TIA_NUM_INPUT_CHANNELS) yield {
    Module(new input_channel_buffer).io
  }
  val output_channel_buffer_modules = for (i <- 0 until TIA_NUM_OUTPUT_CHANNELS) yield {
    Module(new output_channel_buffer).io
  }

  // Input and Output Channels
  val input_channels = Wire(Vec(TIA_NUM_INPUT_CHANNELS,
    new channel_if_sender_t))
  val output_channels = Wire(Vec(TIA_NUM_OUTPUT_CHANNELS,
    new channel_if_receiver_t))

  for (i <- 0 until TIA_NUM_INPUT_CHANNELS){
    input_channel_buffer_modules(i).enable := io_enable
    input_channels(i) <> input_channel_buffer_modules(i).out
    input_channel_buffer_modules(i).in <> io_input_channel_links(i)
  }
  // Output
  for (i <- 0 until TIA_NUM_OUTPUT_CHANNELS){
    output_channel_buffer_modules(i).enable := io_enable
    output_channel_buffer_modules(i).in <> output_channels(i)
    io_output_channel_links(i) <> output_channel_buffer_modules(i).out
  }

  // Control Wiring
  val halted,execute = Wire(Bool());execute := io_execute;io_halted := halted
  val internal_reset,internal_enable,triggered_instruction_valid,hazard,control_hazard,collision =
    Wire(Bool())
  val predicates = Wire(UInt(TIA_NUM_PREDICATES.W))
  val triggers = Wire(Vec(TIA_MAX_NUM_INSTRUCTIONS,new trigger_t))
  val trigger_instruction_index = Wire(UInt(TIA_INSTRUCTION_INDEX_WIDTH.W))
  val triggered_datapath_instruction, hazard_free_datapath_instruction,
  potentially_overridden_datapath_instruction,retiring_datapath_instruction =
    Wire(new datapath_instruction_t)
  val updated_input_channel_empty_status = Wire(UInt(TIA_NUM_INPUT_CHANNELS.W))
  val updated_output_channel_full_status = Wire(UInt(TIA_NUM_OUTPUT_CHANNELS.W))
  val input_channel_resolved_tags = Wire(Vec(TIA_NUM_INPUT_CHANNELS,UInt(TIA_TAG_WIDTH.W)))
  //val downstream_halt = Wire(Bool()) TODO: Performance counter

  // Datapath Wiring
  val zero_datapath_instruction = Module(new zero_datapath_instruction).io
  //val registers = Wire(Vec(TIA_NUM_REGISTERS,UInt(TIA_WORD_WIDTH.W))) //TODO: Not need to expose register for now
  val register_read_index = Wire(Vec(TIA_NUM_OPERANDS,UInt(TIA_REGISTER_INDEX_WIDTH.W)))
  val register_write_index = Wire(UInt(TIA_REGISTER_INDEX_WIDTH.W))
  val register_write_enable = Wire(Bool())
  val registers_read_data,pre_ofu_operands,post_ofu_operands = Wire(Vec(TIA_NUM_OPERANDS,UInt(TIA_WORD_WIDTH.W)))
  val register_write_data,alu_result,sm_result,imu_result,datapath_result = Wire(UInt(TIA_WORD_WIDTH.W))

  // Predicate prediction and speculation. TODO: Add speculative and predicition
  val trigger_override,predicate_prediction_hit,predicate_prediction_miss = Wire(Bool())
  trigger_override:= false.B;predicate_prediction_hit:= false.B;predicate_prediction_miss := false.B

  // Pipeline registers
  val dx1_instruction_retiring_stage, x2_instruction_retiring_stage = RegInit(0.U(3.W))
  val dx1_functional_unit, x2_functional_unit = RegInit(0.U(log2Ceil(TIA_NUM_FU_TYPES).W))
  val dx1_triggered_datapath_instruction, x2_triggered_datapath_instruction = RegInit(zero_datapath_instruction)

  // MMIO Mapping

  val cmap = Module(new core_mapper).io
  cmap.host_interface <> io_hostinterface
  cmap.monitor_interface <> moniter_interface
  cmap.performance_counters_interface <> performance_interface
  cmap.register_file_interface <> register_file_interface
  cmap.instruction_memory_interface <> instruction_memory_interface
  cmap.scratchpad_memory_interface <> scratchpad_interface

  // --- Monitor ---, TODO: ADD CORE_MONITOR
  unused_host_interface <> moniter_interface

  // Performance Counter, TODO: ADD PERFORMANCE COUNTER
  unused_host_interface <> performance_interface

  // --- Control ---

  // Execution control unit
  val ecu = Module(new execution_control_unit).io
  ecu.enable := io_enable
  ecu.execute := execute
  ecu.opcode := retiring_datapath_instruction.op
  ecu.input_channel_quiescent_status := VecInit(input_channel_buffer_modules.map(_.quiescent).reverse).asUInt()
  ecu.output_channel_quiescent_status := VecInit(output_channel_buffer_modules.map(_.quiescent).reverse).asUInt()
  internal_enable := ecu.internal_enable
  internal_reset := ecu.internal_reset
  halted := ecu.halted
  io_chan_quies := ecu.channels_quiescent

  // Predicate Unit
  val pu = Module(new predicate_unit)
  pu.reset := internal_reset
  pu.io.enable := internal_enable
  pu.io.datapath_dt := retiring_datapath_instruction.dt
  pu.io.datapath_di := retiring_datapath_instruction.di
  pu.io.datapath_result := datapath_result
  pu.io.instruction_pum := hazard_free_datapath_instruction.pum
  predicates := pu.io.predicates

  // Input Channel Empty Status Updater
  val ic_empty_updater = Module(new pessimistic_one_stage_input_channel_empty_status_updater).io
  ic_empty_updater.input_channel_empty_status := VecInit(input_channels.map(x=>x.empty)).asUInt()
  ic_empty_updater.downstream_icd := dx1_triggered_datapath_instruction.icd
  updated_input_channel_empty_status := ic_empty_updater.updated_input_channel_empty_status

  // Output Channel Full Status Updater
  val oc_full_updater = Module(new pessimistic_two_stage_output_channel_full_status_updater).io
  oc_full_updater.output_channel_full_status := VecInit(output_channels.map(x=>x.full).reverse).asUInt()
  oc_full_updater.first_downstream_oci := dx1_triggered_datapath_instruction.oci
  oc_full_updater.second_downstream_oci := x2_triggered_datapath_instruction.oci
  updated_output_channel_full_status := oc_full_updater.updated_output_channel_full_status

  // Input Channel look ahead unit
  val ic_lookahead = Module(new input_channel_tag_lookahead_unit).io
  ic_lookahead.original_tags := VecInit(input_channels.map(x=>x.pack.tag))
  ic_lookahead.next_tags := VecInit(input_channels.map(x=>x.next_pack.tag))
  ic_lookahead.pending_dequeue_signals := VecInit(input_channels.map(_.dequeue)).asUInt()
  input_channel_resolved_tags := ic_lookahead.resolved_tags

  // Trigger Resolution Unit
  val tru = Module(new trigger_resolution_unit).io
  tru.enable := internal_enable
  tru.execute := execute
  tru.halted := halted
  tru.triggers := triggers
  tru.predicates := predicates.asUInt()
  tru.input_channel_empty_status := updated_input_channel_empty_status
  tru.input_channel_tags := input_channel_resolved_tags
  tru.output_channel_full_status := updated_output_channel_full_status
  triggered_instruction_valid := tru.triggered_instruction_valid
  trigger_instruction_index := tru.triggered_instruction_index

  // --- Instruction Memory
  val im = Module(new instruction_memory).io
  im.enable := io_enable
  im.host_interface <> instruction_memory_interface
  triggers := im.triggers
  im.triggered_instruction_valid := triggered_instruction_valid
  im.triggered_instruction_index := trigger_instruction_index
  triggered_datapath_instruction := im.triggered_datapath_instruction

  // Hazard detection, TODO: Add speculative predicate unit
  control_hazard := 0.U
  val icd = Module(new integer_collision_detector).io
  icd.triggered_instruction_op := triggered_datapath_instruction.op
  icd.dx1_instruction_retiring_stage := dx1_instruction_retiring_stage
  collision := icd.collision
  hazard := control_hazard | collision
  when(hazard){
    hazard_free_datapath_instruction := zero_datapath_instruction
  }.otherwise{
    hazard_free_datapath_instruction := triggered_datapath_instruction
  }

  // Trigger override from speculative predicate unit, TODO Add speculative predicate unit
  potentially_overridden_datapath_instruction := hazard_free_datapath_instruction

  // T|DX1 Pipeline Register
  when(reset.toBool() || predicate_prediction_miss){
    dx1_triggered_datapath_instruction := zero_datapath_instruction
  }.elsewhen(io_enable){
    dx1_triggered_datapath_instruction := potentially_overridden_datapath_instruction
  }

  // --- Instruction Issue

  val iiu = Module(new integer_issue_unit).io
  iiu.dx1_instruction_op := dx1_triggered_datapath_instruction.op
  dx1_instruction_retiring_stage := iiu.retiring_stage
  dx1_functional_unit := iiu.functional_unit

  // Register File
  val rf = Module(new register_file).io
  rf.enable := io_enable
  rf.host_interface <> register_file_interface
  rf.read_indexes :=  register_read_index
  registers_read_data := rf.read_data
  rf.write_enable := register_write_enable
  rf.write_index := register_write_index
  rf.write_data := register_write_data

  // Source fetching unit
  val sfu = Module(new source_fetching_unit).io
  sfu.st := dx1_triggered_datapath_instruction.st
  sfu.si := dx1_triggered_datapath_instruction.si
  sfu.immediate := dx1_triggered_datapath_instruction.immediate
  sfu.input_channel_data := VecInit(input_channels.map(_.pack.data))
  register_read_index := sfu.register_read_indexes
  sfu.register_read_data := registers_read_data
  pre_ofu_operands := sfu.operands

  // Operand forwarding unit
  val ofu = Module(new operand_forwarding_unit).io
  ofu.enable := (dx1_instruction_retiring_stage === 2.U && x2_instruction_retiring_stage === 2.U &&
    dx1_functional_unit =/= ALU.U)
  ofu.source_types := dx1_triggered_datapath_instruction.st
  ofu.source_indices := dx1_triggered_datapath_instruction.si
  ofu.downstream_dt := dx1_triggered_datapath_instruction.dt
  ofu.downstream_di := dx1_triggered_datapath_instruction.di
  ofu.downstream_result := datapath_result
  ofu.pre_ofu_operands := pre_ofu_operands
  post_ofu_operands := ofu.post_ofu_operands

  // Arithmetic Logic Unit
  val alu = Module(new arithmetic_logic_unit).io
  alu.opcode := dx1_triggered_datapath_instruction.op
  alu.operands := pre_ofu_operands
  alu_result := alu.result

  // Scratchpad Memory
  if(TIA_HAS_SCRATCHPAD){
    val sm = Module(new scratchpad).io
    sm.hostInterface <> scratchpad_interface
    sm.opcode := dx1_triggered_datapath_instruction.op
    sm.operand0 := post_ofu_operands(0)
    sm.operand1 := post_ofu_operands(1)
    sm_result := sm.result
  }else{
    sm_result := 0.U
    unused_host_interface <> scratchpad_interface
  }

  // Integer Multiplication, TODO: add multipiler
  imu_result := 0.U

  // DX1|X2 Pipeline Register
  when (reset.toBool() || predicate_prediction_miss){
    x2_triggered_datapath_instruction := zero_datapath_instruction
    x2_instruction_retiring_stage := 0.U
    x2_functional_unit := ALU.U
  }.elsewhen(io_enable){
    when(dx1_instruction_retiring_stage === 2.U){
      x2_triggered_datapath_instruction := dx1_triggered_datapath_instruction
      x2_instruction_retiring_stage := dx1_instruction_retiring_stage
      x2_functional_unit := dx1_functional_unit
    }.otherwise{
      x2_triggered_datapath_instruction := zero_datapath_instruction
      x2_instruction_retiring_stage := 0.U
      x2_functional_unit := ALU.U
    }
  }

  // --- Retirement ---
  val iru = Module(new integer_retirement_unit).io
  iru.dx1_datapath_instruction := dx1_triggered_datapath_instruction
  iru.dx1_functional_unit := dx1_functional_unit
  iru.dx1_instruction_retiring_stage := dx1_instruction_retiring_stage
  iru.x2_datapath_instruction := x2_triggered_datapath_instruction
  iru.x2_functional_unit := x2_functional_unit
  iru.x2_instruction_retiring_stage := x2_instruction_retiring_stage
  iru.alu_result := alu_result
  iru.sm_result := sm_result
  iru.imu_result := imu_result
  retiring_datapath_instruction := iru.retiring_datapath_instruction
  datapath_result := iru.datapath_result

  // Destination routing unit
  val dru = Module(new destination_routing_unit).io
  dru.datapath_result := datapath_result
  dru.dt := retiring_datapath_instruction.dt
  dru.di := retiring_datapath_instruction.di
  dru.oci := retiring_datapath_instruction.oci
  register_write_enable := dru.register_write_enable
  register_write_index := dru.register_write_index
  register_write_data := dru.register_write_data
  output_channels.zipWithIndex.foreach(x=>x._1.pack.data := dru.output_channel_data(x._2))

  // dequeueing unit
  val du = Module(new dequeueing_unit).io
  du.enable := (io_enable && execute && !halted && dx1_triggered_datapath_instruction.vi)
  du.icd := dx1_triggered_datapath_instruction.icd
  input_channels.zipWithIndex.foreach(x=>x._1.dequeue := du.dequeue_signals(x._2))

  // enqueueing unit
  val eu = Module(new enqueueing_unit).io
  eu.enable := (io_enable && execute && !halted && retiring_datapath_instruction.vi)
  eu.oci := retiring_datapath_instruction.oci
  eu.oct := retiring_datapath_instruction.oct
  output_channels.zipWithIndex.foreach(x=>x._1.enqueue := eu.enqueue_signals(x._2))
  output_channels.zipWithIndex.foreach(x=>x._1.pack.tag := eu.outout_channel_tags(x._2))


  /*
  def get_port (io_t:String,name:String) = {
    io_t match {
      case "in" => {
        val temp = Wire(ReqAckConf_if(TIA_WORD_WIDTH).flip)
        val tag_word_valid_ready = io.input_channel_links(TIA_INPUT_CHANNELS.indexOf(name))
        tag_word_valid_ready.packet.data := temp.bits
        tag_word_valid_ready.valid := temp.valid
        temp.ready := tag_word_valid_ready.ready
        tag_word_valid_ready.packet.tag := temp.config
        Vec(temp)
      }
      case "out" => {
        val temp = Wire(ReqAckConf_if(TIA_WORD_WIDTH))
        val tag_word_valid_ready = io.output_channel_links(TIA_OUTPUT_CHANNELS.indexOf(name))
        temp.bits <> tag_word_valid_ready.packet.data
        temp.valid <> tag_word_valid_ready.ready  // valid mean deq
        temp.ready <> tag_word_valid_ready.valid  // ready mean not empty
        temp.config <> tag_word_valid_ready.packet.tag
        Vec(temp)
      }
    }
  }
  */
  def get_port(io_t:String,name:String) : Vec[ReqAckConf_if] = {
    io_t match {
      case "in" => VecInit(io.input_channel_links(input_ports.indexOf(name)))
      case "out" => VecInit(io.output_channel_links(output_ports.indexOf(name)))
    }
  }
  def get_port_protocol(io_t:String,name:String) : String = {
    protocol
  }
  def config2XML : Elem = {
    <Shared_PE>
      <Module_Name>{module_name}</Module_Name>
      <Module_ID>{module_id}</Module_ID>
    </Shared_PE>
  }
}

import cgra.config.system_var
import cgra.config.system_util._

object tester_trig_pe extends App{
  system_var.data_word_width = 64
  val p : mutable.Map[String,Any] = mutable.Map[String,Any]()

  p += "module_type"-> "shared_pe"
  p += "input_ports"-> List("northwest","northeast","southwest","southeast")
  p += "output_ports"-> List("northwest","northeast","southwest","southeast")
  p += "architecture"-> "integer"
  p += "immediate_width"-> 32
  p += "mm_instruction_width"-> 128
  p += "instructions"-> List("BOr")
  p += "num_instructions"-> 16
  p += "num_predicates"-> 8
  p += "num_registers"-> 8
  p += "has_multiplier"-> true
  p += "has_two_word_product_multiplier"-> true
  p += "has_scratchpad"-> false
  p += "num_scratchpad_words"-> 512
  p += "spm_depth"-> 8
  p += "latch_based_instruction_memory"-> false
  p += "ram_based_immediate_storage"-> false
  p += "channel_buffer_depth"-> 2
  p += "max_num_input_channels_to_check"-> 2
  p += "num_tags"-> 3
  p += "has_speculative_predicate_unit"-> true
  p += "has_effective_queue_status"-> true
  p += "has_debug_monitor"-> true
  p += "has_performance_counters"-> true
  p += "has_software_router"-> false
  p += "has_switch_router"-> true
  p += "num_physical_planes"-> 1
  p += "memory_link_buffer_fifo_depth"-> 4
  p += "num_data_memory_words"-> 32786
  p += "num_scratchpad_words_if_enabled"-> 512

  chisel3.Driver.execute(args,()=>{new Trig_PE_Hw("test",p)})
}
