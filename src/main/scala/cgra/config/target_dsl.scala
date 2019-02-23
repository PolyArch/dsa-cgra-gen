package cgra.config

import config._

//Pragma
object myCGRA extends CgraParams("CGRA's Parent System",0,0)
  with Build{

  ProcessingElementsSize = (4,3)

  var routers = new Array[Field[TileParams]](6)

  val Router = new_tile("Router").asInstanceOf[Router_Key]

  let (Router) modify_port(1) use_default_port_params

  add_connect(Router,Router)

  let (Router)

  // expand (Router) by (5,4)

  // val test = duplicate(Params(Router))

  GenerateTile(Router)


}