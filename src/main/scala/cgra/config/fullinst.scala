package cgra.config

import chisel3.{UInt, _}
import chisel3.util._

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
case class inst_prop(numOperands:Int, latency:Int, Throughput:Int)