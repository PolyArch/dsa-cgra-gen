// See README.md for license details.

package dsl.library.builtinFunction

import dsl.compiler.Env

trait builtinFunction extends Env{
  def grid2d(gridRows:List[String]):Array[Array[String]] = {
    var cgra2dArray = new Array[Array[String]](gridRows.length)

    val binaryQuotes = "\"";val empty:String = ""
    val colSep :Char= '|'

    val maxCol =gridRows.map(row=>row.replace(binaryQuotes,empty).split(colSep).length).max

    for(row <- gridRows.indices){
      cgra2dArray(row) = new Array[String](maxCol)
      val rowCells:Array[String] = gridRows(row).replace(binaryQuotes,empty).split(colSep).map(_.trim())

      for(col <- rowCells.indices){
        cgra2dArray(row)(col) = rowCells(col)
      }
    }
    cgra2dArray
  }
}