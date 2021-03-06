package cgra.fabric.Trig_PE_component.control


import cgra.fabric.Trig_PE_component.tia_parameters.derived_parameters._
import cgra.fabric.Trig_PE_component.tia_parameters.fixed_parameters._
import chisel3._

class pessimistic_one_stage_input_channel_empty_status_updater extends Module {
  val io = IO(new Bundle{
    val input_channel_empty_status = Input(UInt(TIA_NUM_INPUT_CHANNELS.W))
    val downstream_icd = Input(UInt(TIA_ICD_WIDTH.W))
    val updated_input_channel_empty_status = Output(UInt(TIA_NUM_INPUT_CHANNELS.W))
  })
  io.updated_input_channel_empty_status := io.input_channel_empty_status | io.downstream_icd
}

class pessimistic_two_stage_output_channel_full_status_updater extends Module {
  val io = IO(new Bundle{
    val output_channel_full_status = Input(UInt(TIA_NUM_OUTPUT_CHANNELS.W))
    val first_downstream_oci = Input(UInt(TIA_OCI_WIDTH.W))
    val second_downstream_oci = Input(UInt(TIA_OCI_WIDTH.W))
    val updated_output_channel_full_status = Output(UInt(TIA_NUM_OUTPUT_CHANNELS.W))
  })
  io.updated_output_channel_full_status := io.output_channel_full_status | io.first_downstream_oci | io.second_downstream_oci
}
