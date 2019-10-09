package cgra.fabric.common.datapath

import cgra.config.fullinst._
import chisel3._
import chisel3.util._
import dsl.IRPrintable
import scala.collection.mutable


// This is an ALU with all possible operations
class general_alu(prop:mutable.Map[String, Any]) extends Module
with IRPrintable {
  // Add initial property
  apply(prop)

  // External Parameter
  private val inst_list : List[String] = getPropByKey("instructions")
    .asInstanceOf[List[String]]
  private val data_width : Int = getPropByKey("data_width")
    .asInstanceOf[Int]

  // Derived Parameter
  private val num_instruction : Int = inst_list.length
  private val max_num_operand : Int =
    inst_list.map(i=>insts_prop(i).numOperands).max
  private val max_inst_latency : Int =
    inst_list.map(i=>insts_prop(i).latency).max
  private val inst2latency : Seq[(UInt, UInt)] =
    {for(inst <- inst_list)yield{
      (inst_list.indexOf(inst).U,insts_prop(inst).latency.U)
    }}

  // Create Hardware
  val io = IO(new Bundle{
    val opcode = Input(UInt(log2Ceil(num_instruction).W))
    val operands = Vec(max_num_operand,Flipped(DecoupledIO(UInt(data_width.W))))
    val result = DecoupledIO(UInt(data_width.W))
  })

  // Extract Control Signal
  // Input
  val operands = io.operands.map(_.bits)
  val operands_valid : Bool = VecInit(io.operands.map(_.valid)).asUInt().andR()
  val result_ready : Bool = io.result.ready
  // Output
  val operands_ready_for_next = WireInit(false.B)
  val result_valid : Bool = WireInit(false.B)
  val alu_result = WireInit(0.U(data_width.W))

  // Connect the Valid/Ready Signal
  for (ready <- io.operands.map(_.ready)){
    ready := operands_ready_for_next
  }
  io.result.valid := result_valid

  // Latency Logic
  val latency_countdown = RegInit(max_inst_latency.U)
  result_valid := latency_countdown === 0.U


  // Connect Arithmetic Result
  io.result.bits := alu_result

  // When Upstream and Downstream are both ready for next result
  when(operands_valid && result_ready){
    latency_countdown := latency_countdown - 1.U
    for(inst <- inst_list){
      if(inst_operation.isDefinedAt(inst)){
        val inst_func = inst_operation(inst)
        when(io.opcode === inst_list.indexOf(inst).U){
          alu_result := inst_func(operands)
          operands_ready_for_next := true.B
          result_valid := true.B
        }
      }
    }
  }.otherwise{
    latency_countdown := MuxLookup(io.opcode,max_inst_latency.U,inst2latency)
  }


  override def postprocess(): Unit = ???

}

object gen_general_alu extends App{
  val prop : mutable.Map[String,Any] = mutable.Map[String,Any]()

  prop += "data_width" -> 64
  prop += "instructions" -> inst_operation.keys.toList

  chisel3.Driver.execute(args,()=>{
    val module = new general_alu(prop)
    println(module)
    module
  })
}