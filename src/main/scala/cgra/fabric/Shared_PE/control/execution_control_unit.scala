package cgra.fabric.Shared_PE.control

import cgra.entity.Entity
import cgra.fabric.Shared_PE.parameters.derived_parameters
import chisel3._
import chisel3.util._

class execution_control_unit(p:Entity) extends Module with derived_parameters{
  parameter_update(p)
  val io = IO(
    new Bundle{
      val enable = Input(Bool())
      val execute = Input(Bool())
      val opcode = Input(UInt(TIA_OP_WIDTH.W))
      val input_channel_quiescent_status = Input(UInt(TIA_NUM_INPUT_CHANNELS.W))
      val output_channel_quiescent_status = Input(UInt(TIA_NUM_OUTPUT_CHANNELS.W))
      val internal_reset = Output(Bool())
      val internal_enable = Output(Bool())
      val halted = Output(Bool())
      val channels_quiescent = Output(Bool())
    }
  )

  val halted = Wire(Bool())

  // default: not halted, channels not full
  halted := false.B
  io.channels_quiescent := false.B

  // Pass to internal
  io.internal_reset := reset
  io.internal_enable := (io.enable & io.execute) & halted

  // not halted unless by opcode
  when(reset.toBool()){
    halted := false.B
  }.elsewhen(io.enable && io.execute){
    when(io.opcode === TIA_OP_HALT.U){
      halted := true.B
    }
  }

  // pass quiescent status to output
  when(reset.toBool()){
    io.channels_quiescent := false.B
  }.elsewhen(io.enable){
    io.channels_quiescent := Cat(io.input_channel_quiescent_status,io.output_channel_quiescent_status).andR()
  }

  // output halted status
  io.halted <> halted

}
/*
object execControlDriver extends App
{
  chisel3.Driver.execute(args, () => new execution_control_unit)
}
*/