package basic

object Constant {
  val OUTPUT_TYPE = "OUTPUT"
  val INPUT_TYPE = "INPUT"
  val MMIO_TYPE = "MMIO_CONTROL"
  val Index_Direction_Map = Map(
    0 -> "North",1 -> "East",2 -> "South",3 -> "West",
    4 -> "NorthEast",5 -> "SouthEast", 6 -> "NorthWest",7 -> "SouthWest",
    "North" -> 0,"East" -> 1,"South" -> 2,"West" -> 3,
    "NorthEast" -> 4,"SouthEast" -> 5, "NorthWest" -> 6,"SouthWest" -> 7)
}