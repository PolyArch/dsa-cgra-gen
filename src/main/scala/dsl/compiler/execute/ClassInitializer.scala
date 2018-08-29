// See README.md for license details.

package dsl.compiler.execute

import dsl.IR.{GridFUIR, GridRouterIR}
import dsl.library._
import dsl.library.builtinClass._

trait ClassInitializer{

  def classInitializer(classType:String,Properties:List[Any]):Any={
    classType match {
      case "Router" => var i = new SwitchClassInitializer;i.initializer(Properties)
      case "FU" => var i = new FUClassInitializer;i.initializer(Properties)
      case "CGRA" =>  var i = new CGRAClassInitializer;i.initializer(Properties)
      case _ => throw new Exception("Class is not defined")
    }
  }
}