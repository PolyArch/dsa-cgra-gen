package cgraexplorationframework.simplechip.tile

import cgraexplorationframework.simplechip.config._
import chisel3._
import chisel3.util._

trait HasFabricParams {
  val CGRAdataWidth = 64
}

trait HasFabricModuleParams with HasFabricParams{
  val numInput : Int
  val numOutput : Int
  val inputDirection : Array[Double]
  val outputDirection : Array[Double]

  val test : UInt

  val numDecomp : Int
  require(isPow2(CGRAdataWidth/numDecomp))
}

trait HasFabricModuleIO

abstract class FabricModuleBundle(implicit p: Parameters) extends Bundle
  with FabricModuleParams



abstract class FabricModule (implicit val p: Parameters) extends Module
  with FabricModuleParams