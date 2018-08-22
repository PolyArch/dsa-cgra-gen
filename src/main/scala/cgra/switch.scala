package cgraexplorationframework.simplechip.cgra

import chisel3._
import cgraexplorationframework.simplechip.tile._
import cgraexplorationframework.simplechip.config.Parameters
import chisel3.util._

class Switch(
              numInput        : Int,
              numOutput       : Int,
              inputDirection  : Array[Double],
              outputDirection : Array[Double],
              decomp          : Int
            ) extends FabricModule //with FabricModuleIO
{

  override val datawidthModule: Int = CGRAdataWidth
  override val numModuleInput:Int = numInput
  override val numModuleOutput: Int = numOutput
  override val inputMoudleDirection: Array[Double] = inputDirection
  override val outputModuleDirection: Array[Double] = outputDirection
  override lazy val numDecomp: Int = decomp

  io.output_ports(0).bits := io.input_ports(0).bits
  io.input_ports(0).ready := false.B
  io.output_ports(0).valid := false.B

}

object SwitchDriver extends App {
  chisel3.Driver.execute(args, () => new Switch(1,1,Array(0.0),Array(0.0),2))
}