package dsl

import scala.util.parsing.combinator.{JavaTokenParsers, RegexParsers}

trait CgraLanClass  extends JavaTokenParsers
  with CgraLanAssignment{
  def CgraClass : Parser[Any] =
    Item ~ ("{"~> repsep(
      {println("select connection in Class");Connection}
      |{println("select Assign in Class");Assign},","|opt(whiteSpace)) <~"}")
}

trait CgraLanClassDefine extends JavaTokenParsers
with CgraLanClass
  with CgraLanCollection
  with CgraLanItems
  {
  def ClassDefine : Parser[Any] =
  {println("select Item before Assign");Item}~ "=" ~ {println("select Class after Assign");CgraClass}
}