// See README.md for license details.

package dsl.parser

import dsl.syx._
import dsl.prePar._


trait CgraParser extends CgraLan
  with fileReadClean{

  def cgraLanParse(fileName:String):ParseResult[List[Any]]= {

    val original_lines = cgraFileRead(fileName)
    val commentFreeLines = commentDelete(deleteLastSep(original_lines))

    try{parseAll(document,commentFreeLines)}
    catch{ case _ : Throwable=> throw new Exception}
  }
}