package tile

import config._
import chisel3._
import chisel3.util._

object isa {
  val OR   = 0
  val AND  = 1
  val XOR  = 2

  val Add = 3
  val Sub = 4
  val Mul = 5
  val Div = 6

  val maxNumISA = 16
}