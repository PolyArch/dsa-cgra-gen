// See README.md for license details.

package cgra

import chisel3._
import chisel3.util._
import encode.configEncode
import encode.configSwitchContentEncode._
import tile._
import tile.Constant._

import scala.collection.mutable.Map


class Switch(
              row             :Int,
              col             :Int,
              numInput        : Int,
              numOutput       : Int,
              inputLocation  : Array[(Int,Int)],
              outputLocation : Array[(Int,Int)],
              deComp          : Int,
              muxDirMatrix    : Array[Array[Array[Boolean]]], //muxDirMatrix(outPort)(decompSec)(inPut)
              configsFromPort : Int,
              configsToPort   : Int
            ) extends FabricModule
  with configEncode
{

  //Override value
  override val datawidthModule: Int = fabricDataWidth
  override lazy val numModuleInput:Int = numInput
  override lazy val numModuleOutput: Int = numOutput
  override lazy val inputMoudleLocation: Array[(Int,Int)] = inputLocation
  override lazy val outputModuleLocation: Array[(Int,Int)] = outputLocation
  override lazy val numDecomp: Int = deComp
  override val configsModuleFromPort: Int = configsFromPort
  override val configsModuleToPort: Int = configsToPort

  // Requirement check
  require(numModuleOutput==muxDirMatrix.length)
  require(configsModuleFromPort!=configsModuleToPort,s"from ${configsModuleFromPort} - " +
    s"to ${configsModuleToPort}")
  for(subNet <- 0 until numDecomp){
    for (outPort <-0 until this.numModuleOutput){
      require(numModuleInput==muxDirMatrix(outPort)(subNet).length,"Mux select Matrix size mismatch")
      require(muxDirMatrix(outPort)(subNet).exists(p=>p),
        s"each output location need to have one input,Output $outPort Sec $subNet")
    }
    for (inPort <- 0 until this.numModuleInput){
      require(numModuleOutput==muxDirMatrix.map{_(subNet)(inPort)}.length,"Mux select Matrix size mismatch")
      require(muxDirMatrix.map{_(subNet)(inPort)}.exists(p=>p),
        s"each input location need to have one output,Input $inPort Sec $subNet")
    }
  }

  // Build Config Port
  val configFromPort:UInt = Wire(UInt(datawidthModule.W))
  configFromPort := io.input_ports.zipWithIndex.filter(iP => {
    iP._2%numModuleInput == configsModuleFromPort
  }).map(_._1.bits).reverse.reduceRight(Cat(_,_))
  val configRowBits = configFromPort(rowBits.high,rowBits.low)
  val configColBits = configFromPort(colBits.high,colBits.low)
  val configHeaderBits = configFromPort(configHeader.high,configHeader.low)
  val configSectionBits = configFromPort(configSection.high,configSection.low)


  // Select Register definition
  val SelReg = new Array[UInt](numModuleOutput * numDecomp)
  val SelRegWidth = new Array[(Int,Int,Int)](numModuleOutput * numDecomp)

  for(outPort <- 0 until numModuleOutput;subNet <- 0 until numDecomp){
    val numMuxIn: Int = muxDirMatrix(outPort)(subNet).count(p => p)
    SelReg(numModuleOutput * subNet + outPort) =
      RegInit(0.U(log2Ceil(numMuxIn + 1).W))
    SelRegWidth(numModuleOutput * subNet + outPort) =
      (outPort,subNet,log2Ceil(numMuxIn + 1))

  }
  val SwitchMuxEncode : Map[(Int,Int),MuxEncode]=
    switchContentEncode(SelRegWidth)
  when(io.cfg_mode &&
    configHeaderBits === SwitchType.U(configHeader.bitsLen.W) &&
    row.U(rowBits.bitsLen.W) === configRowBits &&
    col.U(colBits.bitsLen.W) === configColBits)
  {
    for(outPort <- 0 until numModuleOutput;subNet <- 0 until numDecomp) {
      val muxEncode = SwitchMuxEncode((outPort,subNet))
      val configSec = muxEncode.configBitSec
      when(configSec.U(configSection.bitsLen.W) === configSectionBits){
        SelReg(numModuleOutput * subNet + outPort) := configFromPort(muxEncode.highBits,muxEncode.lowBit)
      }
    }
  }

  // Output Register definition
  val OutputBitsReg = RegInit(VecInit(Seq.fill(numModuleOutput * numDecomp)(0.U(decompDataWidth.W))))
  val OutputValidReg = RegInit(VecInit(Seq.fill(numModuleOutput * numDecomp)(false.B)))

  // Output Register <-> output_port
  for (subNet <- 0 until numDecomp;outPort <- 0 until numModuleOutput){
    if(outPort != configsModuleToPort || configsModuleToPort == -1){
      io.output_ports(numModuleOutput * subNet + outPort).valid <>
        Mux(io.cfg_mode,
          false.B,
          OutputValidReg(numModuleOutput * subNet + outPort))
      io.output_ports(numModuleOutput * subNet + outPort).bits <>
        Mux(io.cfg_mode,
          0.U,
          OutputBitsReg(numModuleOutput * subNet + outPort))
    }else{
      io.output_ports(numModuleOutput * subNet + outPort).valid <>
        Mux(io.cfg_mode,
          io.input_ports(numModuleInput * subNet + configsModuleFromPort).valid,
          OutputValidReg(numModuleOutput * subNet + outPort))
      io.output_ports(numModuleOutput * subNet + outPort).bits <>
        Mux(io.cfg_mode,
          io.input_ports(numModuleInput * subNet + configsModuleFromPort).bits,
          OutputBitsReg(numModuleOutput * subNet + outPort))
    }
  }

  for (subNet <- 0 until numDecomp)
  {
    val MuxNBitsMatrix = new Array[Array[(chisel3.core.UInt, chisel3.core.UInt)]](numModuleOutput)
    val MuxNValidMatrix = new Array[Array[(chisel3.core.UInt, chisel3.core.Bool)]](numModuleOutput)

    for(outPort <- 0 until numModuleOutput){
      val numMuxIn: Int = {
        if (numDecomp == 1) {
          muxDirMatrix(outPort)(subNet).count(p => p)
        }
        else {
          muxDirMatrix(outPort)(subNet).count(p => p) + 1
        }
      }

      MuxNBitsMatrix(outPort) = new Array[(UInt, UInt)](numMuxIn)
      MuxNValidMatrix(outPort) = new Array[(UInt, Bool)](numMuxIn)

      val currInDir = muxDirMatrix(outPort)(subNet).zipWithIndex.filter(_._1 == true).map(_._2)

      for (selSig <- 0 until muxDirMatrix(outPort)(subNet).count(p=>p)){
        require(MuxNBitsMatrix(outPort).length == numMuxIn)
        MuxNBitsMatrix(outPort)(selSig) =  selSig.U ->
          io.input_ports(numModuleInput * subNet + currInDir(selSig)).bits(decompDataWidth-1,0)
        MuxNValidMatrix(outPort)(selSig) = selSig.U ->
          io.input_ports(numModuleInput * subNet + currInDir(selSig)).valid
      }

      if(numDecomp > 1){
        val selSig = muxDirMatrix(outPort)(subNet).count(p => p)
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
    var readyReduce = true.B
    for(outPort <- 0 until numModuleOutput) {
      if (muxDirMatrix(outPort)(subNet)(inPort)){
        readyReduce = readyReduce & io.output_ports(numModuleOutput * subNet + outPort).ready
      }
    }
    io.input_ports(numModuleInput * subNet + inPort).ready := readyReduce
  }
}

// Instantiate

object SwitchDriver extends App {
  chisel3.Driver.execute(args, () =>
    new Switch(1,2,
      4,4,
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
        Array(Array(true,false,false,true),Array(true, true, true, false),Array(false, true, false,true ),Array(true, false, true, false))),
      1,2
    )
  )
}
