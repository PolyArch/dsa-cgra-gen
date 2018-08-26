package dsl.generator

import dsl.compiler._
import dsl.IR._
import cgra._

object CGRA {
  def main (cgraLanFiles:Array[String]) = {
    cgraLanFiles.foreach(_ => new CgraFullStack(_))
    println("Finished ! ")
  }

  class CgraFullStack(modelName:String) extends cgraLanCompiler {
    val model:CgraModel = cgraCompile(modelName)
    val cgra:CgraInstance = cgraGenerate(model)
  }

  def cgraGenerate(model:CgraModel):CgraInstance = {
    new CgraInstance
  }

  class CgraInstance {

    var SwitchList : List[Switch] = List()
    var FuList : List[FU] = List()
    var InterfacePortList : List[InterfacePort] = List()

  }
}