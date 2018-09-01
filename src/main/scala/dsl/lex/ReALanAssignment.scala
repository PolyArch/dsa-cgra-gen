// See README.md for license details.

package dsl.lex

import scala.util.parsing.combinator.JavaTokenParsers

trait ReALanAssignment extends JavaTokenParsers
  with ReALanFunction
  with ReALanCollection
  with ReALanItems
{
  def assign : Parser[Any] =
    item~ "=" ~
      (function
        |collectable
        |location
        |item
        |floatingPointNumber) ^^
  {
    case aT~_~aF => new Assign {AssignTarget = aT;AssignFrom = aF}
  }

  class Assign {
    var AssignTarget : Item = _
    var AssignFrom : Any = _
  }
}

