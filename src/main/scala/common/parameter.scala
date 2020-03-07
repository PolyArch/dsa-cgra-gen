package common

import chisel3.Bits

object parameter {

}

object data_type extends Enumeration{
  val b8, b16, b32, b64 = Value("data width")
}

object mem_operation extends Enumeration{
  val read, write, add, sub, max, min = Value("mem operation")
}
