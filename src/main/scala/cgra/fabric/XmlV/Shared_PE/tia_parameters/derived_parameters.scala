
package cgra.fabric.XmlV.Shared_PE.parameters

import cgra.entity.Entity
import cgra.fabric.XmlV.Shared_PE.instruction.mm_instruction_t
import cgra.fabric.XmlV.Shared_PE.tia_parameters.initial_parameters
import chisel3._

import math._
import chisel3.util._


trait derived_parameters extends fixed_parameters
  with initial_parameters{

  def cat_inst_asOne(tbr_ins:mm_instruction_t):UInt = {
    Cat(tbr_ins.padding,
      tbr_ins.immediate,
      tbr_ins.ictv,
      tbr_ins.ictb,
      tbr_ins.ici,
      tbr_ins.ptm,
      tbr_ins.pum,
      tbr_ins.icd,
      tbr_ins.oct,
      tbr_ins.oci,
      tbr_ins.di,
      tbr_ins.dt,
      tbr_ins.si,
      tbr_ins.st,
      tbr_ins.op,
      tbr_ins.vi)
  }

  /*
  def extractBits(ori:UInt,fieldR:fieldRange):UInt =
    ori(fieldR.high,fieldR.low)
  */
  def nextFieldRange(width:Int,lowFieldRange:fieldRange):fieldRange =
    new fieldRange(width + lowFieldRange.high,lowFieldRange.high + 1)

  class fieldRange(h:Int,l:Int){
    var high:Int  = h
    var low:Int = l
  }
  // ----- Instruction Structure -----
  // Low
  var vi_r = new fieldRange(0,0)
  var op_r = nextFieldRange(TIA_OP_WIDTH,vi_r)
  var st_r = nextFieldRange(TIA_ST_WIDTH,op_r)
  var si_r = nextFieldRange(TIA_SI_WIDTH ,st_r)
  var dt_r = nextFieldRange(TIA_DT_WIDTH,si_r)
  var di_r = nextFieldRange(TIA_DI_WIDTH,dt_r)
  var oci_r = nextFieldRange(TIA_OCI_WIDTH,di_r)
  var oct_r = nextFieldRange(TIA_OCT_WIDTH,oci_r)
  var icd_r = nextFieldRange(TIA_ICD_WIDTH,oct_r)
  var pum_r = nextFieldRange(TIA_PUM_WIDTH,icd_r)
  // ------ non immediate ------
  var ptm_r = nextFieldRange(TIA_PTM_WIDTH,pum_r)
  var ici_r = nextFieldRange(TIA_ICI_WIDTH,ptm_r)
  var ictb_r = nextFieldRange(TIA_ICTB_WIDTH,ici_r)
  var ictv_r = nextFieldRange(TIA_ICTV_WIDTH,ictb_r)
  var immediate_r = nextFieldRange(TIA_IMMEDIATE_WIDTH,ictv_r)
  var padding_r = nextFieldRange(TIA_MM_INSTRUCTION_PADDING_WIDTH,immediate_r)
  // High


  def parameter_update(p:Entity):Unit={
    // --------------  Component Config ---------
    TIA_HAS_CORE_MONITOR = p.get("has_core_monitor").asInstanceOf[Boolean]
    TIA_HAS_CORE_PERFORMANCE_COUNTERS = p.get("has_core_performance_counters").asInstanceOf[Boolean]
    TIA_HAS_MULTIPLIER = p.get("has_multiplier").asInstanceOf[Boolean]
    TIA_SOFTWARE_ROUTER = p.get("has_software_router").asInstanceOf[Boolean]
    TIA_SWITCH_ROUTER = p.get("has_switch_router").asInstanceOf[Boolean]
    TIA_HAS_SCRATCHPAD = p.get("has_scratchpad").asInstanceOf[Boolean]

    // --------------  Knob  --------------------
    TIA_WORD_WIDTH = p.get("device_word_width").asInstanceOf[Int]
    TIA_NUM_REGISTERS = p.get("num_registers").asInstanceOf[Int]
    TIA_SPM_DEPTH = p.get("spm_depth").asInstanceOf[Int]

    // Memory-mapped instruction representation.
    TIA_MM_INSTRUCTION_WIDTH = p.get("mm_instruction_width").asInstanceOf[Int]

    // Maximum number of instructions per PE.
    TIA_MAX_NUM_INSTRUCTIONS = p.get("max_num_instructions").asInstanceOf[Int]

    // Number of input and output channels.
    TIA_NUM_INPUT_CHANNELS = p.get("num_input_channels").asInstanceOf[Int]
    TIA_NUM_OUTPUT_CHANNELS = p.get("num_output_channels").asInstanceOf[Int]

    // Instruction immediates.
    TIA_IMMEDIATE_WIDTH = p.get("immediate_width").asInstanceOf[Int]

    // How many input channels we can dequeue in a single cycle.
    //TIA_MAX_NUM_INPUT_CHANNELS_TO_DEQUEUE = TIA_NUM_INPUT_CHANNELS // TODO: remove.

    // Number of predicates to store state.
    TIA_NUM_PREDICATES = p.get("num_predicates").asInstanceOf[Int]

    // Tags for inter-PE/ME channels.
    TIA_NUM_TAGS = p.get("num_tags").asInstanceOf[Int]

    // Maximum number of input channels upon which an instruction can depend.
    TIA_MAX_NUM_INPUT_CHANNELS_TO_CHECK = p.get("max_num_input_channels_to_check").asInstanceOf[Int]

    // --- Interconnect ---

    // Number of physical planes.
    TIA_NUM_PHYSICAL_PLANES = p.get("num_physical_planes").asInstanceOf[Int]

    // Generic channel FIFO depth.
    TIA_CHANNEL_BUFFER_FIFO_DEPTH = p.get("channel_buffer_fifo_depth").asInstanceOf[Int]

    // Link buffer FIFO depth.
    TIA_LINK_BUFFER_FIFO_DEPTH = p.get("link_buffer_fifo_depth").asInstanceOf[Int]

    // Memory link buffer FIFO depth.
    TIA_MEMORY_LINK_BUFFER_FIFO_DEPTH = p.get("memory_link_buffer_fifo_depth").asInstanceOf[Int]

    // --- Memory ---

    TIA_NUM_DATA_MEMORY_WORDS = p.get("num_data_memory_words").asInstanceOf[Int]

    // --- Scratchpad ---
    TIA_NUM_SCRATCHPAD_WORDS_IF_ENABLED = p.get("num_scratchpad_words_if_enabled").asInstanceOf[Int]


    // -------------------- Knob End ----------------------


    TIA_SPM_INDEX_WIDTH = log2Ceil(TIA_SPM_DEPTH)

    // Index widths.
    TIA_INSTRUCTION_INDEX_WIDTH = log2Ceil(TIA_MAX_NUM_INSTRUCTIONS)
    TIA_REGISTER_INDEX_WIDTH = log2Ceil(TIA_NUM_REGISTERS)

    // --- Triggered Instruction Field Widths ---

    TIA_TRUE_PTM_WIDTH = TIA_NUM_PREDICATES
    TIA_FALSE_PTM_WIDTH = TIA_NUM_PREDICATES
    TIA_PTM_WIDTH = TIA_TRUE_PTM_WIDTH + TIA_FALSE_PTM_WIDTH
    TIA_SINGLE_ICI_WIDTH = log2Ceil(TIA_NUM_INPUT_CHANNELS + 1)
    TIA_ICI_WIDTH = TIA_MAX_NUM_INPUT_CHANNELS_TO_CHECK * TIA_SINGLE_ICI_WIDTH
    TIA_TAG_WIDTH = log2Ceil(TIA_NUM_TAGS)
    TIA_ICTB_WIDTH = TIA_MAX_NUM_INPUT_CHANNELS_TO_CHECK
    TIA_ICTV_WIDTH = TIA_MAX_NUM_INPUT_CHANNELS_TO_CHECK * TIA_TAG_WIDTH
    TIA_OP_WIDTH = log2Ceil(TIA_NUM_OPS)
    TIA_SINGLE_ST_WIDTH = log2Ceil(TIA_NUM_SOURCE_TYPES)

    TIA_ST_WIDTH = TIA_NUM_SOURCE * TIA_SINGLE_ST_WIDTH
    TIA_SINGLE_SI_WIDTH = log2Ceil(max(TIA_NUM_REGISTERS, TIA_NUM_INPUT_CHANNELS))
    TIA_SI_WIDTH = TIA_NUM_SOURCE * TIA_SINGLE_SI_WIDTH
    TIA_DT_WIDTH = log2Ceil(TIA_NUM_DESTINATION_TYPES)
    TIA_DI_WIDTH = log2Ceil(max(max(TIA_NUM_REGISTERS, TIA_NUM_OUTPUT_CHANNELS), TIA_NUM_PREDICATES))
    TIA_OCI_WIDTH = TIA_NUM_OUTPUT_CHANNELS
    TIA_OCT_WIDTH = TIA_TAG_WIDTH
    TIA_ICD_WIDTH = TIA_NUM_INPUT_CHANNELS
    TIA_TRUE_PUM_WIDTH = TIA_TRUE_PTM_WIDTH
    TIA_FALSE_PUM_WIDTH = TIA_FALSE_PTM_WIDTH
    TIA_PUM_WIDTH = TIA_TRUE_PUM_WIDTH + TIA_FALSE_PUM_WIDTH
    TIA_NON_IMMEDIATE_INSTRUCTION_WIDTH = (1 + TIA_PTM_WIDTH
      + TIA_ICI_WIDTH
      + TIA_ICTB_WIDTH
      + TIA_ICTV_WIDTH
      + TIA_OP_WIDTH
      + TIA_ST_WIDTH
      + TIA_SI_WIDTH
      + TIA_DT_WIDTH
      + TIA_DI_WIDTH
      + TIA_OCI_WIDTH
      + TIA_OCT_WIDTH
      + TIA_ICD_WIDTH
      + TIA_PUM_WIDTH)
    TIA_PHY_INSTRUCTION_WIDTH = TIA_NON_IMMEDIATE_INSTRUCTION_WIDTH + TIA_IMMEDIATE_WIDTH
    TIA_MM_INSTRUCTION_PADDING_WIDTH = TIA_MM_INSTRUCTION_WIDTH - TIA_PHY_INSTRUCTION_WIDTH

    // Exposed count widths.
    TIA_CHANNEL_BUFFER_COUNT_WIDTH = log2Ceil(TIA_CHANNEL_BUFFER_FIFO_DEPTH) + 1

    // Channel index widths.
    TIA_INPUT_CHANNEL_INDEX_WIDTH = log2Ceil(TIA_NUM_INPUT_CHANNELS)
    TIA_OUTPUT_CHANNEL_INDEX_WIDTH = log2Ceil(TIA_NUM_OUTPUT_CHANNELS)

    // --- debug monitor--------------------------------------------------------------------------------------

    // Set in knob parameters
    var TIA_NUM_CORE_MONITOR_WORDS:Int = 0
    if(TIA_HAS_CORE_MONITOR)
      TIA_NUM_CORE_MONITOR_WORDS = TIA_NUM_CORE_MONITOR_REGISTERS_IF_ENABLED + TIA_NUM_REGISTERS
    else
      TIA_NUM_CORE_MONITOR_WORDS = 0

    // --- Core Performance Counters ---

    // Set in knob parameters.
    var TIA_NUM_CORE_PERFORMANCE_COUNTERS:Int = 0
    if(TIA_HAS_CORE_PERFORMANCE_COUNTERS) TIA_NUM_CORE_PERFORMANCE_COUNTERS = TIA_NUM_CORE_PERFORMANCE_COUNTERS_IF_ENABLED
    else TIA_NUM_CORE_PERFORMANCE_COUNTERS = 0

    // --- Register File and Instruction Memory ---

    // MMIO address space words.
    TIA_NUM_REGISTER_FILE_WORDS = TIA_NUM_REGISTERS
    TIA_NUM_INSTRUCTION_MEMORY_WORDS = TIA_MAX_NUM_INSTRUCTIONS * TIA_MM_INSTRUCTION_WIDTH / TIA_MMIO_DATA_WIDTH

    // --- Scratchpad ---

    // Set in knob parameters.
    var TIA_NUM_SCRATCHPAD_WORDS:Int = 0
    if(TIA_HAS_SCRATCHPAD) TIA_NUM_SCRATCHPAD_WORDS = TIA_NUM_SCRATCHPAD_WORDS_IF_ENABLED
    else TIA_NUM_SCRATCHPAD_WORDS = 0

    // --- Core Memory Map ---

    // Memory map of an individual PE.
    TIA_CORE_MONITOR_BASE_INDEX = 0

    var TIA_CORE_MONITOR_BOUND_INDEX:Int = 0
    if (TIA_HAS_CORE_MONITOR) TIA_CORE_MONITOR_BOUND_INDEX = TIA_NUM_CORE_MONITOR_WORDS
    else TIA_CORE_MONITOR_BOUND_INDEX = 0
    TIA_CORE_PERFORMANCE_COUNTERS_BASE_INDEX = TIA_CORE_MONITOR_BOUND_INDEX

    var TIA_CORE_PERFORMANCE_COUNTERS_BOUND_INDEX:Int = 0
    if (TIA_HAS_CORE_PERFORMANCE_COUNTERS) TIA_CORE_PERFORMANCE_COUNTERS_BOUND_INDEX = TIA_CORE_PERFORMANCE_COUNTERS_BASE_INDEX + TIA_NUM_CORE_PERFORMANCE_COUNTERS
    else TIA_CORE_PERFORMANCE_COUNTERS_BOUND_INDEX = TIA_CORE_MONITOR_BOUND_INDEX

    TIA_CORE_REGISTER_FILE_BASE_INDEX = TIA_CORE_PERFORMANCE_COUNTERS_BOUND_INDEX
    TIA_CORE_REGISTER_FILE_BOUND_INDEX = TIA_CORE_REGISTER_FILE_BASE_INDEX + TIA_NUM_REGISTER_FILE_WORDS

    TIA_CORE_INSTRUCTION_MEMORY_BASE_INDEX = TIA_CORE_REGISTER_FILE_BOUND_INDEX
    TIA_CORE_INSTRUCTION_MEMORY_BOUND_INDEX = TIA_CORE_INSTRUCTION_MEMORY_BASE_INDEX + TIA_NUM_INSTRUCTION_MEMORY_WORDS

    TIA_CORE_SCRATCHPAD_MEMORY_BASE_INDEX = TIA_CORE_INSTRUCTION_MEMORY_BOUND_INDEX
    var TIA_CORE_SCRATCHPAD_MEMORY_BOUND_INDEX:Int = 0
    if (TIA_HAS_SCRATCHPAD) TIA_CORE_SCRATCHPAD_MEMORY_BOUND_INDEX = TIA_CORE_SCRATCHPAD_MEMORY_BASE_INDEX + TIA_NUM_SCRATCHPAD_WORDS
    else TIA_CORE_SCRATCHPAD_MEMORY_BOUND_INDEX = TIA_CORE_SCRATCHPAD_MEMORY_BASE_INDEX

    // Core address space size.
    TIA_NUM_CORE_ADDRESS_SPACE_WORDS = TIA_NUM_CORE_MONITOR_WORDS
    + TIA_NUM_CORE_PERFORMANCE_COUNTERS
    + TIA_NUM_REGISTER_FILE_WORDS
    + TIA_NUM_INSTRUCTION_MEMORY_WORDS
    + TIA_NUM_SCRATCHPAD_WORDS

    // --- Interconnect ---

    // Router memory words.
    var TIA_ROUTER_SETTING_MEMORY_WORDS:Int = 0
    if(TIA_SOFTWARE_ROUTER) TIA_ROUTER_SETTING_MEMORY_WORDS = 0
    else if (TIA_SWITCH_ROUTER) TIA_ROUTER_SETTING_MEMORY_WORDS = 1 + TIA_NUM_PHYSICAL_PLANES
    else TIA_ROUTER_SETTING_MEMORY_WORDS = 0

    // Physical plane index width.
    TIA_PHYSICAL_PLANE_INDEX_WIDTH = log2Ceil(TIA_NUM_PHYSICAL_PLANES) + 1

    // --------------  Update Instructions Structure
    vi_r = new fieldRange(0,0)
    op_r = nextFieldRange(TIA_OP_WIDTH,vi_r)
    st_r = nextFieldRange(TIA_ST_WIDTH,op_r)
    si_r = nextFieldRange(TIA_SI_WIDTH ,st_r)
    dt_r = nextFieldRange(TIA_DT_WIDTH,si_r)
    di_r = nextFieldRange(TIA_DI_WIDTH,dt_r)
    oci_r = nextFieldRange(TIA_OCI_WIDTH,di_r)
    oct_r = nextFieldRange(TIA_OCT_WIDTH,oci_r)
    icd_r = nextFieldRange(TIA_ICD_WIDTH,oct_r)
    pum_r = nextFieldRange(TIA_PUM_WIDTH,icd_r)
    // ------ non immediate ------
    ptm_r = nextFieldRange(TIA_PTM_WIDTH,pum_r)
    ici_r = nextFieldRange(TIA_ICI_WIDTH,ptm_r)
    ictb_r = nextFieldRange(TIA_ICTB_WIDTH,ici_r)
    ictv_r = nextFieldRange(TIA_ICTV_WIDTH,ictb_r)
    immediate_r = nextFieldRange(TIA_IMMEDIATE_WIDTH,ictv_r)
    padding_r = nextFieldRange(TIA_MM_INSTRUCTION_PADDING_WIDTH,immediate_r)

  }
}
