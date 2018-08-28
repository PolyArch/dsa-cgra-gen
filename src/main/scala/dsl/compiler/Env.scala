// See README.md for license details.

package dsl.compiler

import dsl.lex._
import dsl.syx.CgraLan

class Env extends CgraLan{

  var VariableList : List[EnvVariable] = List()

  var ConnectionList : List[EnvConnection] = List()

  class EnvVariable {
    var Name:String = ""
    var Type:String = ""
    var Entity:Any = _
  }

  class EnvAssignment {
    val VarOperated = new EnvVariable
    val VarOperating:Any = null
    val OperationType :String = "="
  }

  class EnvConnection {
    var VarTo:Item = _
    var VarFrom:Item = _
    var ConnectionFeature :String = ""
  }

}