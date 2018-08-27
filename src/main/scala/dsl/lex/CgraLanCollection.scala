// See README.md for license details.

package dsl.lex

import scala.util.parsing.combinator._

trait CgraLanCollection extends JavaTokenParsers
  with CgraLanConnection
  with CgraLanDir
  with CgraLanItems{

  def collectable : Parser[Collection] =
    opt(collectAlias) ~opt(":")~collectSet ^^
      {
        case None~None~collec => new Collection{ aliasCollection = null;CollectionSet = collec}
        case aC~ _ ~collec => new Collection{ aliasCollection = showOption(aC).asInstanceOf[Item];CollectionSet = collec}
      }

  def collectSet : Parser[List[Any]] =
    "{"~> repsep(
      collectable
        |connection
        |direction
        |item,","|opt(whiteSpace)) <~"}" ^^ (List() ++ _)

  def collectAlias : Parser[Item] =
    item

  class Collection {
    var aliasCollection : Item = _
    var CollectionSet : List[Any] = _
  }

}

