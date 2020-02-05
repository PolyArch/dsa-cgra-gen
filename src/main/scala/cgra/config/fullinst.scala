package cgra.config

import cgra.fabric.Trig_PE_component.datapath.floatpoint.{FPAdd32, FPAdd64, FPMult32, FPMult64}
import chisel3.{UInt, _}
import chisel3.util._

import scala.io.Source

case class inst_prop(numOperands:Int, latency:Int, Throughput:Int)

object fullinst {

  val full_inst_file = "full.ssinst"

  val ssinst_conf : List[Array[String]] =
    Source.fromResource(full_inst_file).getLines
      .toList.map(_.split(" +")).filter(_.length == 6)

  def insts_prop(inst:String) : inst_prop ={
    val target_line = ssinst_conf.filter(l=>l.head == inst)
    val num_oper = target_line.head.apply(2).toInt
    val latency = target_line.head.apply(4).toInt
    val throughput = target_line.head.apply(5).toInt
    println(inst + " : " + "num_operand = " + num_oper + ", latency = " +
      latency + ", throughput = " + throughput)
    inst_prop(num_oper, latency, throughput)
  }

  val inst_operation : Map[String,Seq[UInt] => UInt]= Map(
    // Default Pass
    "Pass"      -> ((ops:Seq[UInt]) => {
      ops.head
    }),
    // 8-Bit Instructions
    "Add8"      -> ((ops:Seq[UInt]) => {
      ops.head.apply(7,0)  + ops(1).apply(7,0)
    }),
    // ------ 16-Bit Instructions ------
    "Add16"     -> ((ops:Seq[UInt]) => {
      ops.head.apply(15,0) + ops(1).apply(15,0)
    }),
    "Sub16"     -> ((ops:Seq[UInt]) => {
      ops.head.apply(15,0) - ops(1).apply(15,0)
    }),
    "Concat16"  -> ((ops:Seq[UInt]) => {
      Cat(ops.head.apply(15,0), ops(1).apply(15,0))
    }),
    "Mul16"     -> ((ops : Seq[UInt]) => {
      ops.head.apply(15,0) * ops(1).apply(15,0)
    }),
    "Div16"     -> ((ops : Seq[UInt]) => {
      ops.head.apply(15,0) / ops(1).apply(15,0)
    }),
    "Mod16"     -> ((ops : Seq[UInt]) => {
      ops.head.apply(15,0) % ops(1).apply(15,0)
    }),
    "Min16"     -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      val op1 = ops(1).apply(15,0)
      Mux(op0 >= op1, op1, op0)
    }),
    "And16"     -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      val op1 = ops(1).apply(15,0)
      op0 & op1
    }),
    "Not16"     -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      (~op0).asUInt()
    }),
    "Or16"      -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      val op1 = ops(1).apply(15,0)
      op0 | op1
    }),
    "RShf16"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      val op1 = ops(1).apply(15,0)
      (op0 >> op1).asUInt()
    }),
    "ICmpEQ"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      val op1 = ops(1).apply(15,0)
      op0 === op1
    }),
    "ICmpNE"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      val op1 = ops(1).apply(15,0)
      op0 =/= op1
    }),
    "ReLU16"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      Mux(op0 >= 0.U, op0, 0.U)
    }),

    // ------ 32-Bit Instructions ------
    "FMul32"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      val fMul32_io = Module(new FPMult32).io
      fMul32_io.a := op0
      fMul32_io.b := op1
      fMul32_io.res
    }),
    /*
    "FDiv32"    -> ((ops : Seq[UInt]) => { // TODO: Need Implementation
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      op0 / op1
    }),
     */
    "FAdd32"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      val fAdd32_io = Module(new FPAdd32).io
      fAdd32_io.a := op0
      fAdd32_io.b := op1
      fAdd32_io.res
    }),
    "FSub32"    -> ((ops : Seq[UInt]) => { // TODO: Need Implementation
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      op0 - op1
    }),
    "Add32"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      op0 + op1
    }),
    "Mul32"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      op0 * op1
    }),
    "Div32"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      op0 / op1
    }),
    "Min32"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      Mux(op0 >= op1, op1, op0)
    }),
    "Select32"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      val op2 = ops(2).apply(31,0)
      Mux(op2 === 0.U, op0, op1)
    }),
    "ICmpNE32"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      op0 =/= op1
    }),
    "ICmp32"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      op0 > op1
    }),
    "And32"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      op0 & op1
    }),
    "Or32"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      op0 | op1
    }),
    "Xor32"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      op0 ^ op1
    }),
    "Acc32"     ->  ((ops:Seq[UInt]) => {
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      op0 + op1
    }),

    // ------ 64-Bit Instructions ------
    "Extract16"    -> ((ops:Seq[UInt]) => {
      val op0 = ops.head
      val op1 = ops(1).apply(1,0)
      val muxLookup : Seq[(UInt,UInt)]=
        for(i <- 0 until 4)yield{
        val high = (i + 1) * 16 -1
        val low = i * 16
        (i.U, op0(high,low))
      }
      MuxLookup(op1,0.U,muxLookup)
    }),
    "Add16x4"    -> ((ops:Seq[UInt]) => {
      Cat(
        ops.head.apply(63,48)  + ops(1).apply(63,48),
        ops.head.apply(47,32)  + ops(1).apply(47,32),
        ops.head.apply(31,16)  + ops(1).apply(31,16),
        ops.head.apply(15,0)  + ops(1).apply(15,0)
      )
    }),
    "Add64"    -> ((ops:Seq[UInt]) => {
      val op0 = ops.head.apply(63,0)
      val op1 = ops(1).apply(63,0)
      op0 + op1
    }),
    "Div64"    -> ((ops:Seq[UInt]) => {
      val op0 = ops.head.apply(63,0)
      val op1 = ops(1).apply(63,0)
      op0 / op1
    }),
    "Abs16x4"    -> ((ops:Seq[UInt]) => {
      val op0 = ops.head.apply(63,0)
      val s3 = op0(63,48).asSInt()
      val s2 = op0(47,32).asSInt()
      val s1 = op0(31,16).asSInt()
      val s0 = op0(15,0).asSInt()
      Cat(
        Mux(s3 > 0.S, s3.asUInt(), (0.S-s3).asUInt()),
        Mux(s2 > 0.S, s2.asUInt(), (0.S-s2).asUInt()),
        Mux(s1 > 0.S, s1.asUInt(), (0.S-s1).asUInt()),
        Mux(s0 > 0.S, s0.asUInt(), (0.S-s0).asUInt())
      )
    }),
    "RShf4_16x4"    -> ((ops:Seq[UInt]) => {
      val s3 = ops.head.apply(63,48)
      val s2 = ops.head.apply(47,32)
      val s1 = ops.head.apply(31,16)
      val s0 = ops.head.apply(15,0)
      Cat(
        s3 >> 4.U,
        s2 >> 4.U,
        s1 >> 4.U,
        s0 >> 4.U
      )
    }),
    "FMul64"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(63,0)
      val op1 = ops(1).apply(63,0)
      val fMul64_io = Module(new FPMult64).io
      fMul64_io.a := op0
      fMul64_io.b := op1
      fMul64_io.res
    }),
    "FDiv64"    -> ((ops : Seq[UInt]) => { // TODO: Need Implementation
      val op0 = ops.head.apply(63,0)
      val op1 = ops(1).apply(63,0)
      op0 / op1
    }),
    "FAdd64"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(63,0)
      val op1 = ops(1).apply(63,0)
      val fAdd64_io = Module(new FPAdd64).io
      fAdd64_io.a := op0
      fAdd64_io.b := op1
      fAdd64_io.res
    }),
    "FSub64"    -> ((ops : Seq[UInt]) => { // TODO: Need Implementation
      val op0 = ops.head.apply(63,0)
      val op1 = ops(1).apply(63,0)
      op0 - op1
    }),

    // ------ Data Width Insensitive Instructions ------
    "Add"      -> ((ops:Seq[UInt]) => ops.head  + ops(1)),
    "Sub"      -> ((ops:Seq[UInt]) => ops.head  - ops(1)),
    "Mul"      -> ((ops:Seq[UInt]) => {
      val mul = (ops.head  * ops(1)).suggestName("INST_MUL")
      mul
    }),
    "Div"      -> ((ops:Seq[UInt]) => ops.head  / ops(1)),
    "BOr"      -> ((ops:Seq[UInt]) => ops.head  | ops(1)),
    "BAnd"     -> ((ops:Seq[UInt]) => ops.head  & ops(1)),
    "BXor"     -> ((ops:Seq[UInt]) => ops.head  ^ ops(1)),
    "BNot"     -> ((ops:Seq[UInt]) => (~ops.head).asUInt()),
    "LNot"     -> ((ops:Seq[UInt]) => !ops.head),
    "LAnd"     -> ((ops:Seq[UInt]) => ops.head =/= 0.U && ops(1) =/= 0.U),
    "LOr"      -> ((ops:Seq[UInt]) => ops.head =/= 0.U || ops(1) =/= 0.U),
    "ExtractB" -> ((ops:Seq[UInt]) => ops.head(ops(1))),
    "LShf"     -> ((ops:Seq[UInt]) => (ops.head << ops(1)(18,0)).asUInt()),
    "RShf"     -> ((ops:Seq[UInt]) => (ops.head >> ops(1)(18,0)).asUInt()),
    "Cat"      -> ((ops:Seq[UInt]) => Cat(ops.head,ops(1))),
    "Mux"      -> ((ops:Seq[UInt]) => Mux(ops.head =/= 0.U,ops(1),ops(2))),
    "EQ"       -> ((ops:Seq[UInt]) => ops.head === ops(1)),
    "NQ"       -> ((ops:Seq[UInt]) => ops.head =/= ops(1)),
    "Mod"      -> ((ops:Seq[UInt]) => ops.head % ops(1)),
    "GT"       -> ((ops:Seq[UInt]) => ops.head > ops(1)),
    "GE"       -> ((ops:Seq[UInt]) => ops.head >= ops(1)),
    "LT"       -> ((ops:Seq[UInt]) => ops.head < ops(1)),
    "LE"       -> ((ops:Seq[UInt]) => ops.head <= ops(1)),
    "AndR"     -> ((ops:Seq[UInt]) => ops.head.andR()),
    "OrR"      -> ((ops:Seq[UInt]) => ops.head.orR()),
    "XorR"     -> ((ops:Seq[UInt]) => ops.head.xorR())

  )
}
