// See README.md for license details.

package dsl.IR.build

import dsl.IR._
import dsl.compiler._
import dsl.library.builtinClass.FUClass
import tile.isa

trait FUIRModuleBuild extends Env{
  def buildFUIRModule(fuVar:EnvVariable, model:CgraModel):CgraModel={
    var fuIR = new GridFUIR

    fuIR.name = fuVar.Name

    val fuVarProper = fuVar.Entity.asInstanceOf[FUClass]
    if(fuVarProper.Input_Routing.isEmpty && fuVarProper.Output_Routing.isEmpty){
      throw new Exception("A FU need to have at least input/output")
    }
    if(fuVarProper.Input_Routing.isEmpty){
      fuVarProper.Input_Routing = fuVarProper.Output_Routing
    }else if(fuVarProper.Output_Routing.isEmpty){
      fuVarProper.Output_Routing = fuVarProper.Input_Routing
    }
    fuVarProper.Input_Routing.foreach(inR=>{
      fuIR.inputLocation =
        fuIR.inputLocation :+ (inR.x,inR.y)
    })

    fuVarProper.Output_Routing.foreach(outR=>{
      fuIR.outputLocation =
        fuIR.outputLocation :+ (outR.x,outR.y)
    })

    fuIR.numInput = fuIR.inputLocation.length
    fuIR.numOutput = fuIR.outputLocation.length

    if(fuVarProper.Decomposability.isNaN){
      fuIR.deComp = 1
    }else{
      fuIR.deComp = fuVarProper.Decomposability
    }


    var opcodeList :List[Int] = List()
    if(fuVarProper.Opcodes isEmpty){
      throw new Exception("FU needs opcodes")
    }else{
      fuVarProper.Opcodes.foreach(op=>{
        val opC = op.split(Array('_','x'))
        val opcode = opC(0)
        val bidWidth = opC(1)
        val deOp:Int = {
          if(opC.length > 2) opC(2).toInt
          else 1
        }
        val opEncodeField = isa.getClass.getDeclaredField(opcode)
        opEncodeField.setAccessible(true)
        val opencode :Int = opEncodeField.get(isa).asInstanceOf[Int]
        opcodeList = opcodeList :+ opencode
        fuIR.deComp = fuIR.deComp max deOp
      })
    }

    //TODO: Specify opcode for each ALU
    fuIR.Instructions = new Array[Array[Array[Int]]](fuIR.numOutput)
    for(outPort <- fuIR.Instructions.indices){
      fuIR.Instructions(outPort) = new Array[Array[Int]](fuIR.deComp)
      for(subNet <- fuIR.Instructions(outPort).indices){
        fuIR.Instructions(outPort)(subNet) = opcodeList.toArray
      }
    }





    model.GridModuleIR = model.GridModuleIR :+ fuIR
    model
  }

  def buildMuxandCheckFU(vari:EnvVariable,model:CgraModel,enviro:Env):CgraModel={


    for(row <- 0 until model.numRows;col <- 0 until model.numCols) {
      model.GridIR(row)(col) match {
        case x:GridFUIR =>

          if(x.numInput!=x.inputLocation.length||x.numOutput!=x.outputLocation.length){
            val foo = ""
          }

          require(x.numInput==x.inputLocation.length)
          require(x.numOutput==x.outputLocation.length)

          val opcodeList = x.Instructions(0)(0)
          x.Instructions = new Array[Array[Array[Int]]](x.numOutput)
          for(outPort <- 0 until x.numOutput){
            x.Instructions(outPort) = new Array[Array[Int]](x.deComp)
            for(subNet <- 0 until x.deComp){
              x.Instructions(outPort)(subNet) = opcodeList.distinct
            }
          }


          val delaypipelen = Array(2,2)
          //TODO: Specify max Delay Pipe for each FIFO
          x.maxDelayPipeLen = new Array[Array[Array[Int]]](x.numOutput)
          for(outPort <- x.maxDelayPipeLen.indices){
            x.maxDelayPipeLen(outPort) = new Array[Array[Int]](x.deComp)
            for(subNet <- x.maxDelayPipeLen(outPort).indices){
              x.maxDelayPipeLen(outPort)(subNet) = delaypipelen
            }
          }

          val muxDir = Array.fill[Boolean](x.numInput)(true)
          //TODO: Specify MUX Direction for each MUX
          x.muxDirMatrix = new Array[Array[Array[Array[Boolean]]]](x.numOutput)
          for(outPort <- x.muxDirMatrix.indices){
            x.muxDirMatrix(outPort) = new Array[Array[Array[Boolean]]](x.deComp)
            for(subNet <- x.muxDirMatrix(outPort).indices){
              x.muxDirMatrix(outPort)(subNet) = new Array[Array[Boolean]](2)
              for(operand <- 0 until 2){
                x.muxDirMatrix(outPort)(subNet)(operand) = muxDir
              }
            }
          }

          require(x.numOutput == x.muxDirMatrix.length)
          for (subNet <- 0 until x.deComp) {
            for (outPort <- 0 until x.numOutput; operand <- 0 until 2) {
              if(x.numInput != x.muxDirMatrix(outPort)(subNet)(operand).length){
                val foo = ""
              }

              //TODO find the reason for this
              if(x.numInput != x.muxDirMatrix(outPort)(subNet)(operand).length){
                x.muxDirMatrix(outPort)(subNet)(operand) = Array.fill[Boolean](x.numInput)(true)
              }

              require(x.numInput == x.muxDirMatrix(outPort)(subNet)(operand).length, "Mux select Matrix size mismatch")
              require(x.muxDirMatrix(outPort)(subNet)(operand).exists(p => p), s"each output location need to have one input,Output ${outPort + 1} Sec ${subNet + 1}")
            }
            for (inPort <- 0 until x.numInput; operand <- 0 until 2) {
              require(x.numOutput == x.muxDirMatrix.map {
                _ (subNet)(operand)(inPort)
              }.length, "Mux select Matrix size mismatch")
              require(x.muxDirMatrix.flatMap {
                _ (subNet)
              }.map {
                _ (inPort)
              }.exists(p => p), s"each input location need to have one output,Input ${inPort + 1} Sec ${subNet + 1}")
            }
          }
        case _=>
      }
    }



    model
  }
}
