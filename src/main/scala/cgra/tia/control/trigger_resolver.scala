package cgra.tia.control

import chisel3._
import chisel3.util._
import cgra.tia.parameters.derived_parameters._

class trigger_resolver extends Module
  {

  val io = IO(
    new Bundle {
      val trigger = Input(new trigger_t)
      val predicates = Input(UInt(TIA_NUM_PREDICATES.W))
      val input_channel_empty_status = Input(UInt(TIA_NUM_INPUT_CHANNELS.W))
      val input_channel_tags = Input(Vec(TIA_NUM_INPUT_CHANNELS,UInt(TIA_TAG_WIDTH.W)))
      val output_channel_full_status = Input(UInt(TIA_NUM_OUTPUT_CHANNELS.W))
      val valid = Output(Bool())
    }
  )

  // whether the trigger is valid
  val valid_trigger = Wire(Bool())
  valid_trigger := io.trigger.vi

  // Check the predicate
  val true_ptm = Wire(UInt(TIA_TRUE_PTM_WIDTH.W))
  val false_ptm = Wire(UInt(TIA_FALSE_PTM_WIDTH.W))
  val true_predicates,false_predicates = Wire(UInt(TIA_NUM_PREDICATES.W))
  val valid_predicate_state = Wire(Bool())

  // Check whether the input channel is empty
  val valid_input_channel_empty_status_array = Wire(Vec(TIA_MAX_NUM_INPUT_CHANNELS_TO_CHECK,Bool()))
  val valid_input_channel_empty_status = Wire(Bool())

  // Check whether the tags in needed channel is match
  val valid_input_channel_tags_array = Wire(Vec(TIA_MAX_NUM_INPUT_CHANNELS_TO_CHECK,Bool()))
  val valid_input_channel_tags = Wire(Bool())

  // Check whether output channel is valid for accept a new package
  val valid_output_channel_full_status = Wire(Bool())

  true_ptm := io.trigger.ptm(TIA_PTM_WIDTH-1,TIA_FALSE_PTM_WIDTH)
  false_ptm := io.trigger.ptm(TIA_FALSE_PTM_WIDTH - 1,0)
  true_predicates := io.predicates | (~true_ptm).asUInt()
  false_predicates := (~io.predicates).asUInt() | (~false_ptm).asUInt()
  valid_predicate_state := Cat(true_predicates, false_predicates).andR()

  // Check whether input channel is empty and whether the tags are match
  for(i <- 0 until TIA_MAX_NUM_INPUT_CHANNELS_TO_CHECK){
    //get the channel number (start from 1, 0 means no need to check or dont need input from channel)
    val index_channel_to_check_n:UInt =
      io.trigger.ici(TIA_SINGLE_ICI_WIDTH * (i + 1) - 1,
        TIA_SINGLE_ICI_WIDTH * i)

    when(index_channel_to_check_n =/= 0.U){
      // get channel to be checked, channel numbered from 1, so when refer it, we should minus 1
      val input_channel_to_check_i = index_channel_to_check_n - 1.U

      // ------- Check the channel empty -------
      // check whether the channel needed is empty
      when(!io.input_channel_empty_status(input_channel_to_check_i)){
        valid_input_channel_empty_status_array(i) := 1.U
      }.otherwise{
        valid_input_channel_empty_status_array(i) := 0.U
      }

      // ------- Check the check the trigger matched -------
      // get the tags to check
      val tag_to_check_in_trigger = io.trigger.ictv(TIA_TAG_WIDTH * (i + 1) - 1,
        TIA_TAG_WIDTH * i)
      // check whether the channel head tags is matched
      when(io.input_channel_tags(input_channel_to_check_i) === tag_to_check_in_trigger){
        valid_input_channel_tags_array(i) := io.trigger.ictb(i)
      }.otherwise{
        valid_input_channel_tags_array(i) := ~io.trigger.ictb(i)
      }
    }.otherwise{
      // No need to check (check channel number == 0)
      valid_input_channel_empty_status_array(i) := true.B
      valid_input_channel_tags_array(i) := true.B
    }
  }

  // All needed input channel should be empty (data have arrive)
  valid_input_channel_empty_status := valid_input_channel_empty_status_array.asUInt().andR()
  valid_input_channel_tags := valid_input_channel_tags_array.asUInt().andR()

  // Output Channel and Channels that are full already should be different
  valid_output_channel_full_status := (io.trigger.oci & io.output_channel_full_status) === 0.U

  io.valid := valid_trigger & valid_predicate_state & valid_input_channel_empty_status &
    valid_input_channel_tags & valid_output_channel_full_status

}



object trigger_resolver_Driver extends App
{
  chisel3.Driver.execute(args, () => new trigger_resolver)
}