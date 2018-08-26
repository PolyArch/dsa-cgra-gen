package dsl.parser

import dsl.syx._
import dsl.prePar._


class CgraParseExpr extends CgraLan
  with fileClean{
  def cgraLanParse(fileName:String):ParseResult[List[Any]]= {

    val original_lines = fileRead(fileName)
    val commentFreeLines = commentDelete(deleteLastSep(original_lines))

    try{
      val cgraLangParsed:ParseResult[List[Any]] = parseAll(document,commentFreeLines)
      println("Successfully parsed")
      println(cgraLangParsed)
      cgraLangParsed
    }catch{
      case _ : Throwable=> {
        println("Parsing fail")
        throw new Exception
      }
    }
  }
}