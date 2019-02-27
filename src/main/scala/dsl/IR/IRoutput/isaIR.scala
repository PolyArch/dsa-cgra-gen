// See README.md for license details.

package dsl.IR.IRoutput

import cgra.parameter.isa

import scala.util.Properties

trait isaIR {
  def isaIRoutput:String = {
    var emptyString = "{"
    val ISAs = isa.getClass.getDeclaredFields
    for(iSA <- ISAs){
      iSA.setAccessible(true)
      if(iSA.get(isa).isInstanceOf[Int])
        emptyString += "\"" + iSA.getName + "\":" + iSA.get(isa) + "," + Properties.lineSeparator
    }
    emptyString = emptyString.reverse.replaceFirst(",","").reverse
    emptyString + "}"
  }
}
