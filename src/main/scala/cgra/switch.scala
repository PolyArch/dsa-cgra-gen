package cgraexplorationframework.simplechip.cgra

import chisel3._
import cgraexplorationframework.simplechip.tile._
import cgraexplorationframework.simplechip.config.Parameters

class Switch(implicit p:Parameters) extends FabricModule
  with HasFabricModuleParams{
  val io = new class extends Bundle
}