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

  val SelReg = RegInit(Vec(Seq.fill(numModuleOutput)(0.U(log2Ceil(numModuleOutput)))))

  val MuxNBitsMatrix = new Array[Array[(chisel3.core.UInt, chisel3.core.UInt)]](numModuleInput)
  for (inPort <- 0 until numModuleInput ) {
    MuxNBitsArray(inPort) = inPort.U -> io.input_ports(inPort).bits
  }
  val MuxNValidArray = new Array[(chisel3.core.UInt, chisel3.core.Bool)](numModuleInput)
  for (inPort <- 0 until numModuleInput ) {
    MuxNValidArray(inPort) = inPort.U -> io.input_ports(inPort).valid
  }

  if(decomp>1){

  }

  for(outPort <- 0 until numModuleOutput){
    io.output_ports(0).bits := MuxLookup(SelReg(outPort),0.U,MuxNBitsArray)
    io.output_ports(0).valid := MuxLookup(SelReg(outPort),0.U,MuxNValidArray)
  }

//  val SelReg = Vec(numOutput,RegInit(0.U(log2Ceil(numOutput).W)))

  io.output_ports(0).bits := io.input_ports(0).bits
  io.input_ports(0).ready := false.B
  io.output_ports(0).valid := false.B



}

object SwitchDriver extends App {
  chisel3.Driver.execute(args, () => new Switch(1,1,Array(0.0),Array(0.0),2))
}