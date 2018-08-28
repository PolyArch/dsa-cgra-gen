// See README.md for license details.

package dsl.compiler

import dsl.IR.CgraModel
import dsl.lex._


trait analyze extends Env
  with execute{

  def analyzeLine(Enviro:Env,line: Any,model:CgraModel):(Env,CgraModel)={
    val lineType = line.getClass.toString.split(Array('.','$'))

    var currEnviro:Env = null
    var currModel:CgraModel = null

    line match {
      case line:ClassInstantiate =>
        val execResult = execClassInstantiate(Enviro,line,model)
        currEnviro = execResult._1
        currModel = execResult._2

      case line:Assign =>
        val execResult = execAssign(Enviro,line,model)
        currEnviro = execResult._1
        currModel = execResult._2

      case line:Connection =>
        val execResult = execConnection(Enviro,line,model)
        currEnviro = execResult._1
        currModel = execResult._2

      case _ => throw new Exception("Current version do not support such operation")
    }
    (currEnviro,currModel)
  }
}