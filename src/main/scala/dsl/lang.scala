package cgraexplorationframework.dsl.cgral

import scala.util.parsing.combinator.JavaTokenParsers

class CgraLan extends JavaTokenParsers
  with CgraLanAssignment
  with CgraLanCollection
  with CgraLanConnection
  with CgraLanItems
  {

  def LangModule : Parser[Any] =(
    Collection
      | Connection
      | Item
    )
  def comment : Parser[Any] = "\\/\\/.+".r

  def document: Parser[List[Any]] =
    repsep(LangModule,opt(",")|whiteSpace)


}