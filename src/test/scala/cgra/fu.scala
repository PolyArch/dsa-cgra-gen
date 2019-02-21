// See README.md for license details.

package cgra.fu

import cgra._
import cgra.config._
import cgra.config.isa._
import cgra.fabric._
import dsl.IR._
import tile.tools._
import chisel3.iotesters
import chisel3.iotesters._
import tile._

import scala.util.Random

class DelayPipeTest(dP:DelayPipe,
                    delayPipeParam:DelayPipeParam) extends
  PeekPokeTester(dP){

  poke(dP.io.cfg_mode,true)
  poke(dP.io.delayLen,delayPipeParam.maxLength* 4 / 5)
  step(1)

  for(cycle <- 1 until 50){
    val cfg_mode = false
    val delayLength = Random.nextInt(delayPipeParam.maxLength + 1)
    val input_bits = BigInt(delayPipeParam.pipeDataWidth,Random)
    val input_valid = Random.nextBoolean()
    val output_ready = Random.nextBoolean()

    poke(dP.io.cfg_mode,cfg_mode)
    poke(dP.io.delayLen,delayLength)
    poke(dP.io.input_ports.bits,input_bits)
    poke(dP.io.input_ports.valid,input_valid)
    poke(dP.io.output_ports.ready,output_ready)
    // Debug
    println("Config mode = " + cfg_mode)
    println("Delay Length = " + delayLength)
    println("Input bits = " + input_bits)
    println("Input bits binary = " + input_bits.toString(2))
    println("Input valid = " + input_valid)
    println("Output ready = " + output_ready)

    // tic
    step(1)
    println("The end of cycle " + cycle)

    //Expect

    println("---------------------------------")
  }
}
object DelayPipeTest extends App{
  for(repeat <- 0 until 10){
    val delayPipeParam = new DelayPipeParam
    delayPipeParam.maxLength = Random.nextInt(17)
    delayPipeParam.pipeDataWidth = Random.nextInt(65)
    if(delayPipeParam.pipeDataWidth == 0)
      delayPipeParam.pipeDataWidth = 1
    println("Max Length = " + delayPipeParam.maxLength)
    println("pipe data width = " + delayPipeParam.pipeDataWidth)
    iotesters.Driver.execute(args,() =>
      new DelayPipe(delayPipeParam.maxLength,delayPipeParam.pipeDataWidth)){
      dP => new DelayPipeTest(dP,delayPipeParam)
    }
  }
}

class AluTest(alu: ALU, aluParam: AluParam) extends PeekPokeTester(alu)
{
  val aluDataWidth = aluParam.aluDataWidth
  val aluInst = aluParam.InstructionList
  for (cycle <- 0 until 100){
    val rnd = Random
    val op1Valid = Random.nextBoolean()
    val op2Valid = Random.nextBoolean()
    val op1Bits = BigInt(aluDataWidth,rnd)
    val op2Bits = {
      var op2B = BigInt(0)
      while(op2B==0)op2B = BigInt(aluDataWidth,rnd);op2B
    }
    val opcode = aluInst(Random.nextInt(aluInst.length))
    val reReady = Random.nextBoolean

    poke(alu.io.operand1.bits,op1Bits)
    poke(alu.io.operand2.bits,op2Bits)
    poke(alu.io.operand1.valid,op1Valid)
    poke(alu.io.operand2.valid,op2Valid)
    poke(alu.io.opcode,opcode)
    poke(alu.io.output_ports.ready,reReady)

    // Calculate take-in bits (limited by AluDataWidth)
    val op1BitsBinary:String = op1Bits.toString(2)
    val op2BitsBinary:String = op2Bits.toString(2)

    // Debug
    aluParam.printString
    println("Operand 1 Bits " + op1Bits)
    println("Operand 2 Bits " + op2Bits)
    println("Operand 1 Bits in Binary " + op1BitsBinary)
    println("Operand 2 Bits in Binary " + op2BitsBinary)
    println("Operand 1 Valid " + op1Valid)
    println("Operand 2 Valid " + op2Valid)
    println("Opcode " + opcode)
    println("Output Ready " + reReady)
    println("End of cycle " + cycle)
    step(1)

    // Expect
    if(reReady){
      expect(alu.io.operand1.ready,true)
      expect(alu.io.operand2.ready,true)
    }else{
      expect(alu.io.operand1.ready,false)
      expect(alu.io.operand2.ready,false)
    }

    if(op1Valid && op2Valid){
      val opcodeName = isa.getClass.getDeclaredFields
        .find(field=>{
          field.setAccessible(true)
          field.get(isa) == opcode
        }) match {
        case Some(i) => i.getName
        case _ => throw new Exception("No match opcode")
      }

      val op1BigInt = BigInt(op1BitsBinary,2)
      val op2BigInt = BigInt(op2BitsBinary,2)
      val expectedResult = calculateAluResult(
        opcodeName,
        op1BigInt,op2BigInt,
        aluDataWidth)

      expect(alu.io.output_ports.valid,true)
      expect(alu.io.output_ports.bits,expectedResult)
    }else{
      expect(alu.io.output_ports.valid,false)
      expect(alu.io.output_ports.bits,0)
    }
    println("---------------------------------")
  }
}
object AluTest extends App {
  for (repeat <- 0 until 10)
  {
    val aluParam = new AluParam

    var numInst = Random.nextInt(numISA)
    if (numInst <= 0) numInst = 1
    aluParam.InstructionList = Seq.fill(numInst)(Random.nextInt(numISA))
      .toArray.distinct.sorted

    aluParam.aluDataWidth = Random.nextInt(2049)
    if (aluParam.aluDataWidth <= 0) aluParam.aluDataWidth = 1

    iotesters.Driver.execute(args, () =>
      new ALU(aluParam.InstructionList, aluParam.aluDataWidth)) {
      c => new AluTest(c, aluParam)
    }
  }
}

class FuTest(c: Function_Unit, params:GridFUIR ) extends PeekPokeTester(c)
  with HasFabricParams {
  private val fu = c
  for(cycle <- 0 until 100){
    for (inPortIndex <- 0 until params.numInput) {
      val pokeBits = getRandomBits
      val pokeValid = getRandomBoolean
      poke(fu.io.input_ports(inPortIndex).bits, pokeBits)
      poke(fu.io.input_ports(inPortIndex).valid, pokeValid)
      println("InputPort-"+inPortIndex+"-bits-"+pokeBits+"-valid-"+pokeValid)
    }
    for (outPortIndex <- 0 until params.numOutput){
      poke(fu.io.output_ports(outPortIndex).ready,true)
    }
    step(1)
    println("End of cycle " + cycle)
  }
}
object FuTest extends App {

  var param = new GridFUIR
  param.numInput = 4
  param.numOutput = 4
  param.inputLocation = Array((1,0),(0,1),(-1,0),(0,-1)).toList
  param.outputLocation = Array((1,0),(0,1),(-1,0),(0,-1)).toList
  param.deComp = 4
  param.Instructions = Array(
    Array(Array(0,1,2),Array(0,1,2),Array(0,1,2),Array(0,1,2)),
    Array(Array(1,2),Array(0,1,2),Array(0,1,2),Array(0)),
    Array(Array(0,1,2),Array(0,1,2),Array(0,2),Array(0,1,2)),
    Array(Array(0,1),Array(0,2),Array(0,1,2),Array(0,2))
  )
  param.maxDelayPipeLen = Array(
    Array(Array(4,3),Array(2,6),Array(1,7),Array(3,3)),
    Array(Array(1,7),Array(1,2),Array(0,5),Array(0,0)),
    Array(Array(1,2),Array(0,5),Array(2,6),Array(1,7)),
    Array(Array(0,5),Array(2,6),Array(1,7),Array(1,2))
  )
  param.muxDirMatrix = Array(
    Array(
      Array(Array(false,true,false,true),Array(true, false, true, false)),
      Array(Array(false,true,false,true),Array(false,true,false,true)),
      Array(Array(true, false, true, false),Array(true, false, true, false)),
      Array(Array(true,false,false,true),Array(true, false, true, false))),
    Array(
      Array(Array(false,true,false,true),Array(true, false, true, false)),
      Array(Array(false,true,false,true),Array(false,true,false,true)),
      Array(Array(true, false, true, false),Array(true, false, true, false)),
      Array(Array(true,false,false,true),Array(true, false, true, false))),
    Array(
      Array(Array(false,true,false,true),Array(false,true,false,true)),
      Array(Array(true, false, true, false),Array(true, false, true, false)),
      Array(Array(true, true, true, true),Array(true, false, true, false)),
      Array(Array(true,true,true,true),Array(true, false, true, false))),
    Array(
      Array(Array(true, false, true, false),Array(true, false, true, false)),
      Array(Array(true, false, true, false),Array(true, false, true, false)),
      Array(Array(true, false, true, false),Array(true, true, true, false)),
      Array(Array(true,false,false,true),Array(true, false, true, false)))
  )

  iotesters.Driver.execute(args, () =>
    new Function_Unit(param.numInput,param.numOutput,param.inputLocation.toArray,
      param.outputLocation.toArray,param.deComp,
      param.Instructions,param.maxDelayPipeLen,param.muxDirMatrix,0,0))
  {
    c => new FuTest(c,param)
  }

}

// Parameter
class AluParam {
  var InstructionList: Array[Int] = _
  var aluDataWidth: Int = -1
  def printString :Unit ={
    println("Alu Data Width " + aluDataWidth)
    print("Inst. List ")
    InstructionList.foreach(i=>{print(i + " ")});print("\n")
  }
}
class DelayPipeParam{
  var maxLength:Int = -1
  var pipeDataWidth:Int = -1
}