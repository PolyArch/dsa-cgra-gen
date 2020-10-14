package cgra.config

object constant {
  val OUTPUT_TYPE = "OUTPUT"
  val INPUT_TYPE = "INPUT"
  val MMIO_TYPE = "MMIO_CONTROL"
  val MULTI_TAG_PACKET_TYPE = "MULTI_TAG_PACKET_TYPE"

  val meaning_Index_Direction_Map = Map(
    0 -> "North",1 -> "East",2 -> "South",3 -> "West",
    4 -> "NorthEast",5 -> "SouthEast", 6 -> "NorthWest",7 -> "SouthWest",
    "North" -> 0,"East" -> 1,"South" -> 2,"West" -> 3,
    "NorthEast" -> 4,"SouthEast" -> 5, "NorthWest" -> 6,"SouthWest" -> 7)
  val numbered_Index_Direction_Map = (8 to 100).toList.map(i=>i -> ("Direction-" + i)).toMap
  val reversed = numbered_Index_Direction_Map.map(x=>x._2 -> x._1)

  val Index_Direction_Map = meaning_Index_Direction_Map ++ numbered_Index_Direction_Map ++ reversed
}
