// See README.md for license details.
package dsl.compiler.execute

import dsl.IR.CgraModel
import dsl.compiler._
import dsl.lex.Item

trait ExecConnection extends Env {

  def execConnection(Enviro:Env,line:Connection):Env={
    val connectTos :List[Item]= line.toPort
    val connectFroms :List[Item]= line.fromPort
    val connectFeature :String= line.ConnectionFeature

    connectTos.foreach(to=>{
      connectFroms.foreach(from=>{
        Enviro.ConnectionList =
          Enviro.ConnectionList :+ new Enviro.EnvConnection{
          VarFrom = from
          VarTo = to
          ConnectionFeature = connectFeature
        }
      })
    })



    Enviro
  }

}