package cgra.fabric.common

import cgra.IO.ReqAckConf_if
import cgra.IO.port_generator.gc_port
import cgra.config.fullinst.{inst_operation, insts_prop}
import cgra.config.inst_prop
import cgra.fabric.Reconfigurable
import chisel3.util._
import chisel3._

import scala.xml.Elem

class Arithmetic_Logic_Unit extends Reconfigurable {
  var opcode_config_high : Int = -1
  var opcode_config_low : Int = -1
  var output_select_config_high : Int = -1
  var output_select_config_low : Int = -1
  var sink : List[String] = Nil
  var subnet : Int = -1
  var max_num_operand: Int = -1
  var inst : List[String] = Nil
  var alu_word_width : Int = -1
  var protocol : String = ""
  def config2XML : Elem = {
    <Alu>
      <Config_High_Bit>{opcode_config_high}</Config_High_Bit>
      <Config_Low_Bit>{opcode_config_low}</Config_Low_Bit>
      <Num_Operands>{max_num_operand}</Num_Operands>
      <Opcodes>
        {inst.zipWithIndex.map(i=>{<Select>{i._2}</Select><Opcode>{i._1}</Opcode>})}
      </Opcodes>
      <Sink>{sink}</Sink>
    </Alu>
  }
}

class Arithmetic_Logic_Unit_Hw(p:Arithmetic_Logic_Unit) extends Module{
  val io = IO(new Bundle{
    val in = Flipped(Vec(p.max_num_operand,ReqAckConf_if(p.alu_word_width)))
    val out = ReqAckConf_if(p.alu_word_width)
    val opcode = Input(UInt(log2Ceil(p.inst.length).W))
  })
  // GC useless port
  io.in.foreach(ap=>gc_port(ap,p.protocol))
  gc_port(io.out,p.protocol)
  // Collect Inst. Function
  val operation_func = p.inst.map(f=>inst_operation(f))
  // Collect Inst. Properties
  val inst_props : List[inst_prop] = p.inst.map(f=>insts_prop(f))
  // Initialize Result Buffer
  val result_buffer : Vec[UInt] = Wire(Vec(p.inst.length,UInt(p.alu_word_width.W)))
  // Compute Result
  for (idx_opcode <- p.inst.indices){
    val op_func = operation_func(idx_opcode)
    val inst_prop = inst_props(idx_opcode)
    val result = alu_result(inst_prop,op_func)
    result_buffer(idx_opcode) := result
  }
  // Output Result
  io.out.bits := result_buffer(io.opcode)

  // TODO: This is a fake latency
  if (p.protocol.contains("Ready")){
    val simulated_alu_latency = RegInit(0.U(1 max log2Ceil(inst_props.map(i=>i.latency) max)))
    // Restart
    when(io.out.ready && io.in.map(p=>p.valid).reduce(_ && _) && simulated_alu_latency === 0.U){
      for (idx_opcode <- p.inst.indices){
        when(io.opcode === idx_opcode.U){
          simulated_alu_latency := inst_props(idx_opcode).latency.U
        }
      }
    }
    // Counting Down
    when(simulated_alu_latency =/= 1.U){
      simulated_alu_latency := simulated_alu_latency - 1.U
      io.out.valid := false.B
      for (i <- 0 until p.max_num_operand){
        io.in(i).ready := false.B
      }
    }.otherwise{ // Finished
      io.out.valid := true.B
      for (i <- 0 until p.max_num_operand){
        io.in(i).ready := true.B
      }
    }
  }
  if(p.protocol.contains("Valid")){
    io.out.valid := io.in.map(p=>p.valid).reduce(_ && _)
  }

  // Util
  def alu_result (inst_prop:inst_prop, func:(UInt*) => UInt) : UInt ={
    val num_op = inst_prop.numOperands
    val result:UInt = num_op match {
      case 1 => func(io.in(0).bits)
      case 2 => func(io.in(0).bits,io.in(1).bits)
      case 3 => func(io.in(0).bits,io.in(1).bits,io.in(2).bits)
    }
    result
  }
}