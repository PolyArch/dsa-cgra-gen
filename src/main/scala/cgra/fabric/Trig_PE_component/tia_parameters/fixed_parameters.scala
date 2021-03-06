// See README.md for license details.

package cgra.fabric.Trig_PE_component.tia_parameters

//import cgra.fabric.Trig_PE_component.common.Instructions.Instructions
import chisel3.util.log2Ceil

object fixed_parameters {

  // Functional Unit
  val TIA_NUM_FU_TYPES:Int = 7
  val ALU:Int = 0
  val SM:Int = 1
  val IMU:Int = 2
  val FCCU:Int = 3
  val FASU:Int = 4
  val FMU:Int = 5
  val FMAU:Int = 6

  // Source types.
  val TIA_NUM_SOURCE = 3
  val TIA_NUM_SOURCE_TYPES = 4
  val TIA_SOURCE_TYPE_NULL = 0
  val TIA_SOURCE_TYPE_IMMEDIATE = 1
  val TIA_SOURCE_TYPE_CHANNEL = 2
  val TIA_SOURCE_TYPE_REGISTER = 3

  // Destination types.
  val TIA_NUM_OPERANDS = 3
  val TIA_NUM_DESTINATION_TYPES = 4
  val TIA_DESTINATION_TYPE_NULL = 0
  val TIA_DESTINATION_TYPE_CHANNEL = 1
  val TIA_DESTINATION_TYPE_REGISTER = 2
  val TIA_DESTINATION_TYPE_PREDICATE = 3

  // --- System Interface ---

  // System control registers.
  val TIA_NUM_SYSTEM_CONTROL_REGISTERS = 4
  val TIA_RESET_REGISTER_INDEX = 0
  val TIA_ENABLE_REGISTER_INDEX = 1
  val TIA_EXECUTE_REGISTER_INDEX = 2
  val TIA_HALTED_REGISTER_INDEX = 3

  // PE monitor registers.
  val TIA_NUM_CORE_MONITOR_REGISTERS_IF_ENABLED = 2
  val TIA_PE_MONITOR_HALTED_INDEX = 0
  val TIA_PE_MONITOR_PREDICATES_INDEX = 1

  // PE performance counters.
  val TIA_NUM_CORE_PERFORMANCE_COUNTERS_IF_ENABLED = 13
  val TIA_PE_EXECUTED_CYCLES_COUNTER_INDEX = 0
  val TIA_PE_INSTRUCTIONS_ISSUED_COUNTER_INDEX = 1
  val TIA_PE_INSTRUCTIONS_RETIRED_COUNTER_INDEX = 2
  val TIA_PE_INSTRUCTIONS_QUASHED_COUNTER_INDEX = 3
  val TIA_PE_UNTRIGGERED_CYCLES_COUNTER_INDEX = 4
  val TIA_PE_BUBBLES_COUNTER_INDEX = 5
  val TIA_PE_CONTROL_HAZARD_BUBBLES_COUNTER_INDEX = 6
  val TIA_PE_DATA_HAZARD_BUBBLES_COUNTER_INDEX = 7
  val TIA_PE_PREDICATE_PREDICTION_HITS_COUNTER_INDEX = 8
  val TIA_PE_PREDICATE_PREDICTION_MISSES_COUNTER_INDEX = 9
  val TIA_PE_TRIGGER_OVERRIDES_COUNTER_INDEX = 10
  val TIA_PE_MULTI_CYCLE_INSTRUCTION_STALLS_INDEX = 11
  val TIA_PE_PIPELINE_LATENCY_INDEX = 12

  // --- MMIO ---

  // MMIO vals.
  val TIA_MMIO_DATA_WIDTH = 32
  val TIA_MMIO_INDEX_WIDTH:Int = 32 - log2Ceil(32 / 8)

  // AXI4-Lite vals.
  val AXI4_LITE_DATA_WIDTH = 32
  val AXI4_LITE_ADDRESS_WIDTH = 32
}
