package dsl

import scala.util.parsing.combinator.JavaTokenParsers

trait CgraLan extends JavaTokenParsers
  with CgraLanClassDefine
  with CgraLanAssignment
  with CgraLanCollection
  with CgraLanConnection
  with CgraLanItems
  {

  def LangModule : Parser[Any] =(
    {println("ClassDefine in LangModule");ClassDefine}
    | {println("Assign in LangModule");Assign}
      | {println("Collection in LangModule");collectable}
      | {println("Connection in LangModule");Connection}
      | {println("Item in LangModule");Item}
    )
  def seperater : Parser[Any] = (
    ";"
      |(";"~whiteSpace)
  )
  def comment : Parser[Any] = "\\/\\/.+".r

  def document: Parser[List[Any]] =
    repsep({println("langModule in document ------- ");LangModule},seperater)


}