package cgra.config

import chisel3._
import config._

// ----------------------------------------------------------------------

case class No_4_Params(parameter_1: Int = 9,
                            parameter_2: Boolean = false,
                            parameter_3: UInt    = 0.U)

case object No_4_Key extends Field(No_4_Params())

class No_4_Config(val sub:Int) extends Config((site, here, up) => {
  case No_4_Key => up(No_4_Key,site).copy(parameter_1 = 2)
})

// ----------------------------------------------------------------------

case class No_1_Params(
                             base: Int,
                             size: Int,
                             idBits: Int,
                             maxXferBytes: Int = 256,
                             executable: Boolean = true)

case object No_1_Key extends Field[Option[No_1_Params]](None)

class No_1_Config extends Config((site, here, up) => {
  case No_1_Key => Some(No_1_Params(
    base = 600,
    size = 200,
    idBits = 4))
})
// ----------------------------------------------------------------------

case class No_3_Params(paraxxx_1: Int     = 4,
                           paraxxx_2: Boolean = false,
                           paraxxx_3: UInt    = 0.U)

case object No_3_Key extends Field(No_3_Params())

class No_3_Config extends Config((site, here, up) => {
  case No_3_Key => up(No_3_Key, site).copy(paraxxx_2 = true)
})

// ----------------------------------------------------------------------

class mergeConfigs extends Config( new No_1_Config ++ new No_3_Config )

// ----------------Parameter Template--------------------------------------------------

