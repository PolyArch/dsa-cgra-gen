package cgra.fabric.Shared_PE.control

import cgra.entity.Entity
import cgra.fabric.Shared_PE.parameters.derived_parameters
import chisel3._

class trigger_t(p:Entity) extends Bundle
  with derived_parameters{
  parameter_update(p)

  val vi = Bool()
  val ptm = UInt(TIA_PTM_WIDTH.W)
  val ici = UInt(TIA_ICI_WIDTH.W)
  val ictb = UInt(TIA_ICTB_WIDTH.W)
  val ictv = UInt(TIA_ICTV_WIDTH.W)
  val oci = UInt(TIA_OCT_WIDTH.W)

  override def cloneType = new trigger_t(p).asInstanceOf[this.type]
}