package cgra.component

import chisel3._
import chisel3.util._
import cgra.config.fullinst._

class complex_alu(
                   data_width : Int,
                   instructions : List[String]
                 ) extends Module{

  // Internal Parameter
  private val num_operand = instructions.map(insts_prop(_).numOperands) max
  private val num_opcode = instructions.distinct.length
  private val max_latency = instructions.map(insts_prop(_).latency) max

  val io = IO(
    new Bundle{
      // Enable
      val en = Input(Bool())

      // Opcode
      val opcode = Input(UInt({log2Ceil(num_operand + 1) max 1}.W))

      // Operand
      val operands = Input(Vec(num_operand, UInt(data_width.W)))
      val operand_valid = Input(Bool())
      val operand_ready = Output(Bool())

      // Result
      val result = Output(UInt(data_width.W))
      val result_valid = Output(Bool())
      val result_ready = Input(Bool())
    }
  )
  // Opcode
  private val opcode : UInt = RegEnable(io.opcode, 0.U, io.en)

  // Operand
  private val operands : IndexedSeq[UInt] =
    io.operands.map(op => RegEnable(op,0.U,io.en))
  private val operand_valid : Bool = RegEnable(io.operand_valid,false.B,io.en)


  // Detect whether input changed
  private val input_changed : Bool =
    (operand_valid =/= io.operand_valid) ||
      (operands.zip(io.operands).map(p=>p._1 =/= p._2).reduce(_||_)) ||
      (opcode =/= io.opcode)

  // Latency count down
  private val latency_counter : UInt = RegInit(0.U({log2Ceil(max_latency) max 1}.W))

  // detect when is done
  private val finished : Bool = latency_counter === 0.U

  // Computing
  private val computing : Bool = io.en && operand_valid &&
    (!input_changed) && (!finished)

  // Computed
  private val computed : Bool = !computing

  // Result
  private val result : UInt = WireInit(0.U(data_width.W))
  io.result := result
  io.result_valid := computed

  // Next Operand
  io.operand_ready := computed && io.result_ready

  // Opcode
  val opcode2info : IndexedSeq[(UInt,(UInt,UInt,Int))] =
    (0 to num_opcode).map(opcode => {
      // Select instruction
      val instruction : String =
        if(opcode > 0) instructions(opcode - 1) else{"Pass"}

      // opcode zero is left for pass
      val res : UInt = {
        if(opcode > 0){
          val func = inst_operation(instruction)
          func(operands)
        }else operands.head}

      // Pass latency is 1
      val lat : UInt =
        if(opcode > 0) insts_prop(instruction).latency.U else 1.U

      val num : Int =
        if (opcode > 0) insts_prop(instruction).numOperands else 1

      opcode.U -> (res, lat, num)
    })

  // Calculate opcode dependent info
  val opcode2res = opcode2info.map(p=>p._1 -> p._2._1)
  val opcode2lat = opcode2info.map(p=>p._1 -> p._2._2)
  result := Mux(computed, MuxLookup(opcode, 0.U, opcode2res), 0.U)

  // FSM
  when(computing){
    // Counting down
    latency_counter:= latency_counter - 1.U
  }.otherwise{
    // restart computing
    latency_counter := MuxLookup(opcode, 0.U, opcode2lat)
  }

  // Debug
  // printf(p"ALU status : computing ? ${computing}, countdown = $latency_counter, " +
  //  p"Opcode = $opcode, Result = $result\n")
}

object gen_complex_alu extends App{
  chisel3.Driver.execute(args,()=>{
    val module = new complex_alu(64,
      List("Add","Mul"))
    println(module)
    module
  })
}
