package cgra.config

import config._

//Pragma
object BuildingMyTiles
  extends Build{
  override val current_type = "CGRA"
  override val current_id = 0

  // Create Tile
  val CGRA = new_tile("Cgra").asInstanceOf[Cgra]
  val sw = new_tile("Router")
  val dedicated_pe = new_tile("Dedicated_PE")


  val switch = Router(current_type,current_id,1)

  have (switch)
  pick (switch) has_ports (4,2)
  pick (switch) port 1 use_default_port_params

  pick (CGRA) fill_processing_element pick(switch)
  pick (CGRA) fill_processing_element pick(dedicated_pe)

  have (pick(switch) <-> pick(switch) )
  have (pick(sw) --> pick(switch) )
  add_connect(sw,sw)

  let(pick(switch) -->,sw)
}