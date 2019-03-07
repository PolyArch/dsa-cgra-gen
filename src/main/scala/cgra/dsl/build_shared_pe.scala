package cgra.dsl

import cgra.build.Build
import cgra.fabric.Shared_PE.common.Instructions.Instructions
import cgra.fabric.Shared_PE.core.Shared_PE

object build_shared_pe extends Build
  with Instructions{
  val shared_pe = Shared_PE()

  // --------------  Component Config ---------
  shared_pe have("has_core_monitor",true)
  shared_pe have("has_core_performance_counters",true)
  shared_pe have("has_multiplier",true)
  shared_pe have("has_software_router",true)
  shared_pe have("has_switch_router",true)
  shared_pe have("has_scratchpad",true)


  // Require all necessary parameters is defined
  shared_pe have("word_width",32)
  shared_pe have("num_registers",8)
  shared_pe have("spm_depth",1024)
  // Memory-mapped instruction representation.
  shared_pe have("mm_instruction_width",128)
  // Maximum number of instructions per PE.
  shared_pe have("max_num_instructions",16)
  // Number of input and output channels.
  shared_pe have("num_input_channels",4)
  shared_pe have("num_output_channels",4)

  // Instruction immediates.
  shared_pe have("immediate_width",32)
  // Number of predicates to store state.
  shared_pe have("num_predicates",8)
  // Tags for inter-PE/ME channels.
  shared_pe have("num_tags",3)
  // Maximum number of input channels upon which an instruction can depend.
  shared_pe have("max_num_input_channels_to_check",2)

  // --- Interconnect ---
  // Number of physical planes.
  shared_pe have("num_physical_planes",1)
  // Generic channel FIFO depth.
  shared_pe have("channel_buffer_fifo_depth",2)
  // Link buffer FIFO depth.
  shared_pe have("link_buffer_fifo_depth",2)
  // Memory link buffer FIFO depth.
  shared_pe have("memory_link_buffer_fifo_depth",4)
  // --- Memory ---
  shared_pe have("num_data_memory_words",32786)
  // --- Scratchpad ---
  shared_pe have("num_scratchpad_words_if_enabled",512)

  // Add instruction
  shared_pe have("inst_list",basic_insts)

  // Generate IR
  shared_pe forsyn;
  val fileName:String = "/home/sihao/ss-stack/ss-cgra-gen/sample-IR/"+ shared_pe.entity_type +".xml"
  saveXMLFile(shared_pe,fileName)

  // Generate Verilog Output
  val shared_pe_entity = load_Entity_fromXML(loadXMLFile(fileName))
  instantiate(shared_pe_entity)
}
