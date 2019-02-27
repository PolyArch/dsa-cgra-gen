package cgra.parameter

object isa {
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
  val INPUT_TYPE : String = "INPUT"
  val OUTPUT_TYPE : String = "OUTPUT"
  val maxBitsWidth = 2048
}