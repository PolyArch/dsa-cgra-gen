// See README.md for license details.

package dsl.IR

class CgraModel{

  var numCols : Int = 0
  var numRows : Int = 0

  var GridModuleIR : List[GridModule] = List()

  var GridIR = new Array[Array[GridModule]](numCols * numRows)

  var ConnectModuleIR:List[ConnectIR] = List[ConnectIR]()

  var InterfacePort:List[InterfacePortIR] = List[InterfacePortIR]()

}

class GridModule {
  var name: String = ""
  var existed         : Int = -1
  var numInput        : Int = -1
  var numOutput       : Int = -1
  var inputLocation  : List[(Int,Int)] = List()
  var outputLocation : List[(Int,Int)] = List()
  var deComp          : Int = -1
}

class GridFUIR extends GridModule {
  var Instructions    : Array[Array[Array[Int]]] =
    Array(
      Array(Array(-1))
    ) //Instructions(outPort)(subNet) : Array of Instructions Set
  var maxDelayPipeLen : Array[Array[Array[Int]]] =
    Array(
      Array(Array(-1))
    ) //maxDelayPipeLen(outPort)(subNet)(operand)
  var muxDirMatrix    : Array[Array[Array[Array[Boolean]]]]=
    Array(
      Array(
        Array(Array(x = false)))
    )
}

class GridRouterIR extends GridModule {
  var muxDirMatrix    : Array[Array[Array[Boolean]]] =
    Array(
      Array(
        Array(x = false)
      )
    )
}

class ConnectIR extends GridModule{

  var fromList :List[GridModule]= List[GridModule]()
  var toList :List[GridModule]= List[GridModule]()
  var connectFeatureList :List[String]= List[String]()

  require(fromList.length == toList.length)
  require(fromList.length == connectFeatureList.length)
  require(toList.length == connectFeatureList.length)

}

class InterfacePortIR{

}