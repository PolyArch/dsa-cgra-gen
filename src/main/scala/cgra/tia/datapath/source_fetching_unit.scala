package cgra.tia.datapath

import chisel3._
import chisel3.util._
import cgra.tia.parameters.derived_parameters._

class source_fetching_unit extends Module{
  val io = IO(
    new Bundle{
      val st = Input(UInt(TIA_ST_WIDTH.W))
      val si = Input(UInt(TIA_SI_WIDTH.W))
      val immediate = Input(UInt(TIA_IMMEDIATE_WIDTH.W))
      val input_channel_data = Input(Vec(TIA_NUM_INPUT_CHANNELS,UInt(TIA_WORD_WIDTH.W)))
      val register_read_indexes = Output(Vec(TIA_NUM_SOURCE,UInt(TIA_REGISTER_INDEX_WIDTH.W)))
      val register_read_data = Input(Vec(TIA_NUM_SOURCE,UInt(TIA_WORD_WIDTH.W)))
      val operands =  Output(Vec(TIA_NUM_SOURCE,UInt(TIA_WORD_WIDTH.W)))
    }
  )

  val source_types = Wire(Vec(TIA_NUM_SOURCE,UInt(TIA_SINGLE_ST_WIDTH.W)))
  val source_indices = Wire(Vec(TIA_NUM_SOURCE,UInt(TIA_SINGLE_SI_WIDTH.W)))

  for (i <- 0 until TIA_NUM_SOURCE){
    source_types(i) := io.st(TIA_SINGLE_ST_WIDTH *(i+1)-1,TIA_SINGLE_ST_WIDTH*i)
    source_indices(i) := io.si(TIA_SINGLE_SI_WIDTH *(i+1)-1,TIA_SINGLE_SI_WIDTH*i)
  }

  for (i <- 0 until TIA_NUM_SOURCE){

    io.register_read_indexes(i) := 0.U
    io.operands(i) := 0.U

    switch(source_types(i)){
      is(TIA_SOURCE_TYPE_NULL.U){
        io.register_read_indexes(i) := 0.U
        io.operands(i) := 0.U
      }
      is(TIA_SOURCE_TYPE_IMMEDIATE.U){
        io.register_read_indexes(i) := 0.U
        io.operands(i) := io.immediate
      }
      is(TIA_SOURCE_TYPE_CHANNEL.U){
        io.register_read_indexes(i) := 0.U
        io.operands(i) := io.input_channel_data(source_indices(i))
      }
      is(TIA_SOURCE_TYPE_REGISTER.U){
        io.register_read_indexes(i) := source_indices(i)
        io.operands(i) := io.register_read_data(i)
      }
    }
  }
}
object sfuDriver extends App
{
  chisel3.Driver.execute(args, () => new source_fetching_unit)
}