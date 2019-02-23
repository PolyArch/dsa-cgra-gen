package cgra.config

import config._

case object NameKey extends Field[Module_Type_Params]
case object DatapathKey extends Field[DatapathParams]
case object IOKey extends Field[IOParams]
case object TileKey extends Field[TileParams]

trait Module_Type_Params {
  val module_type : String = null
}

trait DatapathParams {
  var word_width : Int = -1
}

trait IOParams {
  var num_input   : Int = 1
  var num_output  : Int = 1
  var input_word_width_decomposer   : Array[Int] = null
  var output_word_width_decomposer  : Array[Int] = null
}

class TileParams(parent_type: String,
                 parent_id: Int,
                 tile_id:Int) extends DatapathParams
  with IOParams
  with Module_Type_Params{
  def isPE = module_type == "PE"
  def isRouter = module_type == "router"
  def isInterfacePort = module_type == "if_port"
  def getID = tile_id
  def haveID = tile_id >= 0
  var x_location  : Int = -1
  var y_location  : Int = -1
}

class HasPeParams(parent_type: String,parent_id:Int,tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int){
  override val module_type:String = "PE"
  var inst_set : Array[Int] = null
  val inst_firing : String = null
  def isDedicated : Boolean = inst_firing == "dedicated"
  def isShared : Boolean = inst_firing == "shared"
}

trait HasDatapathParameters {
  implicit val p : Parameters
  def datapathParams : DatapathParams = p(DatapathKey)
  val word_width = datapathParams.word_width
}

trait HasIOParameters {
  implicit val p : Parameters
  def ioParams : IOParams = p(IOKey)
  val num_input   : Int = ioParams.num_input
  val num_output  : Int = ioParams.num_output
  val input_word_width_decomposer   : Array[Int] = ioParams.input_word_width_decomposer
  val output_word_width_decomposer  : Array[Int] = ioParams.output_word_width_decomposer
}

trait HasTileParameters extends HasDatapathParameters
  with HasIOParameters{
  val parent_id : Int
  def tileParams : TileParams = p(TileKey)
  val module_type:String = tileParams.module_type
  val x_location:Int = tileParams.x_location
  val y_location:Int = tileParams.y_location
}