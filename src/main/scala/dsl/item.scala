package cgraexplorationframework.dsl.cgral

import scala.util.parsing.combinator._

trait CgraLanDir extends JavaTokenParsers with RegexParsers {

  def direction : Parser[Any] =(
    (dirAlias~":"~dir2d~":"~dirEncode)
    |(dir2d~":"~dirEncode)
    | dir2d
  )



  def aliasDir : Parser[Any] =
    dirAlias ~ ":" ~ dir2d

  def dirAlias : Parser[Any] =
    stringLiteral


  def dir2d : Parser[Any] =
    "\\[-?(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9]),-?(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])](r|a)?".r

  def dirEncode : Parser[Any] =
    "(3)?".r ~ wholeNumber
}

trait CgraLanItems extends JavaTokenParsers
  with RegexParsers {

  def Item : Parser[Any] =(
      {println("select encode item in Item");encodeVir }
        | {println("select variable in Item");variable }
    )


  def encodeVir : Parser[Any] =
    variable~encode

  def variable : Parser[Any] =
    "[a-zA-Z](\\w+)?".r ~ opt("-"~index)

  def index : Parser[Any] =
    wholeNumber

  def encode : Parser[Any] =
    ":" ~ wholeNumber

}

