// See README.md for license details.

package dsl.IR.build

import chisel3.util.isPow2
import dsl.IR._
import dsl.compiler._
import dsl.library._
import dsl.library.builtinClass.SwitchClass

trait RouterIRBuild extends Env
with FUIRModuleBuild{
  def buildRouterIRModule(switchVar:EnvVariable, model:CgraModel):CgraModel={
    var switchIR = new GridRouterIR

    switchIR.name = switchVar.Name

    val switchVarProper = switchVar.Entity.asInstanceOf[SwitchClass]
    if(switchVarProper.Input_Routing.isEmpty && switchVarProper.Output_Routing.isEmpty){
      throw new Exception("A Switch need to have at least input/output")
    }
    if(switchVarProper.Input_Routing.isEmpty){
      switchVarProper.Input_Routing = switchVarProper.Output_Routing
    }else if(switchVarProper.Output_Routing.isEmpty){
      switchVarProper.Output_Routing = switchVarProper.Input_Routing
    }
    switchVarProper.Input_Routing.foreach(inR=>{
      switchIR.inputLocation =
        switchIR.inputLocation :+ (inR.x,inR.y)
    })

    switchVarProper.Output_Routing.foreach(outR=>{
      switchIR.outputLocation =
        switchIR.outputLocation :+ (outR.x,outR.y)
    })

    switchIR.numInput = switchIR.inputLocation.length
    switchIR.numOutput = switchIR.outputLocation.length

    model.GridModuleIR = model.GridModuleIR :+ switchIR
    model
  }

  def buildRouterMuxDirMatrix (vari:EnvVariable,model:CgraModel,enviro:Env):CgraModel={
    for(row <- 0 until model.numRows;col <- 0 until model.numCols){

      model.GridIR(row)(col) match {
        case x:GridRouterIR =>
          val allMuxSelect = Array.fill[Boolean](x.numInput)(true)
          val muxDirMatrix = new Array[Array[Array[Boolean]]](x.numOutput)
          for(mM <- muxDirMatrix.indices) {
            val forEachSubNet = new Array[Array[Boolean]](x.deComp)
            for(i <- forEachSubNet.indices){
              forEachSubNet(i) = allMuxSelect
            }
            muxDirMatrix(mM) = forEachSubNet
          }
          x.muxDirMatrix = muxDirMatrix
        case _ =>
      }
    }
    RouterRequireMentCheck(vari,model,enviro)
  }

  def RouterRequireMentCheck (vari:EnvVariable,model:CgraModel,enviro:Env):CgraModel={
    for(row <- 0 until model.numRows;col <- 0 until model.numCols) {
      model.GridIR(row)(col) match {
        case x:GridRouterIR =>

          if(x.numInput!=x.inputLocation.length||x.numOutput!=x.outputLocation.length){
            val foo = ""
          }

          require(x.numInput==x.inputLocation.length)
          require(x.numOutput==x.outputLocation.length)

          // Requirement check
          require(x.numOutput==x.muxDirMatrix.length)
          for(subNet <- 0 until x.deComp){
            for (outPort <-0 until x.numOutput){
              require(x.numInput==x.muxDirMatrix(outPort)(subNet).length,"Mux select Matrix size mismatch")
              require(x.muxDirMatrix(outPort)(subNet).exists(p=>p),
                s"each output location need to have one input,Output $outPort Sec $subNet")
            }
            for (inPort <- 0 until x.numInput){
              require(x.numOutput==x.muxDirMatrix.map{_(subNet)(inPort)}.length,"Mux select Matrix size mismatch")

              if(!x.muxDirMatrix.map{_(subNet)(inPort)}.exists(p=>p)){
                val foo = ""
              }

              require(x.muxDirMatrix.map{_(subNet)(inPort)}.exists(p=>p),
                s"each input location need to have one output,Input $inPort Sec $subNet")
            }
          }
        case _=>
      }
    }
    buildMuxandCheckFU(vari,model,enviro)
  }

}