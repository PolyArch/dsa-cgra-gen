// See README.md for license details.

package dsl.parser

import dsl.syx._
import dsl.prePar._


trait CgraParser extends CgraLan
  with fileReadClean{

  def cgraLanParse(fileName:String):List[Any]= {

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