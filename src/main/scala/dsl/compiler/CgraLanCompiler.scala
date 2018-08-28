// See README.md for license details.

package dsl.compiler

import dsl.IR._
import dsl.compiler.analyze.Analyze

trait CgraLanCompiler extends Execute
  with Analyze{

  def cgraCompile(codes:List[Any]):CgraModel = {

    val numLines : Int = codes.length
    var model : CgraModel = new CgraModel
    var Enviro : Env = new Env

    codes.foreach( line => {
      val currEnv:Env = new Env
      val currModel:CgraModel = new CgraModel
      val curr = analyzeLine(Enviro,line,model)
      Enviro = curr._1
      model = curr._2
      val foo = line
    })

    model
  }

}