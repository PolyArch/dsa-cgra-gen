// See README.md for license details.

package dsl.parser

import dsl.syx._
import dsl.prePar._


trait CgraParser extends ReALan
  with fileReadClean{

  def ReALanParse(fileName:String):List[Any]= {

    val original_lines = cgraFileRead(fileName)
    val commentFreeLines = commentDelete(deleteLastSep(original_lines))

    val ParsedRes = parseAll(document,commentFreeLines)

    if(ParsedRes.successful){
      ParsedRes.get
    }else{
      println(ParsedRes.toString)
      throw new Exception
    }
  }
}