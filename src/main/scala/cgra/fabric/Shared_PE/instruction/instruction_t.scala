package cgra.fabric.Shared_PE.instruction

import chisel3.{WireInit, _}
import chisel3.util._
import cgra.fabric.Shared_PE.parameters.derived_parameters._

class mm_instruction extends  Module
  with inst_util{
  val io = IO(new Bundle{
    val enable = Input(Bool())
    val read = Output(new mm_instruction_t)
    val write = Input(UInt(TIA_MM_INSTRUCTION_WIDTH.W))
  })

  val instructions = Module(new instruction ).io

  // enable
  instructions.enable := io.enable

  // Write
  val non_imme_bits_r = new fieldRange(pum_r.high,0)

  instructions.write := extractBits(io.write,non_imme_bits_r)
  val ptm = RegEnable(extractBits(io.write,ptm_r),io.enable)
  val ici = RegEnable(extractBits(io.write,ici_r),io.enable)
  val ictb = RegEnable(extractBits(io.write,ictb_r),io.enable)
  val ictv = RegEnable(extractBits(io.write,ictv_r),io.enable)
  val immediate = RegEnable(extractBits(io.write,immediate_r),io.enable)
  //val padding = RegEnable(extractBits(io.write,padding_r),io.enable)

  // read
  io.read.vi <> instructions.read.vi
  io.read.op <> instructions.read.op
  io.read.st <> instructions.read.st
  io.read.si <> instructions.read.si
  io.read.dt <> instructions.read.dt
  io.read.di <> instructions.read.di
  io.read.oci <> instructions.read.oci
  io.read.oct <> instructions.read.oct
  io.read.icd <> instructions.read.icd
  io.read.pum <> instructions.read.pum

  io.read.ptm := ptm
  io.read.ici := ici
  io.read.ictb := ictb
  io.read.ictv := ictv
  io.read.immediate := immediate
  io.read.padding := 0.U//padding TODO: padding field is kept for further use

}

class instruction extends Module
  with inst_util{
  val io = IO(new Bundle{
    val enable = Input(Bool())
    val read = Output(new non_datapath_instruction_t)
    val write = Input(UInt((pum_r.high + 1).W))
  })

  val vi = RegEnable(extractBits(io.write,vi_r),io.enable)
  val op = RegEnable(extractBits(io.write,op_r),io.enable)
  val st = RegEnable(extractBits(io.write,st_r),io.enable)
  val si = RegEnable(extractBits(io.write,si_r),io.enable)
  val dt = RegEnable(extractBits(io.write,dt_r),io.enable)
  val di = RegEnable(extractBits(io.write,di_r),io.enable)
  val oci = RegEnable(extractBits(io.write,oct_r),io.enable)
  val oct = RegEnable(extractBits(io.write,oct_r),io.enable)
  val icd = RegEnable(extractBits(io.write,icd_r),io.enable)
  val pum = RegEnable(extractBits(io.write,pum_r),io.enable)

  io.read.vi := vi
  io.read.op := op
  io.read.st := st
  io.read.si := si
  io.read.dt := dt
  io.read.di := di
  io.read.oci := oci
  io.read.oct := oct
  io.read.icd := icd
  io.read.pum := pum
}

class mm_instruction_t extends datapath_instruction_t {
  val ptm = UInt(TIA_PTM_WIDTH.W)
  val ici = UInt(TIA_ICI_WIDTH.W)
  val ictb = UInt(TIA_ICTB_WIDTH.W)
  val ictv = UInt(TIA_ICTV_WIDTH.W)
  val padding = UInt(TIA_MM_INSTRUCTION_PADDING_WIDTH.W)
}

class datapath_instruction_t extends non_datapath_instruction_t{
  val immediate = UInt(TIA_WORD_WIDTH.W)
}

class non_datapath_instruction_t extends Bundle {
  val vi = Bool()
  val op = UInt(TIA_OP_WIDTH.W)
  val st = UInt(TIA_ST_WIDTH.W)
  val si = UInt(TIA_SI_WIDTH.W)
  val dt = UInt(TIA_DT_WIDTH.W)
  val di = UInt(TIA_DI_WIDTH.W)
  val oci = UInt(TIA_OCI_WIDTH.W)
  val oct = UInt(TIA_OCT_WIDTH.W)
  val icd = UInt(TIA_ICD_WIDTH.W)
  val pum = UInt(TIA_PUM_WIDTH.W)
}

class zero_mm_instruction extends Module{
  val io = IO(Output(new mm_instruction_t))
  io.vi := 0.U
  io.op := 0.U(TIA_OP_WIDTH.W)
  io.st := 0.U(TIA_ST_WIDTH.W)
  io.si := 0.U(TIA_SI_WIDTH.W)
  io.dt := 0.U(TIA_DT_WIDTH.W)
  io.di := 0.U(TIA_DI_WIDTH.W)
  io.oci := 0.U(TIA_OCI_WIDTH.W)
  io.oct := 0.U(TIA_OCT_WIDTH.W)
  io.icd := 0.U(TIA_ICD_WIDTH.W)
  io.pum := 0.U(TIA_PUM_WIDTH.W)
  io.immediate := 0.U(TIA_WORD_WIDTH.W)
  io.ptm := 0.U(TIA_PTM_WIDTH.W)
  io.ici := 0.U(TIA_ICI_WIDTH.W)
  io.ictb := 0.U(TIA_ICTB_WIDTH.W)
  io.ictv := 0.U(TIA_ICTV_WIDTH.W)
  io.padding := 0.U(TIA_MM_INSTRUCTION_PADDING_WIDTH.W)
}

class zero_datapath_instruction extends Module {
  val io = IO(Output(new datapath_instruction_t))
  io.vi := 0.U
  io.op := 0.U
  io.st := 0.U
  io.si := 0.U
  io.dt := 0.U
  io.di := 0.U
  io.oci := 0.U
  io.oct := 0.U
  io.icd := 0.U
  io.pum := 0.U
  io.immediate := 0.U
}

class zero_non_datapath_instruction extends Module{
  val io = IO(Output(new non_datapath_instruction_t))
  io.vi := 0.U
  io.op := 0.U(TIA_OP_WIDTH.W)
  io.st := 0.U(TIA_ST_WIDTH.W)
  io.si := 0.U(TIA_SI_WIDTH.W)
  io.dt := 0.U(TIA_DT_WIDTH.W)
  io.di := 0.U(TIA_DI_WIDTH.W)
  io.oci := 0.U(TIA_OCI_WIDTH.W)
  io.oct := 0.U(TIA_OCT_WIDTH.W)
  io.icd := 0.U(TIA_ICD_WIDTH.W)
  io.pum := 0.U(TIA_PUM_WIDTH.W)
}

trait inst_util {
  def cat_inst_asOne(tbr_ins:mm_instruction_t):UInt = {
    Cat(tbr_ins.padding,
      tbr_ins.immediate,
      tbr_ins.ictv,
      tbr_ins.ictb,
      tbr_ins.ici,
      tbr_ins.ptm,
      tbr_ins.pum,
      tbr_ins.icd,
      tbr_ins.oct,
      tbr_ins.oci,
      tbr_ins.di,
      tbr_ins.dt,
      tbr_ins.si,
      tbr_ins.st,
      tbr_ins.op,
      tbr_ins.vi)
  }

  def extractBits(ori:UInt,fieldR:fieldRange):UInt =
    ori(fieldR.high,fieldR.low)

  def nextFieldRange(width:Int,lowFieldRange:fieldRange):fieldRange =
    new fieldRange(width + lowFieldRange.high,lowFieldRange.high + 1)

  class fieldRange(h:Int,l:Int){
    val high:Int  = h
    val low:Int = l
  }
  // ----- Instruction Structure -----
  // Low
  val vi_r = new fieldRange(0,0)
  val op_r = nextFieldRange(TIA_OP_WIDTH,vi_r)
  val st_r = nextFieldRange(TIA_ST_WIDTH,op_r)
  val si_r = nextFieldRange(TIA_SI_WIDTH ,st_r)
  val dt_r = nextFieldRange(TIA_DT_WIDTH,si_r)
  val di_r = nextFieldRange(TIA_DI_WIDTH,dt_r)
  val oci_r = nextFieldRange(TIA_OCI_WIDTH,di_r)
  val oct_r = nextFieldRange(TIA_OCT_WIDTH,oci_r)
  val icd_r = nextFieldRange(TIA_ICD_WIDTH,oct_r)
  val pum_r = nextFieldRange(TIA_PUM_WIDTH,icd_r)
  // ------ non immediate ------

  val ptm_r = nextFieldRange(TIA_PTM_WIDTH,pum_r)
  val ici_r = nextFieldRange(TIA_ICI_WIDTH,ptm_r)
  val ictb_r = nextFieldRange(TIA_ICTB_WIDTH,ici_r)
  val ictv_r = nextFieldRange(TIA_ICTV_WIDTH,ictb_r)

  val immediate_r = nextFieldRange(TIA_IMMEDIATE_WIDTH,ictv_r)

  val padding_r = nextFieldRange(TIA_MM_INSTRUCTION_PADDING_WIDTH,immediate_r)
  // High
}

object mm_inst_Driver extends App {
  chisel3.Driver.execute(args, () => new mm_instruction)
}