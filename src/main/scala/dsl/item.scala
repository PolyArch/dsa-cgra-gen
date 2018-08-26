package dsl

import scala.util.parsing.combinator.{JavaTokenParsers, RegexParsers}

trait CgraLanDir extends JavaTokenParsers
  with RegexParsers {

  def direction : Parser[Direction] =(

    (aliasDir~":"~dirEncode) ^^ {case aD~":"~dE => {aD.encode = dE;aD}}
      | aliasDir
      |(dir2d~":"~dirEncode) ^^ {case d2d~":"~dE => {d2d.encode = dE;d2d}}
      | dir2d
    )

  def aliasDir : Parser[Direction] =
    dirAlias ~ ":" ~ dir2d ^^ {case dA~":"~d2d =>{d2d.alias = dA;d2d}}

  def dirAlias : Parser[String] =
    stringLiteral

  def dir2d : Parser[Direction] =
    "["~floatingPointNumber~","~floatingPointNumber~"]"~opt(offsetType) ^^
      {
        case "["~xDir~","~yDir~"]"~None => new Direction{x=xDir.toInt;y=yDir.toInt}
        case "["~xDir~","~yDir~"]"~ offset => new Direction {x=xDir.toInt;y=yDir.toInt
            offset_type= offset.toString}
      }

  def dirEncode : Parser[Int] =
    wholeNumber ^^ (_.toString.toInt)

  def offsetType : Parser[String] =
    "a|r".r ^^ (_.toString)

  class Direction {
    var alias: String =null
    var x : Int = 0
    var y: Int = 0
    var offset_type : String = "r"
    var encode :Int  = -1
  }

}

trait CgraLanItems extends JavaTokenParsers
  with RegexParsers {

  def item : Parser[Item] =(
    {println("select encode item in Item");encodeVir }
      | {println("select variable in Item");variable }
    )

  def encodeVir : Parser[Item] =
    variable~encoded ^^ {case v ~ vE => {v.itemEncode = vE;v}}

  def variable : Parser[Item] =
    variableName ~ opt(index) ^^ {
      case name ~ None =>{new Item{itemName = name;itemIndex = -1}}
      case name ~ iI => {new Item{itemName = name;itemIndex = showOption(iI).asInstanceOf[Int]}}
}

  def variableName : Parser[String] =
    "[a-zA-Z](\\w+)?".r ^^ (_.toString)

  def index : Parser[Int] =
    "("~wholeNumber~")" ^^ {case "("~idx~")" => idx.toInt}

  def encoded : Parser[Int] =
    ":" ~ wholeNumber ^^ {case ":"~ iE => iE.toInt}

  def  showOption[T](x:Option[T])= x match{
    case Some(i) => i
    case _ => null
  }

  class Item {

    var itemName : String = null
    var itemEncode : Int = -1
    var itemIndex  : Int = -1
  }



}

