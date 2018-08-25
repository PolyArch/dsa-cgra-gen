package cgraexplorationframework.dsl.cgral

import scala.util.parsing.combinator._

trait CgraLanDir extends JavaTokenParsers with RegexParsers {
  def dir2d : Parser[Any] =
    "(r|a)?\\[-?(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9]),-?(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])]".r
}

trait CgraLanItems extends JavaTokenParsers
  with CgraLanDir

  with RegexParsers {

  def Item : Parser[Any] =
    fullItem | aliasItem | encodeItem | singleItem
  def fullItem : Parser[Any] =
    aliasItem ~":"~wholeNumber
  def encodeItem : Parser[Any] =
    singleItem~":"~wholeNumber
  def aliasItem : Parser[Any] =
    singleItem ~ ":"~ singleItem

  def singleItem : Parser[Any] =
   variable | dir2d

  def variable : Parser[Any] =
    "[a-zA-Z](\\w+)?".r

}

