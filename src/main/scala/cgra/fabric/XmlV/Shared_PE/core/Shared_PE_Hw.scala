package cgra.fabric.XmlV.Shared_PE.core


import cgra.entity.{Entity, Port}
import cgra.fabric.XmlV.Shared_PE.common.datapath.{arithmetic_logic_unit, register_file, scratchpad}
import cgra.fabric.XmlV.Shared_PE.common.interconnect._
import cgra.fabric.XmlV.Shared_PE.common.mmio.{mmio_if_t, unused_host_interface}
import cgra.fabric.XmlV.Shared_PE.interconnect._
import cgra.fabric.XmlV.Shared_PE.mmio._
import cgra.fabric.XmlV.Shared_PE.instruction._
import cgra.fabric.XmlV.Shared_PE.control._
import cgra.fabric.XmlV.Shared_PE.datapath._
import cgra.config.Constant._
import cgra.IO.IO_Interface._
import cgra.IO.mmio_if
import cgra.fabric.XmlV.Shared_PE.parameters.derived_parameters

case class Shared_PE() extends Entity with derived_parameters{

  entity_type = this.getClass.getName
  val enable_port = Port(INPUT_TYPE,false,false);enable_port.have("function","enable")
  val execute_port = Port(INPUT_TYPE,false,false);execute_port.have("function","execute")
  val halted_port = Port(OUTPUT_TYPE,false,false);halted_port.have("function","halted")
  val chan_quies_port = Port(OUTPUT_TYPE,false,false);chan_quies_port.have("function","channel_quiescent")
  have(enable_port,execute_port,halted_port,chan_quies_port)
  Ports.foreach(p=>p.have("Word_Width",1))


  def forsyn : Unit = {
    parameter_update(this)
    // Add mmio interface
    val control_port = Port(MMIO_TYPE,false,false);Ports += control_port
    control_port have ("function","control")
    control_port have ("Index_Width",TIA_MMIO_INDEX_WIDTH)
    control_port have ("Word_Width",TIA_MMIO_DATA_WIDTH)
    // Add input channel
    val input_channels = Port(MULTI_TAG_PACKET_TYPE,false,false);input_channels.have("IO Type",INPUT_TYPE)
    input_channels.have("tag_width",TIA_TAG_WIDTH);input_channels.have("device_word_width",TIA_WORD_WIDTH)
    input_channels.have("num_channel",TIA_NUM_INPUT_CHANNELS);Ports += input_channels
    // Add output channel
    val output_channels = Port(MULTI_TAG_PACKET_TYPE,false,false);output_channels.have("IO Type",OUTPUT_TYPE)
    output_channels.have("tag_width",TIA_TAG_WIDTH);output_channels.have("device_word_width",TIA_WORD_WIDTH)
    output_channels.have("num_channel",TIA_NUM_OUTPUT_CHANNELS);Ports += output_channels

    // Component Config
    require(get("has_core_monitor") != None)
    require(get("has_core_performance_counters") != None)
    require(get("has_multiplier") != None)
    require(get("has_software_router") != None)
    require(get("has_switch_router") != None)
    require(get("has_scratchpad") != None)

    // Require all necessary parameters is defined
    require(get("device_word_width") != None)
    require(get("num_registers")!= None)
    require(get("spm_depth")!= None)
    // Memory-mapped instruction representation.
    require(get("mm_instruction_width")!= None)
    // Maximum number of instructions per PE.
    require(get("max_num_instructions")!= None)
    // Number of input and output channels.
    require(get("num_input_channels")!= None)
    require(get("num_output_channels")!= None)

    // Instruction immediates.
    require(get("immediate_width")!= None)
    // Number of predicates to store state.
    require(get("num_predicates")!= None)
    // Tags for inter-PE/ME channels.
    require(get("num_tags")!= None)
    // Maximum number of input channels upon which an instruction can depend.
    require(get("max_num_input_channels_to_check")!= None)

    // --- Interconnect ---
    // Number of physical planes.
    require(get("num_physical_planes")!= None)
    // Generic channel FIFO depth.
    require(get("channel_buffer_fifo_depth")!= None)
    // Link buffer FIFO depth.
    require(get("link_buffer_fifo_depth")!= None)
    // Memory link buffer FIFO depth.
    require(get("memory_link_buffer_fifo_depth")!= None)
    // --- Memory ---
    require(get("num_data_memory_words")!= None)
    // --- Scratchpad ---
    require(get("num_scratchpad_words_if_enabled")!= None)

  }
}

import chisel3._
import chisel3.util._

class Shared_PE_Hw(p:Entity) extends Module
  with derived_parameters{
  parameter_update(p)
  /*
  val t_io = IO(
    new Bundle{
      val enable = Input(Bool())
      val execute = Input(Bool())
      val halted = Output(Bool())
      val channels_quiescent = Output(Bool())
      val host_interface = new mmio_if
      val input_channel_links = Vec(TIA_NUM_INPUT_CHANNELS,new link_if_in(TIA_TAG_WIDTH,TIA_WORD_WIDTH))
      val output_channel_links = Vec(TIA_NUM_OUTPUT_CHANNELS,new link_if_out(TIA_TAG_WIDTH,TIA_WORD_WIDTH))
    }
  )
  */
  val io = IO(MixedVec(get_io(p.Ports)))
  val io_enable:Bool = io(p.Ports.zipWithIndex.find(p=>p._1.get("function") == "enable").get._2).asInstanceOf[Bool]
  val io_execute:Bool = io(p.Ports.zipWithIndex.find(p=>p._1.get("function") == "execute").get._2).asInstanceOf[Bool]
  val io_halted:Bool = io(p.Ports.zipWithIndex.find(p=>p._1.get("function") == "halted").get._2).asInstanceOf[Bool]
  val io_chan_quies:Bool = io(p.Ports.zipWithIndex.find(p=>p._1.get("function") == "channel_quiescent").get._2).asInstanceOf[Bool]
  val io_hostinterface:mmio_if =
    io(p.Ports.zipWithIndex.find(p=>p._1.get("function") == "control").get._2).asInstanceOf[mmio_if]
  val io_input_channel_links = io(p.Ports.zipWithIndex.find(p=>p._1.io == MULTI_TAG_PACKET_TYPE && p._1.get("IO Type") == INPUT_TYPE)
    .get._2).asInstanceOf[Vec[link_if_in]]
  val io_output_channel_links = io(p.Ports.zipWithIndex.find(p=>p._1.io == MULTI_TAG_PACKET_TYPE && p._1.get("IO Type") == OUTPUT_TYPE)
    .get._2).asInstanceOf[Vec[link_if_out]]

  // --- Internal Logic and Wiring ---

  // MMIO Wiring
  val unused_host_interface = Module(new unused_host_interface(p)).io
  val moniter_interface = Wire(new mmio_if_t(p))
  val performance_interface = Wire(new mmio_if_t(p))
  val register_file_interface = Wire(new mmio_if_t(p))
  val instruction_memory_interface = Wire(new mmio_if_t(p))
  val scratchpad_interface = Wire(new mmio_if_t(p))

  // Extract Parameter
  /*
  val TIA_TAG_WIDTH : Int= p.get("TIA_TAG_WIDTH").asInstanceOf[Int]
  val TIA_WORD_WIDTH : Int= p.get("TIA_WORD_WIDTH").asInstanceOf[Int]
  val TIA_NUM_INPUT_CHANNELS : Int= p.get("num_input_channels").asInstanceOf[Int]
  val TIA_NUM_OUTPUT_CHANNELS : Int= p.get("num_output_channels").asInstanceOf[Int]
  val TIA_CHANNEL_BUFFER_FIFO_DEPTH : Int= p.get("channel_buffer_fifo_depth").asInstanceOf[Int]
  val TIA_NUM_PREDICATES : Int= p.get("num_predicate").asInstanceOf[Int]
  val TIA_MAX_NUM_INSTRUCTIONS : Int= p.get("num_max_instruction").asInstanceOf[Int]
  val TIA_NUM_REGISTERS : Int = p.get("num_register").asInstanceOf[Int]
  // Derived Parameter
  val TIA_INSTRUCTION_INDEX_WIDTH = log2Ceil(TIA_MAX_NUM_INSTRUCTIONS)
  val TIA_REGISTER_INDEX_WIDTH = log2Ceil(TIA_NUM_REGISTERS)
  */
  val input_channel_buffer_modules = for (i <- 0 until TIA_NUM_INPUT_CHANNELS) yield {
    Module(new input_channel_buffer(p)).io
  }
  val output_channel_buffer_modules = for (i <- 0 until TIA_NUM_OUTPUT_CHANNELS) yield {
    Module(new output_channel_buffer(p)).io
  }

  // Input and Output Channels
  val input_channels = Wire(Vec(TIA_NUM_INPUT_CHANNELS,
    new channel_if_sender_t(p)))
  val output_channels = Wire(Vec(TIA_NUM_OUTPUT_CHANNELS,
    new channel_if_receiver_t(p)))

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
  val triggers = Wire(Vec(TIA_MAX_NUM_INSTRUCTIONS,new trigger_t(p)))
  val trigger_instruction_index = Wire(UInt(TIA_INSTRUCTION_INDEX_WIDTH.W))
  val triggered_datapath_instruction, hazard_free_datapath_instruction,
  potentially_overridden_datapath_instruction,retiring_datapath_instruction =
    Wire(new datapath_instruction_t(p))
  val updated_input_channel_empty_status = Wire(UInt(TIA_NUM_INPUT_CHANNELS.W))
  val updated_output_channel_full_status = Wire(UInt(TIA_NUM_OUTPUT_CHANNELS.W))
  val input_channel_resolved_tags = Wire(Vec(TIA_NUM_INPUT_CHANNELS,UInt(TIA_TAG_WIDTH.W)))
  //val downstream_halt = Wire(Bool()) TODO: Performance counter

  // Datapath Wiring
  val zero_datapath_instruction = Module(new zero_datapath_instruction(p)).io
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

  val cmap = Module(new core_mapper(p)).io
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
  val ecu = Module(new execution_control_unit(p)).io
  ecu.enable := io_enable
  ecu.execute := execute
  ecu.opcode := retiring_datapath_instruction.op
  ecu.input_channel_quiescent_status := Vec(input_channel_buffer_modules.map(_.quiescent)).asUInt()
  ecu.output_channel_quiescent_status := Vec(output_channel_buffer_modules.map(_.quiescent)).asUInt()
  internal_enable := ecu.internal_enable
  internal_reset := ecu.internal_reset
  halted := ecu.halted
  io_chan_quies := ecu.channels_quiescent

  // Predicate Unit
  val pu = Module(new predicate_unit(p))
  pu.reset := internal_reset
  pu.io.enable := internal_enable
  pu.io.datapath_dt := retiring_datapath_instruction.dt
  pu.io.datapath_di := retiring_datapath_instruction.di
  pu.io.datapath_result := datapath_result
  pu.io.instruction_pum := hazard_free_datapath_instruction.pum
  predicates := pu.io.predicates

  // Input Channel Empty Status Updater
  val ic_empty_updater = Module(new pessimistic_one_stage_input_channel_empty_status_updater(p)).io
  ic_empty_updater.input_channel_empty_status := Vec(input_channels.map(x=>x.empty)).asUInt()
  ic_empty_updater.downstream_icd := dx1_triggered_datapath_instruction.icd
  updated_input_channel_empty_status := ic_empty_updater.updated_input_channel_empty_status

  // Output Channel Full Status Updater
  val oc_full_updater = Module(new pessimistic_two_stage_output_channel_full_status_updater(p)).io
  oc_full_updater.output_channel_full_status := Vec(output_channels.map(x=>x.full)).asUInt()
  oc_full_updater.first_downstream_oci := dx1_triggered_datapath_instruction.oci
  oc_full_updater.second_downstream_oci := x2_triggered_datapath_instruction.oci
  updated_output_channel_full_status := oc_full_updater.updated_output_channel_full_status

  // Input Channel look ahead unit
  val ic_lookahead = Module(new input_channel_tag_lookahead_unit(p)).io
  ic_lookahead.original_tags := Vec(input_channels.map(x=>x.pack.tag))
  ic_lookahead.next_tags := Vec(input_channels.map(x=>x.next_pack.tag))
  ic_lookahead.pending_dequeue_signals := Vec(input_channels.map(_.dequeue)).asUInt()
  input_channel_resolved_tags := ic_lookahead.resolved_tags

  // Trigger Resolution Unit
  val tru = Module(new trigger_resolution_unit(p)).io
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
  val im = Module(new instruction_memory(p)).io
  im.enable := io_enable
  im.host_interface <> instruction_memory_interface
  triggers := im.triggers
  im.triggered_instruction_valid := triggered_instruction_valid
  im.triggered_instruction_index := trigger_instruction_index
  triggered_datapath_instruction := im.triggered_datapath_instruction

  // Hazard detection, TODO: Add speculative predicate unit
  control_hazard := 0.U
  val icd = Module(new integer_collision_detector(p)).io
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

  val iiu = Module(new integer_issue_unit(p)).io
  iiu.dx1_instruction_op := dx1_triggered_datapath_instruction.op
  dx1_instruction_retiring_stage := iiu.retiring_stage
  dx1_functional_unit := iiu.functional_unit

  // Register File
  val rf = Module(new register_file(p)).io
  rf.enable := io_enable
  rf.host_interface <> register_file_interface
  rf.read_indexes :=  register_read_index
  registers_read_data := rf.read_data
  rf.write_enable := register_write_enable
  rf.write_index := register_write_index
  rf.write_data := register_write_data

  // Source fetching unit
  val sfu = Module(new source_fetching_unit(p)).io
  sfu.st := dx1_triggered_datapath_instruction.st
  sfu.si := dx1_triggered_datapath_instruction.si
  sfu.immediate := dx1_triggered_datapath_instruction.immediate
  sfu.input_channel_data := Vec(input_channels.map(_.pack.data))
  register_read_index := sfu.register_read_indexes
  sfu.register_read_data := registers_read_data
  pre_ofu_operands := sfu.operands

  // Operand forwarding unit
  val ofu = Module(new operand_forwarding_unit(p)).io
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
  val alu = Module(new arithmetic_logic_unit(p)).io
  alu.opcode := dx1_triggered_datapath_instruction.op
  alu.operands := pre_ofu_operands
  alu_result := alu.result

  // Scratchpad Memory
  if(TIA_HAS_SCRATCHPAD){
    val sm = Module(new scratchpad(p)).io
    sm.hostInterface <> scratchpad_interface
    sm.opcode := dx1_triggered_datapath_instruction.op
    sm.operand0 := post_ofu_operands(0)
    sm.operand1 := post_ofu_operands(1)
    sm_result := sm.result
  }else{
    sm_result := 0.U
    unused_host_interface := scratchpad_interface
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
  val iru = Module(new integer_retirement_unit(p)).io
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
  val dru = Module(new destination_routing_unit(p)).io
  dru.datapath_result := datapath_result
  dru.dt := retiring_datapath_instruction.dt
  dru.di := retiring_datapath_instruction.di
  dru.oci := retiring_datapath_instruction.oci
  register_write_enable := dru.register_write_enable
  register_write_index := dru.register_write_index
  register_write_data := dru.register_write_data
  output_channels.zipWithIndex.foreach(x=>x._1.pack.data := dru.output_channel_data(x._2))

  // dequeueing unit
  val du = Module(new dequeueing_unit(p)).io
  du.enable := (io_enable && execute && !halted && dx1_triggered_datapath_instruction.vi)
  du.icd := dx1_triggered_datapath_instruction.icd
  input_channels.zipWithIndex.foreach(x=>x._1.dequeue := du.dequeue_signals(x._2))

  // enqueueing unit
  val eu = Module(new enqueueing_unit(p)).io
  eu.enable := (io_enable && execute && !halted && retiring_datapath_instruction.vi)
  eu.oci := retiring_datapath_instruction.oci
  eu.oct := retiring_datapath_instruction.oct
  output_channels.zipWithIndex.foreach(x=>x._1.enqueue := eu.enqueue_signals(x._2))
  output_channels.zipWithIndex.foreach(x=>x._1.pack.tag := eu.outout_channel_tags(x._2))

}
/*
object integerCore_Driver extends App {
  chisel3.Driver.execute(args, () => new Shared_PE_Hw(Shared_PE()))
}
*/