// See README.md for license details.

package dsl.lex

import scala.util.parsing.combinator._

trait CgraLanClass  extends JavaTokenParsers
  with CgraLanAssignment{

  def cgraClass : Parser[CgraClass] =
    item ~ cgraClassMember ^^ {
      case nC ~ cM => new CgraClass {ClassType = nC;ClassMembers = cM}
    }

  def cgraClassMember : Parser[List[Any]] =
    "{"~> repsep({println("select connection in Class");connection}
      |{println("select Assign in Class");assign},","|opt(whiteSpace)) <~"}" ^^ (List() ++ _)

  class CgraClass {
    var ClassType:Item = _
    var ClassMembers:List[Any] = List()
  }

}

trait CgraLanClassDefine extends JavaTokenParsers
  with CgraLanClass
  with CgraLanCollection
  with CgraLanItems
{
  def classDefine : Parser[ClassDefine] =
    item~ "=" ~ "new" ~ cgraClass ^^
  {
    case cDT ~ "=" ~"new"~cDF => new ClassDefine{ClassDefineTarget = cDT;ClassDefineFrom = cDF}
  }

  class ClassDefine {
    var ClassDefineTarget : Item = _
    var ClassDefineFrom : CgraClass = _
  }
}