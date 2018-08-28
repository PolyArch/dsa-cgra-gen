// See README.md for license details.
package dsl.compiler.execute

import dsl.IR.CgraModel
import dsl.compiler._

trait ExecAssign extends Env
  {

  def execAssign(Enviro:Env,
                 line:Assign,
                 model:CgraModel):(Env,CgraModel)={

    val assignTarget = line.AssignTarget
    val assignTargetName = assignTarget.itemName
    val assignFrom = line.AssignFrom

    if(Enviro.VariableList.exists(i=>{
      i.Name == assignTarget.itemName
    })){

    }else{
      throw new Exception(assignTargetName + " is not existed")
    }

    (Enviro,model)
  }

}