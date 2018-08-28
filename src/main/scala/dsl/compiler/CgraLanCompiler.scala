// See README.md for license details.

package dsl.compiler

import dsl.IR._
import dsl.compiler.analyze.Analyze
import dsl.compiler.evaluate.Evaluate

trait CgraLanCompiler extends Evaluate
  with Execute
  with Analyze{

  def cgraCompile(codes:List[Any]):CgraModel = {

    val numLines : Int = codes.length
    var Enviro : Env = new Env

    codes.foreach( line => {
      Enviro = analyzeLine(Enviro,line)
      val foo = line
    })
    evaluateEnv(Enviro)
  }

}