package cgraexplorationframework.dsl.cgral

import scala.util.parsing.combinator.JavaTokenParsers

class CgraLan extends JavaTokenParsers
  with CgraLanAssignment
  with CgraLanCollection
  with CgraLanConnection
  with CgraLanItems
  {

  def LangModule : Parser[Any] =(
    {println("Assign in LangModule");Assign}
      | {println("Collection in LangModule");Collection}
      | {println("Connection in LangModule");Connection}
      | {println("Item in LangModule");Item}
    )

  def comment : Parser[Any] = "\\/\\/.+".r

  def document: Parser[List[Any]] =
    repsep({println("langModule in document ------- ");LangModule},";")


}