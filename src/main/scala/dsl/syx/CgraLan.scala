// See README.md for license details.

package dsl.syx

import dsl.lex._
import scala.util.parsing.combinator.JavaTokenParsers

trait CgraLan extends JavaTokenParsers
  with CgraLanClassDefine
  with CgraLanAssignment
  with CgraLanCollection
  with CgraLanConnection
  with CgraLanItems
  {

  def parseCodeLines : Parser[Any] = classDefine |assign |connection

  def separater : Parser[Any] = (
    ";"
      |(";"~whiteSpace)
  )
  def comment : Parser[Any] = "\\/\\/.+".r

  def document: Parser[List[Any]] = repsep(parseCodeLines,separater)

}