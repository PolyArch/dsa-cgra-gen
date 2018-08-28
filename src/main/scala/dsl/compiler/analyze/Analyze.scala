// See README.md for license details.

package dsl.compiler.analyze

import dsl.IR.CgraModel
import dsl.compiler.{Env, Execute}
import dsl.lex._


trait Analyze extends Env
  with Execute{

  def analyzeLine(Enviro:Env,line: Any,model:CgraModel):(Env,CgraModel)={

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