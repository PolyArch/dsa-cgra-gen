// See README.md for license details.

package dsl.compiler

import dsl.IR.CgraModel
import dsl.syx.CgraLan


trait execute extends Env
  with CgraLan{
  def execClassDefine(Enviro:Env,line:ClassDefine,model:CgraModel)={

    val instanClass:Item = line.ClassDefineTarget
    val classType:Item = line.ClassDefineFrom.ClassType
    val classMember:List[Any] = line.ClassDefineFrom.ClassMembers

    (Enviro,model)
  }

  def execAssign(Enviro:Env,line:Assign,model:CgraModel)={

    (Enviro,model)
  }

  def execConnection(Enviro:Env,line:Connection,model:CgraModel)={

    (Enviro,model)
  }
}

class Env {

}