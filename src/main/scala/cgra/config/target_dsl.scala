package cgra.config

import cgra.fabric.HasRouter

abstract class CGRA extends Build("CGRA")
  {
  var ProcessingElementsSize:(Int,Int) = (0,0)
}


//Pragma
object myCGRA extends CGRA {

  ProcessingElementsSize = (4,3)

  val Router = newtile("Router",125)

  let (Router) at (1,3)

  expand (Router) by (5,4)

  val test = duplicate(Params(Router))

  println("Hello World")
}