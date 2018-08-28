// See README.md for license details.

package dsl.compiler.analyze

import dsl.IR.CgraModel
import dsl.compiler.{Env, Execute}
import dsl.lex._


trait Analyze extends Env
  with Execute{

  def analyzeLine(Enviro:Env,line: Any):Env={

    var currEnviro:Env = null

    line match {
      case line:ClassInstantiate =>
        currEnviro = execClassInstantiate(Enviro,line)

      case line:Assign =>
        currEnviro = execAssign(Enviro,line)

      case line:Connection =>
        currEnviro = execConnection(Enviro,line)

      case _ => throw new Exception("Current version do not support such operation")
    }
    currEnviro
  }
}