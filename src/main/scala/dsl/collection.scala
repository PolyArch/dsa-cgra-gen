package cgraexplorationframework.dsl.cgral

import scala.util.parsing.combinator._

trait CgraLanCollection extends JavaTokenParsers
  with CgraLanItems
  with CgraLanConnection{

  def Collection : Parser[Any] =
    "{"~> repsep( Connection | dir2d | Item,opt(",")|whiteSpace)<~"}"

}