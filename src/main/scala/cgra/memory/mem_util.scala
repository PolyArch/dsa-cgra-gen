package cgra.memory

object mem_util {
  object str_type extends Enumeration{
    type str_type = Value
    val indirect, linear, both = Value
  }
}