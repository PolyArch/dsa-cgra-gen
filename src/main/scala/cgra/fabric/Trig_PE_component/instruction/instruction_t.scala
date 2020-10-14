package cgra.fabric.Trig_PE_component.instruction


import cgra.fabric.Trig_PE_component.tia_parameters.derived_parameters._
import cgra.fabric.Trig_PE_component.tia_parameters.fixed_parameters._
import chisel3._
import chisel3.util._

class mm_instruction extends  Module{
  val io = IO(new Bundle{
    val enable = Input(Bool())
    val read = Output(new mm_instruction_t)
    val write = Input(UInt(TIA_MM_INSTRUCTION_WIDTH.W))
  })

  val instructions = Module(new instruction).io

  // enable
  instructions.enable := io.enable

  // Write
  val non_imme_bits_r = new fieldRange(pum_r.high,0)

  instructions.write := io.write(non_imme_bits_r.high,non_imme_bits_r.low)
  val ptm = RegEnable(io.write(ptm_r.high,ptm_r.low),io.enable)
  val ici = RegEnable(io.write(ici_r.high,ici_r.low),io.enable)
  val ictb = RegEnable(io.write(ictb_r.high,ictb_r.low),io.enable)
  val ictv = RegEnable(io.write(ictv_r.high,ictv_r.low),io.enable)
  val immediate = RegEnable(io.write(immediate_r.high,immediate_r.low),io.enable)
  //val padding = RegEnable(extractBits(t_io.write,padding_r),t_io.enable)

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

class instruction extends Module {

  val io = IO(new Bundle{
    val enable = Input(Bool())
    val read = Output(new non_datapath_instruction_t)
    val write = Input(UInt((pum_r.high + 1).W))
  })

  val vi = RegEnable(io.write(vi_r.high,vi_r.low),io.enable)
  val op = RegEnable(io.write(op_r.high,op_r.low),io.enable)
  val st = RegEnable(io.write(st_r.high,st_r.low),io.enable)
  val si = RegEnable(io.write(si_r.high,si_r.low),io.enable)
  val dt = RegEnable(io.write(dt_r.high,dt_r.low),io.enable)
  val di = RegEnable(io.write(di_r.high,di_r.low),io.enable)
  val oci = RegEnable(io.write(oci_r.high,oci_r.low),io.enable)
  val oct = RegEnable(io.write(oct_r.high,oct_r.low),io.enable)
  val icd = RegEnable(io.write(icd_r.high,icd_r.low),io.enable)
  val pum = RegEnable(io.write(pum_r.high,pum_r.low),io.enable)

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

class mm_instruction_t extends datapath_instruction_t{
  val ptm = UInt(TIA_PTM_WIDTH.W)
  val ici = UInt(TIA_ICI_WIDTH.W)
  val ictb = UInt(TIA_ICTB_WIDTH.W)
  val ictv = UInt(TIA_ICTV_WIDTH.W)
  val padding = UInt(TIA_MM_INSTRUCTION_PADDING_WIDTH.W)
}

class datapath_instruction_t extends non_datapath_instruction_t{
  val immediate = UInt(TIA_WORD_WIDTH.W)
}

class non_datapath_instruction_t extends Bundle{
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

class zero_datapath_instruction extends Module{
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