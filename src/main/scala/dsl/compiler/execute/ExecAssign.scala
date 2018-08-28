// See README.md for license details.
package dsl.compiler.execute

import dsl.IR.CgraModel
import dsl.compiler._
import dsl.lex._

trait ExecAssign extends Env
  {

  def execAssign(Enviro:Env,
                 line:Assign):Env={

    val assignTarget = line.AssignTarget
    val assignTargetName = assignTarget.itemName
    val assignFrom = line.AssignFrom

    val foo = line

    if(Enviro.VariableList.exists(i=>{
      i.Name == assignTarget.itemName
    })){
      assignFrom match {
        case fromItem:Item =>
          Enviro.VariableList.filter(v=>v.Name==assignTargetName).head.Entity=
            Enviro.VariableList.filter(v=>v.Name==fromItem.itemName).head.Entity
        case fromCollection:Collection =>
          Enviro.VariableList.filter(v=>v.Name==assignTargetName).head.Entity=
            assignFrom.asInstanceOf[Collection]
        case fromFuntion:Function=>
          Enviro.VariableList.filter(v=>v.Name==assignTargetName).head.Entity=
            assignFrom.asInstanceOf[Function]
        case fromLocation:Location =>
          Enviro.VariableList.filter(v=>v.Name==assignTargetName).head.Entity=
            assignFrom.asInstanceOf[Location]
        case _ => throw new Exception("can bot be assigned from this type : " + assignFrom.getClass)
      }
    }else{
      throw new Exception(assignTargetName + " is not existed")
    }
    Enviro
  }

}