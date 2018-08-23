package cgraexplorationframework.simplechip.tile

import cgraexplorationframework.simplechip.config._
import chisel3._
import chisel3.util._

object isa {
  def OR   = 0
  def AND  = 1
  def XOR  = 2

  def maxNumISA = 16
}