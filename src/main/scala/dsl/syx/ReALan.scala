// See README.md for license details.

package dsl.syx

import dsl.lex._
import scala.util.parsing.combinator.JavaTokenParsers

trait ReALan extends JavaTokenParsers
  with ReALanClassInstantiate
  with ReALanAssignment
  with ReALanCollection
  with ReALanConnection
  with ReALanItems
  {

  def parseCodeLines : Parser[Any] = classInstantiate |assign |connection

  def separater : Parser[Any] = (
    ";"
      |(";"~whiteSpace)
  )
  def comment : Parser[Any] = "\\/\\/.+".r

  def document: Parser[List[Any]] = repsep(parseCodeLines,separater)

}