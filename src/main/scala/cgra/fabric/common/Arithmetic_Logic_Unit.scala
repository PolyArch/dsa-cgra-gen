package cgra.fabric.common

import cgra.IO.IO_Interface.get_io
import cgra.fabric.common.Instructions._
import cgra.config.Constant._
import cgra.entity.{Entity, Port, RegisterControlled, WithWordWidth}
import cgra.fabric.Shared_PE.datapath.floatpoint.{FPAdd, FPMult}
import scala.collection.mutable.{Map,ListBuffer}
import chisel3._
import chisel3.util._
import scala.math.min

case class Arithmetic_Logic_Unit() extends Entity
  with RegisterControlled
  with WithWordWidth{
  entity_type = this.getClass.getName
  def forsyn : Unit= {
    // Get Parameters
    val word_width = get("Word_Width").asInstanceOf[Int]
    val inst_set = get("Instruction-Set").asInstanceOf[List[Int]]
    // Add parameter
    val config_width = log2Ceil(inst_set.length)
    val control_inst_map = inst_set.zipWithIndex.map(i=>(i._2,i._1)).toMap
    have ("control-opcode-map",control_inst_map)
    have("control_width",config_width)
    // Add port
    Ports += Port(INPUT_TYPE,false,false) += Port(INPUT_TYPE,false,false) += Port(OUTPUT_TYPE,false,false)
    if(contain_three_operands_inst(inst_set)) Ports += Port(INPUT_TYPE,false,false)
    Ports.foreach(p=>{p.have("function","data");p.have("Word_Width",word_width)})
    val config_port = Port(INPUT_TYPE,false,false);config_port have("Word_Width",config_width)
    config_port have("function","control");Ports += config_port
  }
}



class Arithmetic_Logic_Unit_Hw(p:Entity) extends Module{

  val word_width : Int = p.get("Word_Width").asInstanceOf[Int]
  val inst_list : List[Int] = p.get("Instruction-Set").asInstanceOf[List[Int]]
  val control_inst_map : Map[Int,Int] = p.get("control-opcode-map").asInstanceOf[Map[Int,Int]]
  val op_width : Int = p.get("control_width").asInstanceOf[Int]

  val operand_index = p.Ports.zipWithIndex.filter(p=>p._1.io == INPUT_TYPE && p._1.get("function") == "data").map(p=>p._2)
  val control_index = p.Ports.zipWithIndex.find(p=>p._1.io == INPUT_TYPE && p._1.get("function") == "control").get._2
  val output_index = p.Ports.zipWithIndex.find(p=>p._1.io == OUTPUT_TYPE && p._1.get("function") == "data").get._2

  val io = IO(get_io(p.Ports))

  // Connect result with output
  val op:UInt = Wire(UInt(op_width.W))
  op := io(control_index)

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
  operand0_unsigned <> io(operand_index.head)
  operand1_unsigned <> io(operand_index(1))
  if(contain_three_operands_inst(inst_list)) operand2_unsigned <> io(operand_index(2))
  else operand2_unsigned := 0.U
  operand0_signed := io(operand_index.head).asUInt.asSInt()
  operand1_signed := io(operand_index(1)).asUInt.asSInt()
  if(contain_three_operands_inst(inst_list)) operand2_signed := io(operand_index(2)).asUInt.asSInt
  else operand2_signed := 0.S
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
    if (inst_list.contains(TIA_OP_LSL)) when(op ===TIA_OP_LSL.U){result_unsigned := operand0_unsigned << operand1_unsigned(min(18,word_width-1),0)}
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
        result_unsigned := operand0_unsigned | (1.U << operand1_unsigned(min(18,word_width-1),0)).asUInt
      }.otherwise {
        result_unsigned := operand0_unsigned & (~(1.U << operand1_unsigned(min(18,word_width-1),0))).asUInt
      }
    }
    if (inst_list.contains(TIA_OP_CB)) when(op ===TIA_OP_CB.U){result_unsigned := operand0_unsigned & (~(1.U << operand1_unsigned(min(18,word_width-1),0))).asUInt}
    if (inst_list.contains(TIA_OP_MB)) when(op ===TIA_OP_MB.U){result_unsigned := operand0_unsigned | (1.U << operand1_unsigned(min(18,word_width-1),0)).asUInt}
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
      fpAdder.io.a := io(operand_index.head)
      fpAdder.io.b := io(operand_index(1))
      when(op === TIA_OP_FADD.U){
        fpResult := fpAdder.io.res
      }
    }
    if (inst_list.contains(TIA_OP_FMUL)){
      val fpMultiplier = Module(new FPMult(word_width))
      fpMultiplier.io.a := io(operand_index.head)
      fpMultiplier.io.b := io(operand_index(1))
      when(op === TIA_OP_FMUL.U){
        fpResult := fpMultiplier.io.res
      }
    }
  }

  when(VecInit(unsigned_insts_list.map(x=>x.U)).exists(_ === op)){
    io(output_index) := result_unsigned
  } .elsewhen(  VecInit(signed_insts_list.map(x=>x.U)).exists( _ === op)){
    io(output_index) := result_signed.asUInt()
  } .elsewhen(VecInit(float_insts_list.map(x=>x.U)).exists(_ === op)){
    io(output_index) := fpResult
  } .otherwise {
    io(output_index) := 0.U
  }

  printf(p"opcode = $op\n")
  printf(p"operand 0 = ${io(operand_index.head)}\n")
  printf(p"operand 1 = ${io(operand_index(1))}\n")
  printf(p"result = ${io(output_index)}\n")
  printf("-----------------------------------\n")

}