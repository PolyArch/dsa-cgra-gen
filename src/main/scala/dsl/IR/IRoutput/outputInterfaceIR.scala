// See README.md for license details.

package dsl.IR.IRoutput

import dsl.IR.{CgraModel, InterfacePortIR}

import scala.util.Properties

trait outputInterfaceIR extends formatValue{
  def outputInterfacePortIR(model:CgraModel):String = {
    var emptyString = "\"InterfacePort\":{" + Properties.lineSeparator
    val IFportName = model.InterfacePorts.map(_.InOrOut).distinct
    for(io <- IFportName){
      model.InterfacePorts.filter(_.InOrOut==io).zipWithIndex.foreach(iI=>{
        val iF = iI._1
        val index = iI._2
        emptyString += "\"" + io + "_" + index + "\":{" + Properties.lineSeparator
        val fields = (new InterfacePortIR).getClass.getDeclaredFields
        for(field <- fields) {
          field.setAccessible(true)
          if(field.getName != "connectIR")
          {
            emptyString += "\"" + field.getName + "\":"
            val JSONformat = field.get(iF) match {
              case se: Seq[_] => Seq2JSONString(se)
              case str: String => String2JSON(str)
              case se => se.toString
            }
            emptyString += JSONformat + "," + Properties.lineSeparator
          }
        }
        emptyString = emptyString.reverse.replaceFirst(",","").reverse
        emptyString += "}," + Properties.lineSeparator
      })
    }
    emptyString = emptyString.reverse.replaceFirst(",","").reverse
    emptyString + "}"
  }
}
