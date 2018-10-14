// See README.md for license details.

package dsl.IR.IRoutput

import tile.ISA

import scala.util.Properties

trait isaIR {
  def isaIRoutput:String = {
    var emptyString = "{"
    val ISAs = ISA.getClass.getDeclaredFields
    for(iSA <- ISAs){
      iSA.setAccessible(true)
      if(iSA.get(ISA).isInstanceOf[Int])
        emptyString += "\"" + iSA.getName + "\":" + iSA.get(ISA) + "," + Properties.lineSeparator
    }
    emptyString = emptyString.reverse.replaceFirst(",","").reverse
    emptyString + "}"
  }
}
