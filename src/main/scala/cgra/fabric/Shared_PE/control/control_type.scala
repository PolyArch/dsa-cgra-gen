package cgra.fabric.Shared_PE.control

import chisel3._
import cgra.fabric.Shared_PE.parameters.derived_parameters._


  class trigger_if extends Bundle{
    val vi = Input(Bool())
    val ptm = Input(UInt(TIA_PTM_WIDTH.W))
    val ici = Input(UInt(TIA_ICI_WIDTH.W))
    val ictb = Input(UInt(TIA_ICTB_WIDTH.W))
    val ictv = Input(UInt(TIA_ICTV_WIDTH.W))
    val oci = Input(UInt(TIA_OCI_WIDTH.W))
  }

  class trigger_t extends Bundle {
    val vi = Bool()
    val ptm = UInt(TIA_PTM_WIDTH.W)
    val ici = UInt(TIA_ICI_WIDTH.W)
    val ictb = UInt(TIA_ICTB_WIDTH.W)
    val ictv = UInt(TIA_ICTV_WIDTH.W)
    val oci = UInt(TIA_OCT_WIDTH.W)
  }