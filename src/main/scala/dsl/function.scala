package dsl

import scala.util.parsing.combinator.{JavaTokenParsers, RegexParsers}

trait CgraLanFunction extends JavaTokenParsers
  with CgraLanItems {
  def function: Parser[Any] =
    functionName ~ "(" ~> opt(FunctionMultiArgs|FunctionSingleArg) <~ ")"

  def functionName: Parser[Any] =
    item

  def FunctionMultiArgs : Parser[Any] =
    repsep(FunctionSingleArg,","|(","~whiteSpace))

  def FunctionSingleArg : Parser[Any] =
    item | stringLiteral | floatingPointNumber

  //   (.)?+

}