package dsl

import scala.util.parsing.combinator.{JavaTokenParsers, RegexParsers}

trait CgraLanConnection extends JavaTokenParsers
  with CgraLanDir
  with CgraLanItems{

  def Connection : Parser[Any] =(
     {println("select bothWay in Connection");connectBothWay}
       | {println("select to Left in Connection");connectToLeft}
       | {println("select to Right in Connection");connectToRight}
    )

  def connectToLeft : Parser[Any] =
    variable  ~ "\\<\\-".r~opt(ConnectionFeature)~"\\-".r ~ variable

  def connectToRight : Parser[Any] =
    variable  ~ "\\-".r ~opt(ConnectionFeature)~"\\-\\>".r ~ variable

  def connectBothWay : Parser[Any] =
    variable  ~ "\\<\\-".r ~opt(ConnectionFeature)~"\\-\\>".r ~ variable

  def ConnectionFeature :  Parser[Any] =
    "(\\w+)".r
}

trait CgraLanAssignment extends JavaTokenParsers
  with CgraLanFunction
  with CgraLanCollection
  with CgraLanItems
  {
  def Assign : Parser[Any] =
    {println("select Item before Assign");Item}~ "=" ~
      ({println("select function after Assign");function}
        |{println("select collectable after Assign");collectable}
        |{println("select direction after Assign");direction}
        | {println("select Item after Assign");Item})
}