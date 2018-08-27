// See README.md for license details.

package dsl

import dsl.IR.CgraModel
import dsl.compiler._
import dsl.generator._
import dsl.parser._

object CgraLanguageFullStack {
  def main (cgraLanFiles:Array[String]):Unit = {
    cgraLanFiles.foreach(_ => new CgraFullStack(_))
    println("Finished ! ")
  }

  class CgraFullStack(fileName:String)
    extends CgraGenerator
    with CgraLanCompiler
    with CgraParser
  {
    val parsedCodes:ParseResult[List[Any]] = cgraLanParse(fileName)
    val model:CgraModel = cgraCompile(parsedCodes)
    val cgra:CgraInstance = cgraGenerate(model)
  }

}