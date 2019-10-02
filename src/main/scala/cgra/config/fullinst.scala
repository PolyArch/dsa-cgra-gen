package cgra.config

import chisel3.{UInt, _}
import chisel3.util._

case class inst_prop(numOperands:Int, latency:Int, Throughput:Int)

object fullinst {

  val insts_prop = Map(
    "Add"      -> inst_prop(2,1,1),
    "Sub"      -> inst_prop(2,1,1),
    "Mul"      -> inst_prop(2,1,1),
    "Div"      -> inst_prop(2,1,1),
    "BOr"      -> inst_prop(2,1,1),
    "BAnd"     -> inst_prop(2,1,1),
    "BXor"     -> inst_prop(2,1,1),
    "BNot"     -> inst_prop(1,1,1),
    "LNot"     -> inst_prop(1,1,1),
    "LAnd"     -> inst_prop(2,1,1),
    "LOr"      -> inst_prop(2,1,1),
    "ExtractB" -> inst_prop(2,1,1),
    "LShf"     -> inst_prop(2,1,1),
    "RShf"     -> inst_prop(2,1,1),
    "Cat"      -> inst_prop(2,1,1),
    "Mux"      -> inst_prop(3,1,1),
    "EQ"       -> inst_prop(2,1,1),
    "NQ"       -> inst_prop(2,1,1),
    "Mod"      -> inst_prop(2,1,1),
    "GT"       -> inst_prop(2,1,1),
    "GE"       -> inst_prop(2,1,1),
    "LT"       -> inst_prop(2,1,1),
    "LE"       -> inst_prop(2,1,1),
    "AndR"     -> inst_prop(1,1,1),
    "OrR"      -> inst_prop(1,1,1),
    "XorR"     -> inst_prop(1,1,1)
  )

  val inst_operation : Map[String,Seq[UInt] => UInt]= Map(
    // 8-Bit Instructions
    "Add8"      -> ((ops:Seq[UInt]) => {
      val op0 = ops.head.apply(7,0)
      val op1 = ops(1).apply(7,0)
      op0  + op1
    }),
    // ------ 16-Bit Instructions ------
    // TODO: `Control`, `IndexMatch`, `Select` to be implemented
    "Add16"     -> ((ops:Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      val op1 = ops(1).apply(15,0)
      op0 + op1
    }),
    "Sub16"     -> ((ops:Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      val op1 = ops(1).apply(15,0)
      op0 - op1
    }),
    "Concat16"  -> ((ops:Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      val op1 = ops(1).apply(15,0)
      Cat(op0, op1)
    }),
    "Acc16"     ->  ((ops:Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      val op1 = ops(1).apply(15,0)
      op0 + op1
    }),
    "Mul16"     -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      val op1 = ops(1).apply(15,0)
      op0 * op1
    }),
    "Div16"     -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      val op1 = ops(1).apply(15,0)
      op0 / op1
    }),
    "Mod16"     -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      val op1 = ops(1).apply(15,0)
      op0 % op1
    }),
    "Keep16"     -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      op0
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
    "ICmpEq"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      val op1 = ops(1).apply(15,0)
      op0 === op1
    }),
    "ICmpNE"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      val op1 = ops(1).apply(15,0)
      op0 =/= op1
    }),
    "ReLU"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(15,0)
      Mux(op0 >= 0.U, op0, 0.U)
    }),

    // ------ 32-Bit Instructions ------
    "FMul32"    -> ((ops : Seq[UInt]) => { // TODO: Implement floating point
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      op0 * op1
    }),
    "FDiv32"    -> ((ops : Seq[UInt]) => { // TODO: Implement floating point
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      op0 / op1
    }),
    "FAdd32"    -> ((ops : Seq[UInt]) => { // TODO: Implement floating point
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      op0 + op1
    }),
    "FSub32"    -> ((ops : Seq[UInt]) => { // TODO: Implement floating point
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      op0 - op1
    }),
    "Add32"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      op0 + op1
    }),
    "Sub32"    -> ((ops : Seq[UInt]) => {
      val op0 = ops.head.apply(31,0)
      val op1 = ops(1).apply(31,0)
      op0 - op1
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
    "Add"      -> ((ops:Seq[UInt]) => ops.head  + ops(1)),
    "Sub"      -> ((ops:Seq[UInt]) => ops.head  - ops(1)),
    "Mul"      -> ((ops:Seq[UInt]) => ops.head  * ops(1)),
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
