package dsl.IR


class CgraModel{

  val numCols : Int = 5
  val numRows : Int = 6

  val GridIR = new Array[Array[GridModule]](numCols * numRows)

  val ConnectModuleIR:List[ConnectIR] = List[ConnectIR]()

  val InterfacePort:List[InterfacePortIR] = List[InterfacePortIR]()

}

class GridModule {
  var name: String = ""
  var existed         : Int = -1
  var numInput        : Int = -1
  var numOutput       : Int = -1
  var inputDirection  : Array[(Int,Int)] = Array((-1,-1))
  var outputDirection : Array[(Int,Int)] = Array((-1,-1))
  var deComp          : Int = -1
}
class GridFUIR extends GridModule {
  var Instructions    : Array[Array[Array[Int]]] =
    Array(
      Array(Array(-1)),
      Array(Array(-1)),
      Array(Array(-1)),
      Array(Array(-1))
    ) //Instructions(outPort)(subNet) : Array of Instructions Set
  var maxDelayPipeLen : Array[Array[Array[Int]]] =
    Array(
      Array(Array(-1)),
      Array(Array(-1)),
      Array(Array(-1)),
      Array(Array(-1))
    ) //maxDelayPipeLen(outPort)(subNet)(operand)
  var muxDirMatrix    : Array[Array[Array[Array[Boolean]]]]=
    Array(
      Array(
        Array(Array(false))),
      Array(
        Array(Array(false))),
      Array(
        Array(Array(false))),
      Array(
        Array(Array(false)))
    )
}
class GridRouterIR extends GridModule {
  var muxDirMatrix    : Array[Array[Array[Boolean]]] =
    Array(
      Array(
        Array(false),Array(false),Array(false),Array(false)
      )
    )
}

class ConnectIR extends GridModule{

  var fromList = List[GridModule]()
  var toList = List[GridModule]()
  var connectFeatureList = List[String]()

  require(fromList.length == toList.length == connectFeatureList.length)

}

class InterfacePortIR{

}

