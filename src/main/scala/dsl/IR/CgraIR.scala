// See README.md for license details.

package dsl.IR

class CgraModel{

  var numCols : Int = 0
  var numRows : Int = 0

  var GridModuleIR : List[GridModule] = List()

  var GridIR = new Array[Array[GridModule]](numRows)

  var ConnectModuleIR:List[ConnectIR] = List[ConnectIR]()

  var InterfacePorts:List[InterfacePortIR] = List[InterfacePortIR]()

}

class GridModule {
  var name: String = ""
  var row:Int = -1
  var col:Int = -1
  var existed         : Boolean = false
  var numInput        : Int = -1
  var numOutput       : Int = -1
  var inputLocation  : List[(Int,Int)] = List()
  var outputLocation : List[(Int,Int)] = List()
  var deComp          : Int = 1

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
  def copy(copyF:GridFUIR):GridFUIR={
    new GridFUIR{
      name= copyF.name
      row = copyF.row
      col= copyF.col
      existed = copyF.existed
      numInput = copyF.numInput
      numOutput= copyF.numOutput
      inputLocation= copyF.inputLocation
      outputLocation = copyF.outputLocation
      deComp  = copyF.deComp
      Instructions = copyF.Instructions
      maxDelayPipeLen  = copyF.maxDelayPipeLen
      muxDirMatrix   = copyF.muxDirMatrix
    }
  }
}

class GridRouterIR extends GridModule {
  var muxDirMatrix    : Array[Array[Array[Boolean]]] =
    Array(
      Array(
        Array(x = false)
      )
    )
  def copy(copyF:GridRouterIR):GridRouterIR={
    new GridRouterIR{
      name= copyF.name
      row = copyF.row
      col= copyF.col
      existed = copyF.existed
      numInput = copyF.numInput
      numOutput= copyF.numOutput
      inputLocation= copyF.inputLocation
      outputLocation = copyF.outputLocation
      deComp  = copyF.deComp
      muxDirMatrix   = copyF.muxDirMatrix
    }
  }
}

class ConnectIR {
  var fromModule :GridModule= _
  var toModule :GridModule= _
  var connectFeatureList :String= ""
  var fromLocation : (Int,Int) = _
  var toLocation : (Int,Int) = _
  var fromPort : Int =_
  var toPort : Int = _

  var deCompInput     : Int = _
  var deCompOutput    : Int = _
  var FIFOdepth       : Array[Int] = _

}

class InterfacePortIR{
  var InOrOut :String = ""
  var numSecIOPort :Int = _
  var portNames :List[String] = _
  var gridModules : List[GridModule] = _
}