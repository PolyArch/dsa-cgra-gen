package dsl.lex

import scala.util.parsing.combinator.{JavaTokenParsers, RegexParsers}

trait CgraLanFunction extends JavaTokenParsers
  with CgraLanItems {
  def function: Parser[Any] =
    functionName ~ functionArgs ^^
      {
        case fN ~ fA=> new Function{FunctionName = fN.asInstanceOf[Item];FunctionArgs =showOption(fA).asInstanceOf[List[Any]]}
      }

  def functionName: Parser[Item] =
    item ^^ (x=>x)

  def functionArgs : Parser[Any] =
    "(" ~> opt(FunctionMultiArgs|FunctionSingleArg) <~ ")"

  def FunctionMultiArgs : Parser[List[Any]] =
    repsep(FunctionSingleArg,","|(","~whiteSpace)) ^^ {List() ++ _}

  def FunctionSingleArg : Parser[Any] =
    item | stringLiteral | floatingPointNumber

  class Function {
    var FunctionName:Item = null
    var FunctionArgs:List[Any] = null
  }

  //   (.)?+

}