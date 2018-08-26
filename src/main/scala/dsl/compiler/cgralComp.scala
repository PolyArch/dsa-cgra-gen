package dsl.compiler

import dsl.parser._
import dsl.IR._

class cgraLanCompiler extends CgraParseExpr{


  def cgraCompile(fileName:String):CgraModel = {

    val parsedSentences = cgraLanParse(fileName)

    new CgraModel

  }

}