// See README.md for license details.

package dsl.lex

import scala.util.parsing.combinator._

trait CgraLanConnection extends JavaTokenParsers
  with CgraLanItems{

  def connection : Parser[Connection] =(
     connectBothWay
       | connectToLeft
       | connectToRight
    )

  def connectToLeft : Parser[Connection] =
    variable  ~ "\\<\\-".r~opt(connectionFeature)~"\\-".r ~ variable ^^
  {
    case to~_~cF~_~from =>
      new Connection {
        fromPort = fromPort :+ from
        toPort = toPort :+ to
        ConnectionFeature = showOption(cF).asInstanceOf[String]
        ConnectionLocation = "Left"}
  }

  def connectToRight : Parser[Connection] =
    variable  ~ "\\-".r ~opt(connectionFeature)~"\\-\\>".r ~ variable ^^
      {
        case from~_~cF~_~to => new Connection {
          fromPort = fromPort :+ from
          toPort = toPort :+ to
          ConnectionFeature = showOption(cF).asInstanceOf[String]
          ConnectionLocation = "Right"}

      }

  def connectBothWay : Parser[Connection] =
    variable  ~ "\\<\\-".r ~opt(connectionFeature)~"\\-\\>".r ~ variable^^
      {
        case to~_~cF~_~from => new Connection {
          fromPort = fromPort :+ from :+ to
          toPort = toPort :+ to :+ from
          ConnectionFeature = showOption(cF).asInstanceOf[String];ConnectionLocation = "Both"}
      }

  def connectionFeature :  Parser[String] =
    "(\\w+)".r ^^ (x => x.toString)

  class Connection {
    var ConnectionLocation : String = _
    var ConnectionFeature : String = _
    var fromPort : List[Item] = List()
    var toPort : List[Item] = List()
  }

}

