package real

import dsl._

object REVEL extends App {
  // Keys that differ nodes
  identifier("row_idx","col_idx")

  // Define Default Switch
  val sw_default = new ssnode("switch")
  sw_default("subnet_offset", List(0, 1))("switch_mode", "group-by-port")

  def FUsAndCount(insts:String*) = {
    val res = new ssnode("function unit")
    res(
      "instructions", insts
    )(
      "fu count", insts.map(a => 1)
    )(
      "max_delay_fifo_depth", 4
    )
    res
  }

  val add = FUsAndCount("Add16x4", "Red16x4", "HAdd16x4", "RShf4_16x4",
                        "RShf2_16x4", "Add32x2", "Red32x2", "Add64",
                        "RShf64", "Sub16x4", "Abs16x4", "Sub64",
                        "Max16x4", "Min16x4", "SMax16x4", "SMin16x4",
                        "RedMax16x4", "RedMin16x4", "RedSMax16x4",
                        "RedSMin16x4", "Select", "Add32", "Or", "Xor",
                        "LShf64", "Acc64", "ICmpEQ", "Acc16x4",
                        "FAdd32x2", "RShf16x4", "FRed32x2", "FxAdd16x4",
                        "FxRed16x4", "FxExp16x4", "FAcc32x2",
                        "FAddSub32x2", "FSubAdd32x2", "FSub64", "FAdd64",
                        "FSub32x2", "FxAddSub16x4", "FxSubAdd16x4",
                        "FxAcc16x4", "DupLow32", "FAccumulate64",
                        "MergeSentinal", "FxRedCom16x4", "CplxRed32x2",
                        "Discard", "Keep", "Add16", "FltCplxToFx",
                        "FxSub16x4", "CplxConj", "FAcc64", "Compare64",
                        "Accumulate64", "Acc16to32x4", "Min64", "Min16",
                        "Compare16")
  val mul = FUsAndCount("Mul16x4", "Mul32x2", "Mul64", "FMul32x2",
                        "Div16x4", "FxMul16x4", "FMulX32x2", "FMul64",
                        "FxMulX16x4", "NegFMul32x2", "CplxMulCons",
                        "Discard", "Keep", "Delay", "NegCplxMulCons",
                        "CplxMulCplx", "CplxMulConj", "CplxInvConj",
                        "NegCplxMulConj", "CplxConj")
  val spc = FUsAndCount("CplxSqrt", "CplxInv", "RealSqrt", "RealInv",
                        "RealSqrtInv", "CplxSqrtInv", "CplxDivCons",
                        "CplxNmlz", "Discard", "Keep", "Delay",
                        "NegCplxDivCons", "CplxMulCons", "CplxInvConj",
                        "CplxMulConj", "CplxMulCplx", "NegCplxMulConj",
                        "CplxGivensRes", "CplxGivensCos", "CplxGivensSin",
                        "FMul32x2", "FMulX32x2", "FAdd32x2", "FSub32x2",
                        "FRed32x2", "FAddSub32x2", "FSubAdd32x2",
                        "CplxConj", "FDiv64", "Sqrt64", "FAdd64",
                        "FSub64", "FMul64", "DivRem64", "Mul16", "Keep16",
                        "Acc16")

  // Define SPU
  val spu = new ssfabric
  spu(
    "default_data_width", 64
  )(
    "default_flow_control", true
  )(
    "default_granularity", 8
  )(
    "default_max_util", 1
  )

  // Build Topology
  val switchMesh = spu.buildMesh(sw_default, 6, 6)

  val pe = Array(
    Array(add, mul, mul, mul, mul),
    Array(mul, add, add, add, add),
    Array(mul, add, add, add, add),
    Array(mul, add, add, add, add),
    Array(mul, add, add, add, spc),
  )

  for (i <- 0 until 5; j <- 0 until 5) {
    val temp = pe(i)(j).clone
    if (i == 4 && j >= 3) {
      temp("row_idx", i)("col_idx", j)("max_util", 64)
    } else {
      temp("row_idx", i)("col_idx", j)
    }
    spu(
      spu(i)(j)("switch") --> temp
    )(
      spu(i+1)(j)("switch") --> temp
    )(
      spu(i)(j+1)("switch") <-> temp
    )(
      spu(i+1)(j+1)("switch") <-> temp
    )
  }

  val sw = Array.concat(
      spu.filter("row_idx", "nodeType")(0, "switch").toArray,
      spu.filter("col_idx", "nodeType")(5, "switch").slice(1, 6).toArray,
      spu.filter("row_idx", "nodeType")(5, "switch").slice(0, 5).reverse.toArray,
      spu.filter("col_idx", "nodeType")(0, "switch").slice(0, 5).reverse.toArray
  )

  val ins = List(
    List(0, 1, 2, 3, 5, 6, 7, 8),
    List(1, 2, 3, 5, 6, 7, 8, 10),
    List(1, 3, 6, 8),
    List(2, 6, 7, 10),
    List(1),
    List(2),
    List(4),
    List(5),
    List(6),
    List(8),
    List(9),
    List(1, 2),
    List(3, 5),
    List(6, 7),
    List(8, 10),
    List(2, 6),
    List(8, 10),
    List(2, 6),
    List(0, 2, 6, 7),
    List(1, 3, 6, 8),
    List(1, 6),
    List(2, 8),
  )

  for (i <- ins) {
    val vp = new ssnode("vector port")
    spu(vp |=> i.map(x => sw(x)).toSeq)
  }

  val outs = List(
    List(0, 1, 1, 3, 3, 4, 5, 6),
    List(0, 2, 3, 4),
    List(0),
    List(0),
    List(1),
    List(2),
    List(2),
    List(3),
    List(4),
    List(0, 1),
    List(1, 2),
    List(3, 3),
    List(2, 3, 5, 6, 6, 7, 7, 8),
  )

  for (i <- outs) {
    val vp = new ssnode("vector port")
    spu(vp <=| i.map(x => sw(x)).toSeq)
  }

  // Print
  spu.printIR("IR/revel")

}
