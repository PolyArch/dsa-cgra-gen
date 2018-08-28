// See README.md for license details.

package dsl.lex

import scala.util.parsing.combinator.{JavaTokenParsers, RegexParsers}

trait CgraLanDir extends JavaTokenParsers
with CgraLanItems
  with RegexParsers {

  def location : Parser[Location] =(

    (aliasDir~":"~dirEncode) ^^ {case aD~":"~dE => aD.encode = dE; aD }
      | aliasDir
      |(dir2d~":"~dirEncode) ^^ {case d2d~":"~dE => d2d.encode = dE;d2d}
      | dir2d
    )

  def aliasDir : Parser[Location] =
    dirAlias ~ ":" ~ dir2d ^^ {case dA~":"~d2d =>d2d.alias = dA;d2d}

  def dirAlias : Parser[Item] =
    item

  def dir2d : Parser[Location] =
    "["~floatingPointNumber~","~floatingPointNumber~"]"~opt(offsetType) ^^
      {
        case "["~xDir~","~yDir~"]"~None => new Location{x=xDir.toInt;y=yDir.toInt}
        case "["~xDir~","~yDir~"]"~ offset => new Location {x=xDir.toInt;y=yDir.toInt
            offset_type= offset.toString}
      }

  def dirEncode : Parser[Int] =
    wholeNumber ^^ (_.toString.toInt)

  def offsetType : Parser[String] =
    "a|r".r ^^ (_.toString)



}

class Location {
  var alias: Item =_
  var x : Int = 0
  var y: Int = 0
  var offset_type : String = "r"
  var encode :Int  = -1
}

trait CgraLanItems extends JavaTokenParsers
  with RegexParsers {

  def item : Parser[Item] = encodeVir | variable

  def encodeVir : Parser[Item] =
    variable~encoded ^^ {case v ~ vE => v.itemEncode = vE;v}

  def variable : Parser[Item] =
    variableName ~ opt(index) ^^ {
      case name ~ None =>new Item{itemName = name;itemIndex = -1}
      case name ~ iI => new Item{itemName = name;itemIndex = showOption(iI).asInstanceOf[Int]}
}

  def variableName : Parser[String] =
    "[a-zA-Z](\\w+)?".r ^^ (_.toString)

  def index : Parser[Int] =
    "("~wholeNumber~")" ^^ {case "("~idx~")" => idx.toInt}

  def encoded : Parser[Int] =
    ":" ~ wholeNumber ^^ {case ":"~ iE => iE.toInt}

  def showOption[T](x:Any)= x match{
    case Some(i) => i
    case _ => null
  }
}

class Item {

  var itemName : String = _
  var itemEncode : Int = -1
  var itemIndex  : Int = -1
}