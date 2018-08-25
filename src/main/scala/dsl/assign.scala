package dsl

import scala.util.parsing.combinator.JavaTokenParsers

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
