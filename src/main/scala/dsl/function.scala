package dsl

import scala.util.parsing.combinator.{JavaTokenParsers, RegexParsers}

trait CgraLanFunction extends JavaTokenParsers
  with CgraLanItems {
  def function: Parser[Any] =
    functionName ~ "(" ~> opt(FunctionMultiArgs|FunctionSingleArg) <~ ")"

  def functionName: Parser[Any] =
    Item

  def FunctionMultiArgs : Parser[Any] =
    repsep(FunctionSingleArg,","|(","~whiteSpace))

  def FunctionSingleArg : Parser[Any] =
    Item | stringLiteral | floatingPointNumber

  //   (.)?+

}