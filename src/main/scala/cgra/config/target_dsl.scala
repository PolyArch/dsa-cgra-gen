package cgra.config

import cgra.fabric.HasRouter

class target_dsl {

}

abstract class CGRA extends Build("CGRA")
  with HasRouter{
  var ProcessingElementsSize:(Int,Int) = (0,0)
}

class ProcessingUnit {
  def <->(that:ProcessingUnit):Connect_ID = {
    val testConnectID = Connect_ID(1,1,1)
    testConnectID
  }
}

//Pragma
object myCGRA extends CGRA {

  ProcessingElementsSize = (4,3)

  val ProcessingUnits = Array.ofDim[ProcessingUnit](5,4)

  val test = newtile("Router",125)

  println("Hello World")
}