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
      val opcode = Input(UInt({log2Ceil(num_opcode) max 1}.W))

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
  private val operand_valid : Bool = io.operand_valid.suggestName("operand_valid")
  private val operands : IndexedSeq[UInt] =
    io.operands.map(op => RegEnable(op,0.U,operand_valid).suggestName("operand"))


  // Detect whether input changed, Restart
  private val operands_changed : Bool = ((operands.zip(io.operands).map(p=>(p._1 =/= p._2)
    .suggestName("operand_changed")).reduce(_||_)))
    .suggestName("one_of_operand_changed")

  private val restart : Bool =
    ((operands_changed && operand_valid) || (opcode =/= io.opcode))
      .suggestName("restart")

  // Latency count down
  private val latency_counter : UInt =
    RegInit(0.U({log2Ceil(max_latency + 1) max 1}.W))
      .suggestName("latency_countdown")

  // detect when is done
  private val finished : Bool = (latency_counter === 0.U)
    .suggestName("finished")

  // Computing
  private val computing : Bool = (io.en && operand_valid && (!finished))
    .suggestName("computing")

  // Computed
  private val computed : Bool = (io.en && operand_valid && finished)
    .suggestName("computed")

  // Result
  private val result : UInt = WireInit(0.U(data_width.W))
  io.result := result
  io.result_valid := computed

  // Next Operand
  io.operand_ready := computed && io.result_ready

  // Opcode
  val opcode2info : IndexedSeq[(UInt,(UInt,UInt,Int))] =
    (0 until num_opcode).map(opcode => {
      // Select instruction
      val instruction : String =
        instructions(opcode)

      // opcode zero is left for pass
      val res : UInt = inst_operation(instruction)(operands)
        .suggestName(s"alu_res_${instruction}")

      // Pass latency is 1
      val lat : UInt = insts_prop(instruction).latency.U

      val num : Int = insts_prop(instruction).numOperands

      opcode.U -> (res(data_width - 1, 0), lat, num)
    })

  // Calculate opcode dependent info
  val opcode2res = opcode2info.map(p=>p._1 -> p._2._1)
  val opcode2lat = opcode2info.map(p=>p._1 -> p._2._2)
  result := Mux(computed, MuxLookup(opcode, 0.U, opcode2res), 0.U)
      .suggestName("alu_result")

  // FSM
  when((!io.en) || computed || restart){
    // restart computing
    latency_counter := MuxLookup(opcode, 0.U, opcode2lat)
  }.elsewhen(computing){
    // Counting down
    latency_counter:= latency_counter - 1.U
  }
}

object gen_complex_alu extends App{
  chisel3.Driver.execute(args,()=>{
    val module = new complex_alu(64,
      List("Add","Mul"))
    println(module)
    module
  })
}
