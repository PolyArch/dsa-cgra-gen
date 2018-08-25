package cgraexplorationframework.dsl.cgral

import scala.util.parsing.combinator.{JavaTokenParsers, RegexParsers}

trait CgraLanConnection extends JavaTokenParsers
  with CgraLanItems{

  def Connection : Parser[Any] =
    connectToLeft | connectToRight | connectBothWay

  def connectToLeft : Parser[Any] =
    Item ~ "\\<\\-".r~ConnectionFeature~"\\-".r ~ Item

  def connectToRight : Parser[Any] =
    Item ~ "\\-".r ~ConnectionFeature~"\\-\\>".r ~ Item

  def connectBothWay : Parser[Any] =
    Item ~ "\\<\\-".r ~ConnectionFeature~"\\-\\>".r ~ Item

  def ConnectionFeature :  Parser[Any] =
    "(\\w+)?".r
}

trait CgraLanAssignment extends JavaTokenParsers
  with CgraLanItems
  with CgraLanCollection {
  def Assign : Parser[Any] =
    Item ~ "=" ~ Collection | Item
}