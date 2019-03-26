package cgra.fabric.Shared_PE_component.control

import cgra.fabric.Shared_PE_component.tia_parameters.derived_parameters._
import cgra.fabric.Shared_PE_component.tia_parameters.fixed_parameters._
import chisel3._

class trigger_t extends Bundle{
  val vi = Bool()
  val ptm = UInt(TIA_PTM_WIDTH.W)
  val ici = UInt(TIA_ICI_WIDTH.W)
  val ictb = UInt(TIA_ICTB_WIDTH.W)
  val ictv = UInt(TIA_ICTV_WIDTH.W)
  val oci = UInt(TIA_OCT_WIDTH.W)
}