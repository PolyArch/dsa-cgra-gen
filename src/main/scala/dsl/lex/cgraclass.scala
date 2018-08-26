package dsl.lex

import scala.util.parsing.combinator.{JavaTokenParsers, RegexParsers}

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
    var ClassType:Item = null
    var ClassMembers:List[Any] = List()
  }

}

trait CgraLanClassDefine extends JavaTokenParsers
  with CgraLanClass
  with CgraLanCollection
  with CgraLanItems
{
  def classDefine : Parser[ClassDefine] =
    {println("select Item before Assign");item}~ "=" ~ "new" ~ {println("select Class after Assign");cgraClass} ^^
  {
    case cDT ~ "=" ~"new"~cDF => new ClassDefine{ClassDefineTarget = cDT;ClassDefineFrom = cDF}
  }

  class ClassDefine {
    var ClassDefineTarget : Item = null
    var ClassDefineFrom : CgraClass = null
  }
}