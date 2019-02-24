package cgra.config

import config._

//Pragma
object myCGRA extends CgraParams("",0,0)
  with Build{

  override val current_type = module_type
  override val current_id = tile_id

  ProcessingElementsSize = (4,3)

  val Router = new_tile("Router")
    .asInstanceOf[Router]

  let (Router).num_input = 1

  let (Router) has_ports (4,2)

  let (Router) port 1 use_default_port_params

  add_connect(Router,Router)

}