package cgraexplorationframework.simplechip.cgra

import chisel3._
import chisel3.util._
import cgraexplorationframework.simplechip.tile._

class Switch(
              numInput        : Int,
              numOutput       : Int,
              inputDirection  : Array[(Int,Int)],
              outputDirection : Array[(Int,Int)],
              deComp          : Int,
              muxDirMatrix    : Array[Array[Array[Boolean]]] //muxDirMatrix(outPort)(decompSec)(inPut)
            ) extends FabricModule
{
  //Override value
  override val datawidthModule: Int = fabricDataWidth
  override lazy val numModuleInput:Int = numInput
  override lazy val numModuleOutput: Int = numOutput
  override lazy val inputMoudleDirection: Array[(Int,Int)] = inputDirection
  override lazy val outputModuleDirection: Array[(Int,Int)] = outputDirection
  override lazy val numDecomp: Int = deComp

  // Requirement check
  require(numModuleOutput==muxDirMatrix.length)
  for(subNet <- 0 until numDecomp){
    for (outPort <-0 until this.numModuleOutput){
      require(numModuleInput==muxDirMatrix(outPort)(subNet).length,"Mux select Matrix size mismatch")
      require(muxDirMatrix(outPort)(subNet).exists(p=>p),s"each output direction need to have one input,Output ${outPort} Sec ${subNet}")
    }
    for (inPort <- 0 until this.numModuleInput){
      require(numModuleOutput==muxDirMatrix.map{_(subNet)(inPort)}.length,"Mux select Matrix size mismatch")
      require(muxDirMatrix.map{_(subNet)(inPort)}.exists(p=>p),s"each input direction need to have one output,Input ${inPort} Sec ${subNet}")
    }
  }

  // Select Register definition
  val SelReg = new Array[UInt](numModuleOutput * numDecomp)
  for(outPort <- 0 until numModuleOutput;subNet <- 0 until numDecomp){
    SelReg(numModuleOutput * subNet + outPort) = RegInit(0.U(log2Ceil(numModuleOutput).W))
    when(io.cfg_mode){SelReg(numModuleOutput * subNet + outPort) := io.input_ports(1).bits(log2Ceil(numModuleOutput)-1,0)}
    //TODO: How to update the select register is not defined yet (Instructions related)
  }


  // Output Register definition
  val OutputBitsReg = RegInit(VecInit(Seq.fill(numModuleOutput * numDecomp)(0.U(decompDataWidth.W))))
  val OutputValidReg = RegInit(VecInit(Seq.fill(numModuleOutput * numDecomp)(false.B)))

  // Output Register <-> output_port
  for (subNet <- 0 until numDecomp;outPort <- 0 until numModuleOutput){
    io.output_ports(numModuleOutput * subNet + outPort).valid <>
      OutputValidReg(numModuleOutput * subNet + outPort)
    io.output_ports(numModuleOutput * subNet + outPort).bits <>
      OutputBitsReg(numModuleOutput * subNet + outPort)
  }

  for (subNet <- 0 until numDecomp)
  {
    var MuxNBitsMatrix = new Array[Array[(chisel3.core.UInt, chisel3.core.UInt)]](numModuleOutput)
    var MuxNValidMatrix = new Array[Array[(chisel3.core.UInt, chisel3.core.Bool)]](numModuleOutput)

    for(outPort <- 0 until numModuleOutput){
      var numMuxIn:Int = {
        if (numDecomp == 1){muxDirMatrix(outPort)(subNet).count(p=>p)}
        else{muxDirMatrix(outPort)(subNet).count(p=>p) + 1}
      }

      MuxNBitsMatrix(outPort) = new Array[(UInt, UInt)](numMuxIn)
      MuxNValidMatrix(outPort) = new Array[(UInt, Bool)](numMuxIn)

      var currInDir = muxDirMatrix(outPort)(subNet).zipWithIndex.filter(_._1 == true).map(_._2)

      for (selSig <- 0 until muxDirMatrix(outPort)(subNet).count(p=>p)){
        require(MuxNBitsMatrix(outPort).length == numMuxIn)
        MuxNBitsMatrix(outPort)(selSig) =  selSig.U ->
          io.input_ports(numModuleInput * subNet + currInDir(selSig)).bits(decompDataWidth*(subNet + 1)-1,decompDataWidth*subNet)
        MuxNValidMatrix(outPort)(selSig) = selSig.U ->
          io.input_ports(numModuleInput * subNet + currInDir(selSig)).valid
      }

      if(numDecomp > 1){
        var selSig = muxDirMatrix(outPort)(subNet).count(p=>p)
        if (subNet != 0){
          MuxNBitsMatrix(outPort)(selSig) =  selSig.U -> OutputBitsReg(numModuleOutput * (subNet - 1) + outPort)
          MuxNValidMatrix(outPort)(selSig) = selSig.U -> OutputValidReg(numModuleOutput * (subNet - 1) + outPort)
        }else{
          MuxNBitsMatrix(outPort)(selSig) =  selSig.U -> OutputBitsReg(numModuleOutput * (numDecomp - 1) + outPort)
          MuxNValidMatrix(outPort)(selSig) = selSig.U -> OutputValidReg(numModuleOutput * (numDecomp - 1) + outPort)
        }
      }

      when(io.output_ports(numModuleOutput * subNet + outPort).ready){
        OutputBitsReg(numModuleOutput * subNet + outPort) :=
          MuxLookup(SelReg(numModuleOutput * subNet + outPort),0.U,MuxNBitsMatrix(outPort))
        OutputValidReg(numModuleOutput * subNet + outPort) :=
          MuxLookup(SelReg(numModuleOutput * subNet + outPort),false.B,MuxNValidMatrix(outPort))
      }
    }
  }


  for (inPort <- 0 until numModuleInput;subNet <- 0 until numDecomp){
    var readySum = true.B
    for(outPort <- 0 until numModuleOutput) {
      if (muxDirMatrix(outPort)(subNet)(inPort)){
        readySum = readySum & io.output_ports(numModuleOutput * subNet + outPort).ready
      }
    }
    io.input_ports(numModuleInput * subNet + inPort).ready := readySum
  }
}

object SwitchDriver extends App {
  chisel3.Driver.execute(args, () =>
    new Switch(4,4,
      Array((1,0),(0,1),(-1,0),(0,-1)),
      Array((1,0),(0,1),(-1,0),(0,-1)),
      4,
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