package cgraexplorationframework.simplechip.config

import scala.util.parsing.combinator._

class cgraModel(modelFileName :String){

  // TODO: Need to add parsering function
  val numCols : Int = 5
  val numRows : Int = 6
  val numFabricInput : Int = 10
  val numFabricOutput : Int = 11

  val GridInfo = new Array[Array[GridModule]](numCols * numRows)



}

abstract class GridModule {
  var name: String = ""
  var existed         : Int = -1
  var numInput        : Int = -1
  var numOutput       : Int = -1
  var inputDirection  : Array[(Int,Int)] = Array((-1,-1))
  var outputDirection : Array[(Int,Int)] = Array((-1,-1))
  var deComp          : Int = -1
}

class GridFUInfo extends GridModule {
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

class GridRouterInfo extends GridModule {
  var muxDirMatrix    : Array[Array[Array[Boolean]]] =
    Array(
      Array(
        Array(false),Array(false),Array(false),Array(false)
      )
    )
}