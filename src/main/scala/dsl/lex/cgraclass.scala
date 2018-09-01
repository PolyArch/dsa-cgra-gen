// See README.md for license details.

package dsl.lex

import scala.util.parsing.combinator._

trait ReALanClass  extends JavaTokenParsers
  with ReALanAssignment{

  def cgraClass : Parser[CgraClass] =
    item ~ cgraClassMember ^^ {
      case nC ~ cM => new CgraClass {ClassType = nC;ClassMembers = cM}
    }

  def cgraClassMember : Parser[List[Any]] =
    "{"~> repsep(connection|assign,","|opt(whiteSpace)) <~"}" ^^ (List() ++ _)

  class CgraClass {
    var ClassType:Item = _
    var ClassMembers:List[Any] = List()
  }

}

trait ReALanClassInstantiate extends JavaTokenParsers
  with ReALanClass
  with ReALanCollection
  with ReALanItems
{
  def classInstantiate : Parser[ClassInstantiate] =
    item~ "=" ~ "new" ~ cgraClass ^^
  {
    case cDT ~ "=" ~"new"~cDF => new ClassInstantiate{ClassInstantiateTarget = cDT;ClassInstantiateFrom = cDF}
  }

  class ClassInstantiate {
    var ClassInstantiateTarget : Item = _
    var ClassInstantiateFrom : CgraClass = _
  }
}