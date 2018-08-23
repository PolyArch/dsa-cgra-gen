package cgraexplorationframework.simplechip.cgra

import chisel3._
import chisel3.util._
import cgraexplorationframework.simplechip.tile._

class Switch(
              numInput        : Int,
              numOutput       : Int,
              inputDirection  : Array[Double],
              outputDirection : Array[Double],
              deComp          : Int,
              muxDirMatrix    : Array[Array[Array[Boolean]]] //muxDirMatrix(outPort)(decompSec)(inPut)
            ) extends FabricModule
{
  //Override value
  override val datawidthModule: Int = fabricDataWidth
  override lazy val numModuleInput:Int = numInput
  override lazy val numModuleOutput: Int = numOutput
  override lazy val inputMoudleDirection: Array[Double] = inputDirection
  override lazy val outputModuleDirection: Array[Double] = outputDirection
  override lazy val numDecomp: Int = deComp

  // Requirement check
  require(numModuleOutput==muxDirMatrix.length)
  for(decomp <- 0 until numDecomp){
    for (outPort <-0 until this.numModuleOutput){
      require(numModuleInput==muxDirMatrix(outPort)(decomp).length,"Mux select Matrix size mismatch")
      require(muxDirMatrix(outPort)(decomp).exists(p=>p),s"each output direction need to have one input,Output ${outPort} Sec ${decomp}")
    }
    for (inPort <- 0 until this.numModuleInput){
      require(numModuleOutput==muxDirMatrix.map{_(decomp)(inPort)}.length,"Mux select Matrix size mismatch")
      require(muxDirMatrix.map{_(decomp)(inPort)}.exists(p=>p),s"each input direction need to have one output,Input ${inPort} Sec ${decomp}")
    }
  }

  // Select Register definition
  val SelReg = new Array[UInt](numModuleOutput * numDecomp)
  for(outPort <- 0 until numModuleOutput;decomp <- 0 until numDecomp){
    SelReg(numModuleOutput * decomp + outPort) = RegInit(0.U(log2Ceil(numModuleOutput).W))
    when(io.cfg_mode){SelReg(numModuleOutput * decomp + outPort) := io.input_ports(1).bits(log2Ceil(numModuleOutput)-1,0)}
    //TODO: How to update the select register is not defined yet (Instructions related)
  }


  // Output Register definition
  val OutputBitsReg = RegInit(VecInit(Seq.fill(numModuleOutput * numDecomp)(0.U(decompDataWidth.W))))
  val OutputValidReg = RegInit(VecInit(Seq.fill(numModuleOutput * numDecomp)(false.B)))

  // Output Register <-> output_port
  for (decomp <- 0 until numDecomp;outPort <- 0 until numModuleOutput){
    io.output_ports(numModuleOutput * decomp + outPort).valid <>
      OutputValidReg(numModuleOutput * decomp + outPort)
    io.output_ports(numModuleOutput * decomp + outPort).bits <>
      OutputBitsReg(numModuleOutput * decomp + outPort)
  }

  for (decomp <- 0 until numDecomp)
  {
    var MuxNBitsMatrix = new Array[Array[(chisel3.core.UInt, chisel3.core.UInt)]](numModuleOutput)
    var MuxNValidMatrix = new Array[Array[(chisel3.core.UInt, chisel3.core.Bool)]](numModuleOutput)

    for(outPort <- 0 until numModuleOutput){
      var numMuxIn:Int = {
        if (numDecomp == 1){muxDirMatrix(outPort)(decomp).count(p=>p)}
        else{muxDirMatrix(outPort)(decomp).count(p=>p) + 1}
      }

      MuxNBitsMatrix(outPort) = new Array[(UInt, UInt)](numMuxIn)
      MuxNValidMatrix(outPort) = new Array[(UInt, Bool)](numMuxIn)

      var currInDir = muxDirMatrix(outPort)(decomp).zipWithIndex.filter(_._1 == true).map(_._2)

      for (selSig <- 0 until muxDirMatrix(outPort)(decomp).count(p=>p)){
        require(MuxNBitsMatrix(outPort).length == numMuxIn)
        MuxNBitsMatrix(outPort)(selSig) =  selSig.U ->
          io.input_ports(numModuleInput * decomp + currInDir(selSig)).bits(decompDataWidth*(decomp + 1)-1,decompDataWidth*decomp)
        MuxNValidMatrix(outPort)(selSig) = selSig.U ->
          io.input_ports(numModuleInput * decomp + currInDir(selSig)).valid
      }

      if(numDecomp > 1){
        var selSig = muxDirMatrix(outPort)(decomp).count(p=>p)
        if (decomp != 0){
          MuxNBitsMatrix(outPort)(selSig) =  selSig.U -> OutputBitsReg(numModuleOutput * (decomp - 1) + outPort)
          MuxNValidMatrix(outPort)(selSig) = selSig.U -> OutputValidReg(numModuleOutput * (decomp - 1) + outPort)
        }else{
          MuxNBitsMatrix(outPort)(selSig) =  selSig.U -> OutputBitsReg(numModuleOutput * (numDecomp - 1) + outPort)
          MuxNValidMatrix(outPort)(selSig) = selSig.U -> OutputValidReg(numModuleOutput * (numDecomp - 1) + outPort)
        }
      }

      when(io.output_ports(numModuleOutput * decomp + outPort).ready){
        OutputBitsReg(numModuleOutput * decomp + outPort) :=
          MuxLookup(SelReg(numModuleOutput * decomp + outPort),0.U,MuxNBitsMatrix(outPort))
        OutputValidReg(numModuleOutput * decomp + outPort) :=
          MuxLookup(SelReg(numModuleOutput * decomp + outPort),false.B,MuxNValidMatrix(outPort))
      }
    }
  }


  for (inPort <- 0 until numModuleInput;decomp <- 0 until numDecomp){
    var readySum = true.B
    for(outPort <- 0 until numModuleOutput) {
      if (muxDirMatrix(outPort)(decomp)(inPort)){
        readySum = readySum & io.output_ports(numModuleOutput * decomp + outPort).ready
      }
    }
    io.input_ports(numModuleInput * decomp + inPort).ready := readySum
  }
}

object SwitchDriver extends App {
  chisel3.Driver.execute(args, () =>
    new Switch(4,4,Array(0.0,90.0,180.0,270.0),Array(0.0,90.0,180.0,270.0),4,
      /*
      Array(
        Array(Array(false,true,false,true)),
        Array(Array(false,true,false,true)),
        Array(Array(true,true,true,true)),
        Array(Array(true,false,false,true)))
      */
      Array(
        Array(Array(false,true,false,true),Array(true, false, true, false),Array(false,true,false,true),Array(true, false, true, false)),
        Array(Array(false,true,false,true),Array(true, false, true, false),Array(true, false, true, false),Array(false,true,false,true)),
        Array(Array(true,true,true,true),Array(false, true, false,true ),Array(true, false, true, false),Array(true, false, true, false)),
        Array(Array(true,false,false,true),Array(true, true, true, false),Array(false, true, false,true ),Array(true, false, true, false)))
    )
  )
}