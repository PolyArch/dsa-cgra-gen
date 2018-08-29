// See README.md for license details.

package tile

import dsl.IR._
import chisel3._
import chisel3.util._

trait HasFabricParams {
  val fabricDataWidth = 64
  lazy val numFabricInput : Int = 0
  lazy val numFabricOutput : Int = 0
  lazy val numRows : Int = 0
  lazy val numCols : Int = 0
}

trait HasFabricModuleParams extends HasFabricParams
{
  val datawidthModule       : Int
  val numModuleInput        : Int
  val numModuleOutput       : Int
  val inputMoudleLocation  : Array[(Int,Int)]
  val outputModuleLocation : Array[(Int,Int)]
  val numDecomp             : Int
  lazy val decompDataWidth       : Int = datawidthModule / numDecomp

  require(numModuleInput==inputMoudleLocation.length)
  require(numModuleOutput==outputModuleLocation.length)
  require(isPow2(fabricDataWidth/numDecomp))
}

abstract class FabricModule  extends Module
  with HasFabricModuleParams{
  lazy val io = IO(new Bundle{
    val input_ports = Vec(numModuleInput * numDecomp,Flipped(DecoupledIO(UInt(decompDataWidth.W))))
    val output_ports = Vec(numModuleOutput * numDecomp,DecoupledIO(UInt(decompDataWidth.W)))
    val cfg_mode = Input(Bool())
  })
}

class ModuleChannel(deCompInput     : Int,
                    deCompOutput    : Int,
                    FIFOdepth       : Array[Int]) extends Module
with HasFabricParams
{

  require(FIFOdepth.length == (deCompInput max deCompOutput))
  require(FIFOdepth.forall(fifo => fifo >= 0 ),"FIFO depth need to be non-negative")
  require(isPow2(fabricDataWidth/deCompInput))
  require(isPow2(fabricDataWidth/deCompOutput))

  val io = IO(new Bundle{
    val input_ports = Vec(deCompInput,Flipped(DecoupledIO(UInt((fabricDataWidth/deCompInput).W))))
    val output_ports = Vec(deCompOutput,DecoupledIO(UInt((fabricDataWidth/deCompOutput).W)))
  })

  val decompDataWidth : Int = fabricDataWidth / (deCompInput max deCompOutput)
  val decompIndataWidth : Int = fabricDataWidth / deCompInput
  val decompOutdataWidth : Int = fabricDataWidth / deCompOutput

  val maxSubNet : Int = FIFOdepth.length

  if(deCompInput == deCompOutput){
    val FIFO_queue = new Array[QueueIO[UInt]](FIFOdepth.length)
    for (subNet <- 0 until maxSubNet){
      if(FIFOdepth(subNet) > 0){
        FIFO_queue(subNet) = Module(new Queue(UInt(decompDataWidth.W),FIFOdepth(0))).io
        FIFO_queue(subNet).enq <> io.input_ports(subNet)
        io.output_ports(subNet) <> FIFO_queue(subNet).deq
      }else{
        io.output_ports(subNet) <> io.input_ports(subNet)
      }
    }
  }else if(deCompInput > deCompOutput){

    val IOratio : Int = deCompInput / deCompOutput

    val FIFO_queue = new Array[QueueIO[UInt]](FIFOdepth.length)
    for (subNet <- 0 until maxSubNet){
      if(FIFOdepth(subNet) > 0){
        FIFO_queue(subNet) = Module(new Queue(UInt(decompDataWidth.W),FIFOdepth(subNet))).io
        FIFO_queue(subNet).enq <> io.input_ports(subNet)
      }
    }

    val combineOut = new Array[DecoupledIO[UInt]](maxSubNet)

    for (subNet <- 0 until maxSubNet){
      if (FIFOdepth(subNet) > 0)
        combineOut(subNet) = FIFO_queue(subNet).deq
      else
        combineOut(subNet) = io.input_ports(subNet)
    }

    for(subOutNet <- 0 until deCompOutput){
      io.output_ports(subOutNet).bits := combineOut.zipWithIndex.filter(_._2 / IOratio == subOutNet).map(_._1.bits).reduceLeft(Cat(_,_))
    }

    for(subInNet <- 0 until deCompInput){
      val subOutNet = subInNet / IOratio
      combineOut(subInNet).ready := io.output_ports(subOutNet).ready
    }
    for(subOutNet <- 0 until deCompOutput){
      io.output_ports(subOutNet).valid := combineOut.zipWithIndex.filter(_._2/IOratio == subOutNet).map(_._1.valid).reduceLeft(_ & _)
    }

  }else {

    val IOratio : Int = deCompOutput / deCompInput

    val FIFO_queue = new Array[QueueIO[UInt]](FIFOdepth.length)
    for (subNet <- 0 until maxSubNet){
      val subInNet = subNet / IOratio
      val subOutIndex = subNet - subInNet * IOratio
      if(FIFOdepth(subNet) > 0){
        FIFO_queue(subNet) = Module(new Queue(UInt(decompDataWidth.W),FIFOdepth(subNet))).io
        FIFO_queue(subNet).enq.bits <> io.input_ports(subInNet).bits((subOutIndex + 1) * decompOutdataWidth - 1,subOutIndex * decompOutdataWidth)
        FIFO_queue(subNet).enq.valid <> io.input_ports(subInNet).valid
      }
    }

    val combineIn = new Array[DecoupledIO[UInt]](maxSubNet)

    for (subNet <- 0 until maxSubNet){
      val subInNet = subNet / IOratio
      val subOutIndex = subNet - subInNet * IOratio
      if (FIFOdepth(subNet) > 0){
        combineIn(subNet) = FIFO_queue(subNet).enq
        io.output_ports(subNet) <> FIFO_queue(subNet).deq
      }
      else{
        combineIn(subNet) = io.output_ports(subNet)
        io.output_ports(subNet).bits := io.input_ports(subInNet).bits((subOutIndex + 1) * decompOutdataWidth - 1,subOutIndex * decompOutdataWidth)
        io.output_ports(subNet).valid := io.input_ports(subInNet).valid
      }
    }

    for (subNet <- 0 until maxSubNet) {
      val subInNet = subNet / IOratio
      io.input_ports(subInNet).ready := combineIn.zipWithIndex.filter(_._2 / IOratio == subInNet).map(_._1.ready).reduceLeft(_ & _)
    }

  }
}



/*
abstract class Fabric(modelFile: String) extends Module
  with HasFabricParams{
  lazy val io = IO(
    new Bundle{
      val input_ports = Vec(numFabricInput,Flipped(DecoupledIO(UInt(fabricDataWidth.W))))
      val output_ports = Vec(numFabricOutput,DecoupledIO(UInt(fabricDataWidth.W)))
      val cfg_mode = Input(Bool())
    }
  )

  val model : CgraModel = new CgraModel(modelFile)
  override lazy val numRows:Int = model.numRows
  override lazy val numCols:Int = model.numCols
  override lazy val numFabricInput:Int = model.numFabricInput
  override lazy val numFabricOutput:Int = model.numFabricOutput

  // Initialize Fabric Grid
  lazy val FabricGrid = new Array[Array[FabricModule]](numRows)
  FabricGrid.foreach(row =>{
    new Array[FabricModule](numCols)
  })


}
*/

// Instantiate
/*
object ModuleChannelDriver extends App {chisel3.Driver.execute(args, () => new ModuleChannel(1,8,Array(6,0,0,1,5,3,4,7)))}
*/