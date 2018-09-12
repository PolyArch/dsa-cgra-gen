// See README.md for license details.

package dsl.IR.IRoutput

import dsl.IR._

import scala.util.Properties

trait irOutput extends outputConnectionIR
  with outputGridIR{

  def cleanModel(model:CgraModel):CgraModel={
    val moduleName:Array[String] = model.GridIR.flatten.filter(_!=null).map(_.name).distinct

    for(mNameI <- moduleName.indices){
      val mName = moduleName(mNameI)
      val targetModules = model.GridIR.flatten.filter(_!=null).filter(_.name==mName)
      if(targetModules.length > 1){
        for(tNameI <- targetModules.indices){
          targetModules(tNameI).name += ("_dup_" + tNameI)
        }
      }
    }
    val numModule = model.GridIR.flatten.count(_!=null)
    val numModuleName = model.GridIR.flatten.filter(_!=null).map(_.name).distinct.length
    require(numModule == numModuleName)

    val foo=""
    model
  }

  def irOutput(model: CgraModel): String ={
    "{" + "\"numRows\":" + model.numRows + "," + Properties.lineSeparator +
      "\"numCols\":" + model.numCols + "," + Properties.lineSeparator +
      outputGridIR(model) + "," + Properties.lineSeparator+
      outputConnectionIR(model) +
      "}"
  }
}
