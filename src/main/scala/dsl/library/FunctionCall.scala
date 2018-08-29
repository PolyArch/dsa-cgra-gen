// See README.md for license details.

package dsl.library

import dsl.compiler.Env
import dsl.library.builtinFunction._

trait FunctionCall extends Env
  with builtinFunction
  {

  def functionCall(enVal:Function,enviro:Env)={

    val functionCalled = this.getClass.getDeclaredMethods()
      .filter(m=>m.getName == enVal.FunctionName.itemName)

    functionCalled.apply(0).invoke(this,enVal.FunctionArgs)
  }

  def getFunction(functionName:String)={
    super.getClass.getDeclaredField(functionName)
  }

}