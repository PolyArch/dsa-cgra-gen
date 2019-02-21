package cgra.config

import chisel3._
import config._

// ----------------------------------------------------------------------

case class No_4_Params(parameter_1: Int = 9,
                            parameter_2: Boolean = false,
                            parameter_3: UInt    = 0.U)

case object No_4_Key extends Field(No_4_Params())

class No_4_Config extends Config((site, here, up) => {
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

class No_2_Config extends Config((site, here, up) => {
  case RouterKey => new RouterParams
})

// ----------------------------------------------------------------------

class mergeConfigs extends Config( new No_1_Config ++  new No_2_Config  ++ new No_3_Config ++ new No_4_Config)

// ----------------Parameter Template--------------------------------------------------

case object NameKey extends Field[module_type_Params]
case object DatapathKey extends Field[DatapathParams]
case object TileKey extends Field[TileParams]
case object PeKey extends Field[PeParams]
case object RouterKey extends Field[RouterParams]

trait module_type_Params {
  var module_type : String = null
}

trait DatapathParams {
  var word_width : Int = 64
}

trait IOParams {
  var num_input   : Int = 1
  var num_output  : Int = 1
  var input_word_width_decomposer   : Array[Int] = null
  var output_word_width_decomposer  : Array[Int] = null
}

class TileParams extends DatapathParams
  with IOParams
  with module_type_Params{
  def isPE = module_type == "PE"
  def isRouter = module_type == "router"
  def isInterfacePort = module_type == "if_port"
  var x_location  : Int = 0
  var y_location  : Int = 0
}

class PeParams() extends TileParams{
  var inst_firing : String = null
}

class RouterParams() extends TileParams{
  var interconnect_type  : String = null
}

class InterfacePortParams() extends TileParams{
  var buffer_depth       : Array[Int] = null
}

// ---------------ComBination of parameters---------------------------------------------

trait HasDatapathParameters {
  implicit val p : Parameters
  def datapathParams : DatapathParams = p(DatapathKey)
  val word_width = datapathParams.word_width
}

trait HasTileParameters extends HasDatapathParameters
{
  def tileParams : TileParams = p(TileKey)
  val module_type:String = tileParams.module_type
  val x_location:Int = tileParams.x_location
  val y_location:Int = tileParams.y_location
  val num_input:Int = tileParams.num_input
  val num_output:Int = tileParams.num_output
  val input_word_width_decomposer : Array[Int] = tileParams.input_word_width_decomposer
  val output_word_width_decomposer: Array[Int] = tileParams.input_word_width_decomposer
}

trait HasPeParameters extends HasTileParameters {
  def peParams : PeParams = p(PeKey)
  val inst_firing : String = peParams.inst_firing
}

trait HasRouterParameters extends HasTileParameters {
  def routerParams : RouterParams = p(RouterKey)
  val interconnect_type = routerParams.interconnect_type
}