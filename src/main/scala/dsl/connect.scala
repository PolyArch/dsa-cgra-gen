package dsl

import scala.util.parsing.combinator.{JavaTokenParsers, RegexParsers}

trait CgraLanConnection extends JavaTokenParsers
  with CgraLanDir
  with CgraLanItems{

  def connection : Parser[Connection] =(
     {println("select bothWay in Connection");connectBothWay}
       | {println("select to Left in Connection");connectToLeft}
       | {println("select to Right in Connection");connectToRight}
    )

  def connectToLeft : Parser[Connection] =
    variable  ~ "\\<\\-".r~opt(ConnectionFeature)~"\\-".r ~ variable ^^
  {
    case to~_~cF~_~from =>
      new Connection {
        fromPort = fromPort :+ from
        toPort = toPort :+ to
        ConnectionFeature = showOption(cF).asInstanceOf[String]
        ConnectionDirection = "Left"}
  }

  def connectToRight : Parser[Connection] =
    variable  ~ "\\-".r ~opt(ConnectionFeature)~"\\-\\>".r ~ variable ^^
      {
        case from~_~cF~_~to => new Connection {
          fromPort = fromPort :+ from
          toPort = toPort :+ to
          ConnectionFeature = showOption(cF).asInstanceOf[String]
          ConnectionDirection = "Right"}

      }

  def connectBothWay : Parser[Connection] =
    variable  ~ "\\<\\-".r ~opt(ConnectionFeature)~"\\-\\>".r ~ variable^^
      {
        case to~_~cF~_~from => new Connection {
          fromPort = fromPort :+ from :+ to
          toPort = toPort :+ to :+ from
          ConnectionFeature = showOption(cF).asInstanceOf[String];ConnectionDirection = "Both"}
      }

  def ConnectionFeature :  Parser[String] =
    "(\\w+)".r ^^ (x => x.toString)

  class Connection {
    var ConnectionDirection : String = null
    var ConnectionFeature : String = null
    var fromPort : List[Item] = List()
    var toPort : List[Item] = List()
  }

}

