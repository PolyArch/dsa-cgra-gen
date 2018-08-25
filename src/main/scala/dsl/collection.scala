package dsl

import scala.util.parsing.combinator._

trait CgraLanCollection extends JavaTokenParsers
  with CgraLanConnection
  with CgraLanDir
  with CgraLanItems{

  def collectable : Parser[Any] =
    opt(collectAlias ~":")~"{"~> repsep(
      {println("select connection in Collection");collectable}
        |{println("select connection in Collection");Connection}
        |{println ("select direction in collection");direction}
        |{println("select variable in collection");Item},","|opt(whiteSpace)) <~"}"

  def collectAlias : Parser[Any] =
    Item
}