package cgraexplorationframework.simplechip.tile

import cgraexplorationframework.simplechip.config._
import chisel3._
import chisel3.util._

trait HasFabricParams {
  val fabricDataWidth = 64
  val numFabricInput = 15
  val numFabricOutput = 14
}

trait HasFabricModuleParams extends HasFabricParams
{
  val datawidthModule       : Int
  val numModuleInput        : Int
  val numModuleOutput       : Int
  val inputMoudleDirection  : Array[Double]
  val outputModuleDirection : Array[Double]
  val numDecomp             : Int
  lazy val decompDataWidth       : Int = datawidthModule / numDecomp

  require(numModuleInput==inputMoudleDirection.length)
  require(numModuleOutput==outputModuleDirection.length)
  require(isPow2(fabricDataWidth/numDecomp))
}

abstract class FabricModule  extends Module
  with HasFabricModuleParams{
  lazy val io = IO(new Bundle{
    val input_ports = Vec(numModuleInput * numDecomp,Flipped(DecoupledIO(UInt(datawidthModule.W))))
    val output_ports = Vec(numModuleOutput * numDecomp,DecoupledIO(UInt(datawidthModule.W)))
    val cfg_mode = Input(Bool())
  })
}

abstract class Fabric extends Module
with HasFabricParams{
  lazy val io = IO(
    new Bundle{
      val input_ports = Vec(numFabricInput,Flipped(DecoupledIO(UInt(fabricDataWidth.W))))
      val output_ports = Vec(numFabricOutput,DecoupledIO(UInt(fabricDataWidth.W)))
      val cfg_mode = Input(Bool())
    }
  )
}

class RouterChannel(numInput        : Int,
                    numOutput       : Int,
                    inputDirection  : Array[Double],
                    outputDirection : Array[Double],
                    deComp          : Int,
                    FIFOdepth       : Array[Int]) extends FabricModule with HasFabricModuleParams{
  override val datawidthModule: Int = fabricDataWidth
  override lazy val numModuleInput:Int = numInput
  override lazy val numModuleOutput: Int = numOutput
  override lazy val inputMoudleDirection: Array[Double] = inputDirection
  override lazy val outputModuleDirection: Array[Double] = outputDirection
  override lazy val numDecomp: Int = deComp

  require(FIFOdepth.length == numDecomp)

  val FIFO_queue = new Array[QueueIO[UInt]](numDecomp)

  for (decomp <- 0 until numDecomp){
    FIFO_queue(decomp) = Module(new Queue(UInt(decompDataWidth.W),FIFOdepth(0))).io
    FIFO_queue(decomp).enq <> io.input_ports(decomp)
    io.output_ports(decomp) <> FIFO_queue(decomp).deq
  }
}