// See README.md for license details.

package dsl.compiler

import dsl.IR.{GridFUIR, GridRouterIR}
import dsl.library.FUClassInitializer

trait ClassInitializer{

  def classInitializer(classType:String,Properties:List[Any]):Any={
    classType match {
      case "Router" => new GridRouterIR
      case "FU" => val i = new FUClassInitializer;i.fuInitializer(Properties)
      case _ => throw new Exception("Class is not defined")
    }
  }

}