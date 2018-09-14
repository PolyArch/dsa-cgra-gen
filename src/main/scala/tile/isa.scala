package tile

import config._
import chisel3._
import chisel3.util._

object isa {
  val Or   = 0
  val And  = 1
  val Xor  = 2

  val Add = 3
  val Sub = 4
  val Mul = 5
  val UDiv = 6

  val numISA = 16
}
