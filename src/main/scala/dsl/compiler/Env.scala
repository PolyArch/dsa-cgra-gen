// See README.md for license details.

package dsl.compiler

import dsl.syx.CgraLan

class Env extends CgraLan{

  var VariableList : List[EnvVariable] = List()

  var ConnectionList : List[(String,String)] = List()

  class EnvVariable {
    var Name:String = ""
    var Type:String = ""
    var Entity:Any = _
  }

  class Assignment {
    val VarOperated = new EnvVariable
    val VarOperating:Any = null
    val OperationType :String = "="
  }

  class Connection {
    val VarOperated = new EnvVariable
    val VarOperating = new EnvVariable
    val OperationType :String = ""
  }

}