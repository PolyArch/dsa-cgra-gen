package dsl.lex

import scala.util.parsing.combinator.JavaTokenParsers

trait CgraLanAssignment extends JavaTokenParsers
  with CgraLanFunction
  with CgraLanCollection
  with CgraLanItems
{
  def assign : Parser[Any] =
    {println("select Item before Assign");item}~ "=" ~
      ({println("select function after Assign");function}
        |{println("select collectable after Assign");collectable}
        |{println("select direction after Assign");direction}
        | {println("select Item after Assign");item}) ^^
  {
    case aT~_~aF => new Assign {AssignTarget = aT;AssignFrom = aF}
  }

  class Assign {
    var AssignTarget : Item = null
    var AssignFrom : Any = null
  }

}
