// See README.md for license details.

package dsl.lex

import scala.util.parsing.combinator._

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
    "(" ~> opt(functionMultiArgs|functionSingleArg) <~ ")"

  def functionMultiArgs : Parser[List[Any]] =
    repsep(functionSingleArg,","|(","~whiteSpace)) ^^ {List() ++ _}

  def functionSingleArg : Parser[Any] =
    item | stringLiteral | floatingPointNumber

  class Function {
    var FunctionName:Item = _
    var FunctionArgs:List[Any] = _
  }

  //   (.)?+

}