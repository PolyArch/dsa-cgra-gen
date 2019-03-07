package cgra.fabric.Shared_PE.mmio

import cgra.IO.mmio_if
import cgra.entity.Entity
import cgra.fabric.Shared_PE.parameters.derived_parameters
import chisel3._

class core_mapper(p:Entity) extends Module with derived_parameters{
  parameter_update(p)
  val io =  IO(new Bundle{
    val host_interface = mmio_if(TIA_MMIO_INDEX_WIDTH,TIA_MMIO_DATA_WIDTH)
    val monitor_interface = Flipped( mmio_if(TIA_MMIO_INDEX_WIDTH,TIA_MMIO_DATA_WIDTH))
    val performance_counters_interface = Flipped( mmio_if(TIA_MMIO_INDEX_WIDTH,TIA_MMIO_DATA_WIDTH))
    val register_file_interface = Flipped( mmio_if(TIA_MMIO_INDEX_WIDTH,TIA_MMIO_DATA_WIDTH))
    val instruction_memory_interface = Flipped( mmio_if(TIA_MMIO_INDEX_WIDTH,TIA_MMIO_DATA_WIDTH))
    val scratchpad_memory_interface = Flipped( mmio_if(TIA_MMIO_INDEX_WIDTH,TIA_MMIO_DATA_WIDTH))
  })
  
  val host_interface:mmio_if = io.host_interface
  val monitor_interface:mmio_if = io.monitor_interface
  val performance_counters_interface:mmio_if = io.performance_counters_interface
  val register_file_interface:mmio_if = io.register_file_interface
  val instruction_memory_interface:mmio_if = io.instruction_memory_interface
  val scratchpad_memory_interface:mmio_if = io.scratchpad_memory_interface

  // default when no read req
  host_interface.read_ack := 0.U
  host_interface.read_data := 0.U
  monitor_interface.read_req := 0.U
  monitor_interface.read_index := 0.U
  performance_counters_interface.read_req := 0.U
  performance_counters_interface.read_index := 0.U
  register_file_interface.read_req := 0.U
  register_file_interface.read_index := 0.U
  instruction_memory_interface.read_req := 0.U
  instruction_memory_interface.read_index := 0.U
  scratchpad_memory_interface.read_req := 0.U
  scratchpad_memory_interface.read_index := 0.U
  
  // default when no write req
  host_interface.write_ack := 0.U
  monitor_interface.write_req := 0.U
  monitor_interface.write_index := 0.U
  monitor_interface.write_data := 0.U
  performance_counters_interface.write_req := 0.U
  performance_counters_interface.write_index := 0.U
  performance_counters_interface.write_data := 0.U
  register_file_interface.write_req := 0.U
  register_file_interface.write_index := 0.U
  register_file_interface.write_data := 0.U
  instruction_memory_interface.write_req := 0.U
  instruction_memory_interface.write_index := 0.U
  instruction_memory_interface.write_data := 0.U
  scratchpad_memory_interface.write_req := 0.U
  scratchpad_memory_interface.write_index := 0.U
  scratchpad_memory_interface.write_data := 0.U

  // when read request
  when(io.host_interface.read_req){
    when(host_interface.read_index < TIA_CORE_MONITOR_BOUND_INDEX.U){
      monitor_interface.read_req := host_interface.read_req
      monitor_interface.read_index := host_interface.read_index
      host_interface.read_ack := monitor_interface.read_ack
      host_interface.read_data := monitor_interface.read_data
    }
    when(host_interface.read_index >= TIA_CORE_PERFORMANCE_COUNTERS_BASE_INDEX.U
      && host_interface.read_index < TIA_CORE_PERFORMANCE_COUNTERS_BOUND_INDEX.U){
      performance_counters_interface.read_req := host_interface.read_req
      performance_counters_interface.read_index := host_interface.read_index - TIA_CORE_PERFORMANCE_COUNTERS_BASE_INDEX.U
      host_interface.read_ack := performance_counters_interface.read_ack
      host_interface.read_data := performance_counters_interface.read_data
    }
    when(host_interface.read_index >= TIA_CORE_REGISTER_FILE_BASE_INDEX.U
      && host_interface.read_index < TIA_CORE_REGISTER_FILE_BOUND_INDEX.U){
      register_file_interface.read_req := host_interface.read_req
      register_file_interface.read_index := host_interface.read_index - TIA_CORE_REGISTER_FILE_BASE_INDEX.U
      host_interface.read_ack := register_file_interface.read_ack
      host_interface.read_data := register_file_interface.read_data
    }
    when(host_interface.read_index >= TIA_CORE_INSTRUCTION_MEMORY_BASE_INDEX.U
      && host_interface.read_index < TIA_CORE_INSTRUCTION_MEMORY_BOUND_INDEX.U){
      instruction_memory_interface.read_req := host_interface.read_req
      instruction_memory_interface.read_index := host_interface.read_index
      - TIA_CORE_INSTRUCTION_MEMORY_BASE_INDEX
      host_interface.read_ack := instruction_memory_interface.read_ack
      host_interface.read_data := instruction_memory_interface.read_data
    }
    when(host_interface.read_index >= TIA_CORE_SCRATCHPAD_MEMORY_BASE_INDEX.U
      && host_interface.read_index < TIA_CORE_SCRATCHPAD_MEMORY_BOUND_INDEX.U){
      scratchpad_memory_interface.read_req := host_interface.read_req
      scratchpad_memory_interface.read_index := host_interface.read_index
      - TIA_CORE_SCRATCHPAD_MEMORY_BOUND_INDEX
      host_interface.read_ack := scratchpad_memory_interface.read_ack
      host_interface.read_data := scratchpad_memory_interface.read_data
    }
  }

  // when write request
  when(host_interface.write_req){
    when(host_interface.write_index < TIA_CORE_MONITOR_BOUND_INDEX.U){
      monitor_interface.write_req := host_interface.write_req
      monitor_interface.write_index := host_interface.write_index
      monitor_interface.write_data := host_interface.write_data
      host_interface.write_ack := monitor_interface.write_ack
    }
    when(host_interface.write_index >= TIA_CORE_PERFORMANCE_COUNTERS_BASE_INDEX.U
      && host_interface.write_index < TIA_CORE_PERFORMANCE_COUNTERS_BOUND_INDEX.U){
      performance_counters_interface.write_req := host_interface.write_req
      performance_counters_interface.write_index := host_interface.write_index
      - TIA_CORE_PERFORMANCE_COUNTERS_BASE_INDEX.U
      performance_counters_interface.write_data := host_interface.write_data
      host_interface.write_ack := performance_counters_interface.write_ack
    }
    when(host_interface.write_index >= TIA_CORE_REGISTER_FILE_BASE_INDEX.U
      && host_interface.write_index < TIA_CORE_REGISTER_FILE_BOUND_INDEX.U){
      register_file_interface.write_req := host_interface.write_req
      register_file_interface.write_index := host_interface.write_index
      - TIA_CORE_REGISTER_FILE_BASE_INDEX.U
      register_file_interface.write_data := host_interface.write_data
      host_interface.write_ack := register_file_interface.write_ack
    }
    when(host_interface.write_index >= TIA_CORE_INSTRUCTION_MEMORY_BASE_INDEX.U
      && host_interface.write_index < TIA_CORE_INSTRUCTION_MEMORY_BOUND_INDEX.U){
      instruction_memory_interface.write_req := host_interface.write_req
      instruction_memory_interface.write_index := host_interface.write_index
      - TIA_CORE_INSTRUCTION_MEMORY_BASE_INDEX.U
      instruction_memory_interface.write_data := host_interface.write_data
      host_interface.write_ack := instruction_memory_interface.write_ack
    }
    when(host_interface.write_index >= TIA_CORE_SCRATCHPAD_MEMORY_BASE_INDEX.U
      && host_interface.write_index < TIA_CORE_SCRATCHPAD_MEMORY_BOUND_INDEX.U){
      scratchpad_memory_interface.write_req := host_interface.write_req
      scratchpad_memory_interface.write_index := host_interface.write_index
      - TIA_CORE_SCRATCHPAD_MEMORY_BOUND_INDEX.U
      scratchpad_memory_interface.write_data := host_interface.write_data
      host_interface.write_ack := scratchpad_memory_interface.write_ack
    }
  }
}
/*
object coreM_Driver extends App {
  chisel3.Driver.execute(args, () => new core_mapper)
}
*/