// See README.md for license details.

package tile

import config._
import chisel3._
import chisel3.util._

object ISA {
  val Or   = 0
  val And  = 1
  val Xor  = 2

  val Add = 3
  val Sub = 4
  val Mul = 5
  val UDiv = 6

  val numISA = 7
}

object Constant {
  val SwitchType = 1
  val FuType = 0
  val maxBitsWidth = 2048
  val maxFuDelayPipeLength = 16
  val numOperandPerAluInFu = 2
  val ComponentInFu = Array("ALU","delayPipe","Mux")
}