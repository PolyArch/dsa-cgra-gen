package cgra.tia.core


import cgra.common.datapath.{arithmetic_logic_unit, register_file, scratchpad}
import cgra.common.interconnect._
import cgra.common.mmio.{mmio_if, mmio_if_t, unused_host_interface}
import chisel3._
import chisel3.util._
import cgra.tia.interconnect._
import cgra.tia.mmio._
import cgra.tia.instruction._
import cgra.tia.control._
import cgra.tia.datapath._
import cgra.tia.parameters.derived_parameters._

class integer_core extends Module
{
  val io = IO(
    new Bundle{
      val enable = Input(Bool())
      val execute = Input(Bool())
      val halted = Output(Bool())
      val channels_quiescent = Output(Bool())
      val host_interface = new mmio_if
      val input_channel_links = Vec(TIA_NUM_INPUT_CHANNELS,new link_if_in)
      val output_channel_links = Vec(TIA_NUM_OUTPUT_CHANNELS,new link_if_out)
    }
  )

  // --- Internal Logic and Wiring ---

  // MMIO Wiring
  val unused_host_interface = Module(new unused_host_interface).io
  val moniter_interface = Wire(new mmio_if_t)
  val performance_interface = Wire(new mmio_if_t)
  val register_file_interface = Wire(new mmio_if_t)
  val instruction_memory_interface = Wire(new mmio_if_t)
  val scratchpad_interface = Wire(new mmio_if_t)

  val input_channel_buffer_modules = for (i <- 0 until TIA_NUM_INPUT_CHANNELS) yield {
    Module(new input_channel_buffer(TIA_CHANNEL_BUFFER_FIFO_DEPTH)).io
  }
  val output_channel_buffer_modules = for (i <- 0 until TIA_NUM_OUTPUT_CHANNELS) yield {
    Module(new output_channel_buffer(TIA_CHANNEL_BUFFER_FIFO_DEPTH)).io
  }

  // Input and Output Channels
  val input_channels = Wire(Vec(TIA_NUM_INPUT_CHANNELS,new channel_if_sender_t(TIA_CHANNEL_BUFFER_FIFO_DEPTH)))
  val output_channels = Wire(Vec(TIA_NUM_OUTPUT_CHANNELS,new channel_if_receiver_t(TIA_CHANNEL_BUFFER_FIFO_DEPTH)))

  for (i <- 0 until TIA_NUM_INPUT_CHANNELS){
    input_channel_buffer_modules(i).enable := io.enable
    input_channels(i) <> input_channel_buffer_modules(i).out
    input_channel_buffer_modules(i).in <> io.input_channel_links(i)
  }
  // Output
  for (i <- 0 until TIA_NUM_OUTPUT_CHANNELS){
    output_channel_buffer_modules(i).enable := io.enable
    output_channel_buffer_modules(i).in <> output_channels(i)
    io.output_channel_links(i) <> output_channel_buffer_modules(i).out
  }

  // Control Wiring
  val halted,execute = Wire(Bool());execute := io.execute;io.halted := halted
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
  cmap.host_interface <> io.host_interface
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
  ecu.enable := io.enable
  ecu.execute := execute
  ecu.opcode := retiring_datapath_instruction.op
  ecu.input_channel_quiescent_status := Vec(input_channel_buffer_modules.map(_.quiescent)).asUInt()
  ecu.output_channel_quiescent_status := Vec(output_channel_buffer_modules.map(_.quiescent)).asUInt()
  internal_enable := ecu.internal_enable
  internal_reset := ecu.internal_reset
  halted := ecu.halted
  io.channels_quiescent := ecu.channels_quiescent

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
  ic_empty_updater.input_channel_empty_status := Vec(input_channels.map(x=>x.empty)).asUInt()
  ic_empty_updater.downstream_icd := dx1_triggered_datapath_instruction.icd
  updated_input_channel_empty_status := ic_empty_updater.updated_input_channel_empty_status

  // Output Channel Full Status Updater
  val oc_full_updater = Module(new pessimistic_two_stage_output_channel_full_status_updater).io
  oc_full_updater.output_channel_full_status := Vec(output_channels.map(x=>x.full)).asUInt()
  oc_full_updater.first_downstream_oci := dx1_triggered_datapath_instruction.oci
  oc_full_updater.second_downstream_oci := x2_triggered_datapath_instruction.oci
  updated_output_channel_full_status := oc_full_updater.updated_output_channel_full_status

  // Input Channel look ahead unit
  val ic_lookahead = Module(new input_channel_tag_lookahead_unit).io
  ic_lookahead.original_tags := Vec(input_channels.map(x=>x.pack.tag))
  ic_lookahead.next_tags := Vec(input_channels.map(x=>x.next_pack.tag))
  ic_lookahead.pending_dequeue_signals := Vec(input_channels.map(_.dequeue)).asUInt()
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
  im.enable := io.enable
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
  }.elsewhen(io.enable){
    dx1_triggered_datapath_instruction := potentially_overridden_datapath_instruction
  } .otherwise {
    dx1_triggered_datapath_instruction
  }

  // --- Instruction Issue

  val iiu = Module(new integer_issue_unit).io
  iiu.dx1_instruction_op := dx1_triggered_datapath_instruction.op
  dx1_instruction_retiring_stage := iiu.retiring_stage
  dx1_functional_unit := iiu.functional_unit

  // Register File
  val rf = Module(new register_file).io
  rf.enable := io.enable
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
  sfu.input_channel_data := Vec(input_channels.map(_.pack.data))
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
    unused_host_interface := scratchpad_interface
  }

  // Integer Multiplication, TODO: add multipiler
  imu_result := 0.U

  // DX1|X2 Pipeline Register
  when (reset.toBool() || predicate_prediction_miss){
    x2_triggered_datapath_instruction := zero_datapath_instruction
    x2_instruction_retiring_stage := 0.U
    x2_functional_unit := ALU.U
  }.elsewhen(io.enable){
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
  du.enable := (io.enable && execute && !halted && dx1_triggered_datapath_instruction.vi)
  du.icd := dx1_triggered_datapath_instruction.icd
  input_channels.zipWithIndex.foreach(x=>x._1.dequeue := du.dequeue_signals(x._2))

  // enqueueing unit
  val eu = Module(new enqueueing_unit).io
  eu.enable := (io.enable && execute && !halted && retiring_datapath_instruction.vi)
  eu.oci := retiring_datapath_instruction.oci
  eu.oct := retiring_datapath_instruction.oct
  output_channels.zipWithIndex.foreach(x=>x._1.enqueue := eu.enqueue_signals(x._2))
  output_channels.zipWithIndex.foreach(x=>x._1.pack.tag := eu.outout_channel_tags(x._2))
}

object integerCore_Driver extends App {
  chisel3.Driver.execute(args, () => new integer_core)
}