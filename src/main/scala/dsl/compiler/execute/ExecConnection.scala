// See README.md for license details.
package dsl.compiler.execute

import dsl.IR.CgraModel
import dsl.compiler._

trait ExecConnection extends Env {

  def execConnection(Enviro:Env,line:Connection,model:CgraModel):(Env,CgraModel)={

    (Enviro,model)
  }

}