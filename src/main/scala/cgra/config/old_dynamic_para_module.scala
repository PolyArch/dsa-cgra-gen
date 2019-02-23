package cgra.config

import chisel3._
import config._
/*
// ----------------Parameter Template--------------------------------------------------

case object NameKey extends Field[Module_Type_Params]
case object DatapathKey extends Field[DatapathParams]
case object TileKey extends Field[TileParams]
case object PeKey extends Field[PeParams]
case object RouterKey extends Field[RouterParams]

trait Module_Type_Params {
  val module_type : String
}

trait DatapathParams {
  val word_width : Int
}

trait TileParams extends DatapathParams
  with Module_Type_Params{
  val x_location  : Int
  val y_location  : Int
  val num_input   : Int
  val num_output  : Int
  val input_data_width_multiple   : Array[Int]
  val output_data_width_multiple  : Array[Int]
}

trait PeParams extends TileParams{
  val inst_firing : String
}

trait RouterParams extends TileParams{
  val interconnect_type  : String
}

trait InterfacePortParams extends DatapathParams
  with Module_Type_Params{
  val input_word_width_multiple   : Int
  val output_word_width_multiple  : Int
  val buffer_depth                : Array[Int]
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
  val input_data_width_multiple : Array[Int] = tileParams.input_data_width_multiple
  val output_data_width_multiple: Array[Int] = tileParams.output_data_width_multiple
}

trait HasPeParameters extends HasTileParameters {
  def peParams : PeParams = p(PeKey)
  val inst_firing : String = peParams.inst_firing
}

trait HasRouterParameters extends HasTileParameters {
  def routerParams : RouterParams = p(RouterKey)
  val interconnect_type = routerParams.interconnect_type
}

// ---------------Module template------------------------------------------------------

class ParameterizedBundle(implicit p:Parameters) extends Bundle

abstract class PeBundle (implicit val p:Parameters) extends ParameterizedBundle()(p)
  with HasPeParameters

abstract class PeModule (implicit val p:Parameters) extends Module
  with HasPeParameters

// --------------Module Instance-------------------------------------------------------

class dynamic_para_module(implicit p:Parameters) extends PeModule {
  val io = IO(new Bundle {
    val test_out = Output(UInt(peParams.word_width.W))
  })
  io.test_out := 0.U
}
*/