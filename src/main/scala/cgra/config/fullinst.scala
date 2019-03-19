package cgra.config

import chisel3.{UInt, _}
import chisel3.util._

object fullinst {
  val insts_prop = Map(
    "Add"      -> instruction_prop(2,1,1),
    "Sub"      -> instruction_prop(2,1,1),
    "Mul"      -> instruction_prop(2,1,1),
    "Div"      -> instruction_prop(2,1,1),
    "BOr"      -> instruction_prop(2,1,1),
    "BAnd"     -> instruction_prop(2,1,1),
    "BXor"     -> instruction_prop(2,1,1),
    "BNot"     -> instruction_prop(1,1,1),
    "LNot"     -> instruction_prop(1,1,1),
    "LAnd"     -> instruction_prop(2,1,1),
    "LOr"      -> instruction_prop(2,1,1),
    "ExtractB" -> instruction_prop(2,1,1),
    "LShf"     -> instruction_prop(2,1,1),
    "RShf"     -> instruction_prop(2,1,1),
    "Cat"      -> instruction_prop(2,1,1),
    "Mux"      -> instruction_prop(3,1,1),
    "EQ"       -> instruction_prop(2,1,1),
    "NQ"       -> instruction_prop(2,1,1),
    "Mod"      -> instruction_prop(2,1,1),
    "GT"       -> instruction_prop(2,1,1),
    "GE"       -> instruction_prop(2,1,1),
    "LT"       -> instruction_prop(2,1,1),
    "LE"       -> instruction_prop(2,1,1),
    "AndR"     -> instruction_prop(1,1,1),
    "OrR"      -> instruction_prop(1,1,1),
    "XorR"     -> instruction_prop(1,1,1)
  )
  val inst_operation : Map[String,(UInt*) => UInt]= Map(
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
case class instruction_prop(numOperands:Int,latency:Int,Throughput:Int)