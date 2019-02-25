package cgra.config

import config._

//Pragma
object BuildingMyTiles
  extends Build{
  override val current_type = "CGRA"
  override val current_id = 0

  // Create Tile
  /*
  val CGRA = new_tile("Cgra").asInstanceOf[Cgra]
  val sw = new_tile("Router")
  val dedicated_pe = new_tile("Dedicated_PE")
  initial (switch)
  have (switch)
  pick (switch) has_ports (4,2)
  pick (CGRA) fill_processing_element pick(switch)
  pick (CGRA) fill_processing_element pick(dedicated_pe)
  have (pick(switch) <-> pick(switch) )
  have (pick(sw) --> pick(switch) )
  add_connect(sw,sw)
  pick (CGRA) interconnect
  let(pick(switch) -->,sw)
*/

  val switch = Router(current_type,current_id,1)

  have (switch)

  pick (switch) set_word_width 64

  pick (switch) has_ports (4,2)

  pick (switch) use_subnet_match_connect

  pick (switch) calulate_all_output_config_mode

  Generate(switch)
}