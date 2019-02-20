package cgra.common.Instructions

import chisel3._

trait Instructions {
  val TIA_NUM_OPS:Int = 64

  // Base ISA.
  val TIA_OP_NOP = 0
  val TIA_OP_MOV = 1
  val TIA_OP_ADD = 2
  val TIA_OP_SUB = 3
  val TIA_OP_LSL = 4
  val TIA_OP_ASR = 5
  val TIA_OP_LSR = 6
  val TIA_OP_EQ = 7
  val TIA_OP_NE = 8
  val TIA_OP_SGT = 9
  val TIA_OP_UGT = 10
  val TIA_OP_SLT = 11
  val TIA_OP_ULT = 12
  val TIA_OP_SGE = 13
  val TIA_OP_UGE = 14
  val TIA_OP_SLE = 15
  val TIA_OP_ULE = 16
  val TIA_OP_BAND = 17
  val TIA_OP_BNAND = 18
  val TIA_OP_BOR = 19
  val TIA_OP_BNOR = 20
  val TIA_OP_BXOR = 21
  val TIA_OP_BXNOR = 22
  val TIA_OP_LAND = 23
  val TIA_OP_LNAND = 24
  val TIA_OP_LOR = 25
  val TIA_OP_LNOR = 26
  val TIA_OP_LXOR = 27
  val TIA_OP_LXNOR = 28
  val TIA_OP_GBY = 29 // Not yet implemented.
  val TIA_OP_SBY = 30 // Not yet implemented.
  val TIA_OP_CBY = 31 // Not yet implemented.
  val TIA_OP_MBY = 32 // Not yet implemented.
  val TIA_OP_GB = 33
  val TIA_OP_SB = 34
  val TIA_OP_CB = 35
  val TIA_OP_MB = 36
  val TIA_OP_CLZ = 37
  val TIA_OP_CTZ = 38
  val TIA_OP_HALT = 39
  val basic_insts = VecInit((TIA_OP_NOP to TIA_OP_HALT).map(x=>x.U))

  // Scratchpad extensions.
  val TIA_OP_LSW = 40
  val TIA_OP_SSW = 41
  val scratchpad_insts = VecInit((TIA_OP_LSW to TIA_OP_SSW).map(x=>x.U))

  // Load-store extensions.
  val TIA_OP_RLW = 42 // Not yet implemented.
  val TIA_OP_OLW = 43 // Not yet implemented.
  val TIA_OP_SW = 44 // Not yet implemented.

  // Multiplication extensions.
  val TIA_OP_LMUL = 45
  val TIA_OP_SHMUL = 46
  val TIA_OP_UHMUL = 47
  val TIA_OP_MAC = 48 // Not yet implemented.
  val integer_mult_insts = VecInit((TIA_OP_LMUL to TIA_OP_MAC).map(x=>x.U))

  // Floating-point extensions.
  val TIA_OP_ITF = 49 // Not yet implemented.
  val TIA_OP_UTF = 50 // Not yet implemented.
  val TIA_OP_FTI = 51 // Not yet implemented.
  val TIA_OP_FTU = 52 // Not yet implemented.
  val TIA_OP_FEQ = 53 // Not yet implemented.
  val TIA_OP_FNE = 54 // Not yet implemented.
  val TIA_OP_FGT = 55 // Not yet implemented.
  val TIA_OP_FLT = 56 // Not yet implemented.
  val TIA_OP_FLE = 57 // Not yet implemented.
  val TIA_OP_FGE = 58 // Not yet implemented.
  val TIA_OP_FADD = 59
  val TIA_OP_FSUB = 60 // Not yet implemented.
  val TIA_OP_FMUL = 61
  val TIA_OP_FMAC = 62 // Not yet implemented.

  // Define Instruction Set
  val signed_insts = VecInit(TIA_OP_ASR.U, TIA_OP_SGT.U, TIA_OP_SLT.U, TIA_OP_SGE.U, TIA_OP_SLE.U)

  val unsigned_insts = VecInit(
    TIA_OP_NOP.U, TIA_OP_MOV.U, TIA_OP_ADD.U, TIA_OP_SUB.U, TIA_OP_LSL.U, TIA_OP_LSR.U,
    TIA_OP_EQ.U, TIA_OP_NE.U, TIA_OP_UGT.U, TIA_OP_ULT.U, TIA_OP_UGE.U, TIA_OP_ULE.U,
    TIA_OP_BAND.U, TIA_OP_BNAND.U, TIA_OP_BOR.U, TIA_OP_BNOR.U, TIA_OP_BXOR.U, TIA_OP_BXNOR.U,
    TIA_OP_LAND.U, TIA_OP_LNAND.U, TIA_OP_LOR.U, TIA_OP_LNOR.U, TIA_OP_LXOR.U, TIA_OP_LXNOR.U,
    TIA_OP_GB.U, TIA_OP_SB.U, TIA_OP_CB.U, TIA_OP_MB.U,TIA_OP_CLZ.U, TIA_OP_CTZ.U, TIA_OP_HALT.U)

  val multi_insts = VecInit(TIA_OP_LMUL.U,TIA_OP_SHMUL.U,TIA_OP_UHMUL.U,TIA_OP_MAC.U)

  val float_insts = VecInit(
    TIA_OP_ITF.U, TIA_OP_UTF.U, TIA_OP_FTI.U, TIA_OP_FEQ.U, TIA_OP_FNE.U,
    TIA_OP_FGT.U,TIA_OP_FLT.U, TIA_OP_FLE.U, TIA_OP_FGE.U, TIA_OP_FADD.U,
    TIA_OP_FSUB.U, TIA_OP_FMUL.U,TIA_OP_FMAC.U)

}
