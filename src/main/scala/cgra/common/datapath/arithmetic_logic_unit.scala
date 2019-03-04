
package cgra.common.datapath

import cgra.common.Instructions.Instructions
import cgra.tia.datapath.floatpoint._
import cgra.tia.parameters.derived_parameters._
import chisel3._
import chisel3.util._

class arithmetic_logic_unit(word_width:Int,
                            inst_list:List[Int]) extends Module
  with Instructions {

  val op_width = log2Ceil(inst_list.length)

  val io = IO(
    new Bundle {
      val opcode = Input(UInt(op_width.W))
      val operands = Input(Vec(TIA_NUM_OPERANDS,UInt(word_width.W)))
      val result = Output(UInt(word_width.W))
    }
  )

  // Connect result with output
  val op:UInt = Wire(UInt(op_width.W))
  op := io.opcode

  // Signed operand
  val operand0_signed = Wire(SInt(word_width.W))
  val operand1_signed = Wire(SInt(word_width.W))
  val operand2_signed = Wire(SInt(word_width.W))
  // Unsigned operand
  val operand0_unsigned = Wire(UInt(word_width.W))
  val operand1_unsigned = Wire(UInt(word_width.W))
  val operand2_unsigned = Wire(UInt(word_width.W))
  //Signed Result
  val result_signed = Wire(SInt(word_width.W))
  val result_unsigned = Wire(UInt(word_width.W))
  result_signed := 0.S;result_unsigned := 0.U

  // connect input
  operand0_unsigned <> io.operands(0)
  operand1_unsigned <> io.operands(1)
  operand2_unsigned <> io.operands(2)
  operand0_signed := io.operands(0).asSInt()
  operand1_signed := io.operands(1).asSInt()
  operand2_signed := io.operands(2).asSInt()

  //default output
  result_signed := 0.S
  result_unsigned := 0.U

  // generate signed result
  if (inst_list.intersect(signed_insts_list).nonEmpty){
    if (inst_list.contains(TIA_OP_ASR)) when(op === TIA_OP_ASR.U){result_signed := operand0_signed >> operand1_unsigned}
    if (inst_list.contains(TIA_OP_SGT)) when(op === TIA_OP_SGT.U){result_signed := (operand0_signed > operand1_signed).asSInt()}
    if (inst_list.contains(TIA_OP_SLT)) when(op === TIA_OP_SLT.U){result_signed := (operand0_signed < operand1_signed).asSInt()}
    if (inst_list.contains(TIA_OP_SGE)) when(op === TIA_OP_SGE.U){result_signed := (operand0_signed >= operand1_signed).asSInt()}
    if (inst_list.contains(TIA_OP_SLE)) when(op === TIA_OP_SLE.U){result_signed := (operand0_signed <= operand1_signed).asSInt()}
  }


  // generate unsigned result
  val logical_operand0_unsigned:Bool = operand0_unsigned =/= 0.U
  val logical_operand1_unsigned:Bool = operand1_unsigned =/= 0.U
  val logical_operand2_unsigned:Bool = operand2_unsigned =/= 0.U
  if (inst_list.intersect(unsigned_insts_list).nonEmpty){
    if (inst_list.contains(TIA_OP_NOP)) when(op ===TIA_OP_NOP.U){result_unsigned := 0.U}
    if (inst_list.contains(TIA_OP_MOV)) when(op ===TIA_OP_MOV.U){result_unsigned := operand0_unsigned}
    if (inst_list.contains(TIA_OP_ADD)) when(op ===TIA_OP_ADD.U){result_unsigned := operand0_unsigned + operand1_unsigned}
    if (inst_list.contains(TIA_OP_SUB)) when(op ===TIA_OP_SUB.U){result_unsigned := operand0_unsigned - operand1_unsigned}
    if (inst_list.contains(TIA_OP_LSL)) when(op ===TIA_OP_LSL.U){result_unsigned := operand0_unsigned << operand1_unsigned(18,0)}
    if (inst_list.contains(TIA_OP_LSR)) when(op ===TIA_OP_LSR.U){result_unsigned := operand0_unsigned >> operand1_unsigned}
    if (inst_list.contains(TIA_OP_EQ)) when(op ===TIA_OP_EQ.U){result_unsigned := operand0_unsigned === operand1_unsigned}
    if (inst_list.contains(TIA_OP_NE)) when(op ===TIA_OP_NE.U){result_unsigned := operand0_unsigned =/= operand1_unsigned}
    if (inst_list.contains(TIA_OP_UGT)) when(op ===TIA_OP_UGT.U){result_unsigned := operand0_unsigned > operand1_unsigned}
    if (inst_list.contains(TIA_OP_ULT)) when(op ===TIA_OP_ULT.U) {result_unsigned := operand0_unsigned < operand1_unsigned}
    if (inst_list.contains(TIA_OP_UGE)) when(op ===TIA_OP_UGE.U){result_unsigned := operand0_unsigned >= operand1_unsigned}
    if (inst_list.contains(TIA_OP_ULE)) when(op ===TIA_OP_ULE.U){result_unsigned := operand0_unsigned <= operand1_unsigned}
    if (inst_list.contains(TIA_OP_BAND)) when(op ===TIA_OP_BAND.U){result_unsigned := operand0_unsigned & operand1_unsigned}
    if (inst_list.contains(TIA_OP_BNAND)) when(op ===TIA_OP_BNAND.U){result_unsigned := ~(operand0_unsigned & operand1_unsigned)}
    if (inst_list.contains(TIA_OP_BOR)) when(op ===TIA_OP_BOR.U){result_unsigned := operand0_unsigned | operand1_unsigned}
    if (inst_list.contains(TIA_OP_BNOR)) when(op ===TIA_OP_BNOR.U){result_unsigned := ~(operand0_unsigned | operand1_unsigned)}
    if (inst_list.contains(TIA_OP_BXOR)) when(op ===TIA_OP_BXOR.U){result_unsigned := operand0_unsigned ^ operand1_unsigned}
    if (inst_list.contains(TIA_OP_BXNOR)) when(op ===TIA_OP_BXNOR.U){result_unsigned := ~(operand0_unsigned ^ operand1_unsigned)}
    if (inst_list.contains(TIA_OP_LAND)) when(op ===TIA_OP_LAND.U){result_unsigned := logical_operand0_unsigned && logical_operand1_unsigned}
    if (inst_list.contains(TIA_OP_LNAND)) when(op ===TIA_OP_LNAND.U){result_unsigned := !(logical_operand0_unsigned && logical_operand1_unsigned)}
    if (inst_list.contains(TIA_OP_LOR)) when(op ===TIA_OP_LOR.U){result_unsigned := logical_operand0_unsigned || logical_operand1_unsigned}
    if (inst_list.contains(TIA_OP_LNOR)) when(op ===TIA_OP_LNOR.U){result_unsigned := !(logical_operand0_unsigned || logical_operand1_unsigned)}
    if (inst_list.contains(TIA_OP_LXOR)) when(op ===TIA_OP_LXOR.U){result_unsigned := !logical_operand0_unsigned ^ !logical_operand1_unsigned}
    if (inst_list.contains(TIA_OP_LXNOR)) when(op ===TIA_OP_LXNOR.U){result_unsigned := !(!logical_operand0_unsigned ^ !logical_operand1_unsigned)}
    if (inst_list.contains(TIA_OP_GB)) when(op ===TIA_OP_GB.U){result_unsigned := operand0_unsigned(operand1_unsigned)}
    if (inst_list.contains(TIA_OP_SB)) when(op ===TIA_OP_SB.U){
      when(logical_operand2_unsigned){
        result_unsigned := operand0_unsigned | (1.U << operand1_unsigned(18,0)).asUInt
      }.otherwise {
        result_unsigned := operand0_unsigned & (~(1.U << operand1_unsigned(18,0))).asUInt
      }
    }
    if (inst_list.contains(TIA_OP_CB)) when(op ===TIA_OP_CB.U){result_unsigned := operand0_unsigned & (~(1.U << operand1_unsigned(18,0))).asUInt}
    if (inst_list.contains(TIA_OP_MB)) when(op ===TIA_OP_MB.U){result_unsigned := operand0_unsigned | (1.U << operand1_unsigned(18,0)).asUInt}
    if (inst_list.contains(TIA_OP_CLZ)) when(op ===TIA_OP_CLZ.U){
      when(operand0_unsigned === 0.U){
        result_unsigned := word_width.U
      }.otherwise{
        result_unsigned := PriorityEncoder(Reverse(operand0_unsigned))
      }
    }
    if (inst_list.contains(TIA_OP_CTZ)) when(op ===TIA_OP_CTZ.U){
      when(operand0_unsigned === 0.U) {
        result_unsigned := word_width.U
      }.otherwise{
        result_unsigned := PriorityEncoder(operand0_unsigned)
      }
    }
    if (inst_list.contains(TIA_OP_HALT)) when(op ===TIA_OP_HALT.U){
      result_unsigned := 0.U
    }
  }

  // generate float point result
  val fpResult = Wire(UInt(word_width.W))
  fpResult := 0.U
  if(inst_list.intersect(float_insts_list).nonEmpty)
    {
      if (inst_list.contains(TIA_OP_FADD)){
        val fpAdder = Module(new FPAdd(word_width))
        fpAdder.io.a := io.operands(0)
        fpAdder.io.b := io.operands(1)
        when(op === TIA_OP_FADD.U){
          fpResult := fpAdder.io.res
        }
      }
      if (inst_list.contains(TIA_OP_FMUL)){
        val fpMultiplier = Module(new FPMult(word_width))
        fpMultiplier.io.a := io.operands(0)
        fpMultiplier.io.b := io.operands(1)
        when(op === TIA_OP_FMUL.U){
          fpResult := fpMultiplier.io.res
        }
      }
    }

  when(unsigned_insts.exists(_ === op)){
    io.result := result_unsigned
  } .elsewhen( signed_insts.exists( _ === op)){
    io.result := result_signed.asUInt()
  } .elsewhen(float_insts.exists(_ === op)){
    io.result := fpResult
  } .otherwise {
    io.result := 0.U
  }

  printf(p"opcode = ${io.opcode}\n")
  printf(p"operand 0 = ${io.operands(0)}\n")
  printf(p"operand 1 = ${io.operands(1)}\n")
  printf(p"operand 2 = ${io.operands(2)}\n")
  printf(p"result = ${io.result}\n")
  printf("-----------------------------------\n")

}

object AluDriver extends App
{
  chisel3.Driver.execute(args, () => new arithmetic_logic_unit(64,List(1,3,4,6,7,9,10)))
}