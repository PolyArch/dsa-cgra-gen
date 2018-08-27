// See README.md for license details.

package dsl.compiler

import dsl.IR._

trait CgraLanCompiler extends execute{

  def cgraCompile(codes:List[Any]):CgraModel = {

    val numLines : Int = codes.length
    var model : CgraModel = new CgraModel
    var Enviro : Env = new Env


    codes.foreach( line => {
      val lineType = line.getClass

      if (lineType.getName.contains("ClassDefine")){
        val (currEnviro:Env,currModel:CgraModel) = execClassDefine(Enviro,line.asInstanceOf[ClassDefine],model)
        model = currModel
        Enviro = currEnviro
      }

      if (lineType.getName.contains("Assign")){
        val (currEnviro:Env,currModel:CgraModel) = execAssign(Enviro,line.asInstanceOf[Assign],model)
        model = currModel
        Enviro = currEnviro
      }

      if (lineType.getName.contains("Connection")){
        val (currEnviro:Env,currModel:CgraModel) = execConnection(Enviro,line.asInstanceOf[Connection],model)
        model = currModel
        Enviro = currEnviro
      }

      val foo = lineType
    })

    model
  }

}