package common

import chisel3.Bits
import chisel3.experimental.ChiselEnum

object parameter {

}

object data_type extends Enumeration{
  type data_type = Value
  val b8, b16, b32, b64 = Value
}

object mem_operation extends Enumeration{
  type mem_operation = Value
  val read, write, add, sub, max, min = Value
}
