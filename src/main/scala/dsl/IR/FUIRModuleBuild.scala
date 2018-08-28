// See README.md for license details.

package dsl.IR

import dsl.compiler._
import dsl.library._
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


    val delaypipelen = Array(2,2)
    //TODO: Specify max Delay Pipe for each FIFO
    fuIR.maxDelayPipeLen = new Array[Array[Array[Int]]](fuIR.numOutput)
    for(outPort <- fuIR.maxDelayPipeLen.indices){
      fuIR.maxDelayPipeLen(outPort) = new Array[Array[Int]](fuIR.deComp)
      for(subNet <- fuIR.maxDelayPipeLen(outPort).indices){
        fuIR.maxDelayPipeLen(outPort)(subNet) = delaypipelen
      }
    }

    val muxDir = Array.fill[Boolean](fuIR.numInput)(true)
    //TODO: Specify MUX Direction for each MUX
    fuIR.muxDirMatrix = new Array[Array[Array[Array[Boolean]]]](fuIR.numOutput)
    for(outPort <- fuIR.muxDirMatrix.indices){
      fuIR.muxDirMatrix(outPort) = new Array[Array[Array[Boolean]]](fuIR.deComp)
      for(subNet <- fuIR.muxDirMatrix(outPort).indices){
        fuIR.muxDirMatrix(outPort)(subNet) = new Array[Array[Boolean]](2)
        for(operand <- 0 until 2){
          fuIR.muxDirMatrix(outPort)(subNet)(operand) = muxDir
        }
      }
    }


    model.GridModuleIR = model.GridModuleIR :+ fuIR
    model
  }
}
