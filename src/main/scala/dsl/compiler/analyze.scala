// See README.md for license details.

package dsl.compiler

import dsl.IR.CgraModel


trait analyze extends Env
with execute{

  def analyzeLine(Enviro:Env,line: Any,model:CgraModel):(Env,CgraModel)={
    val lineType = line.getClass.toString.split(Array('.','$'))

    var currEnviro:Env = null
    var currModel:CgraModel = null

    if (lineType.contains("CgraLanClassInstantiate")){
        val execResult = execClassInstantiate(Enviro,line.asInstanceOf[ClassInstantiate],model)
        currEnviro = execResult._1
        currModel = execResult._2
    }

    if (lineType.contains("CgraLanAssignment")){
      val execResult = execAssign(Enviro,line.asInstanceOf[Assign],model)
      currEnviro = execResult._1
      currModel = execResult._2
    }

    if (lineType.contains("CgraLanConnection")){
      val execResult = execConnection(Enviro,line.asInstanceOf[Connection],model)
      currEnviro = execResult._1
      currModel = execResult._2
    }
    (currEnviro,currModel)
  }

}