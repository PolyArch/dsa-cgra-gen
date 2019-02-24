package cgra.config

/*  abstract key is not useful for now
case object NameKey extends Field[Module_Type_Params]
case object DatapathKey extends Field[DatapathParams]
case object IOKey extends Field[IOParams]
case object TileKey extends Field[TileParams]
*/
import chisel3._
import chisel3.util.MixedVec

trait Module_Type_Params extends isParameters{
  val module_type : String
  def get_module_type = module_type
}

trait DatapathParams extends isParameters{
  def get_word_width = word_width
  var word_width : Int = -1
}

trait IOParams {
  // get information
  def get_num_input = num_input
  def get_num_output = num_output
  // port operation
  def add_output_port: Int = {num_output += 1;num_output-1} // return index
  def add_input_port : Int = {num_input += 1;num_input-1} // return index
  def decrease_output_port : Int = {num_output -=1;num_output}
  def decrease_input_port : Int = {num_input -=1;num_input}
  def change_num_input(x:Int) =num_input = x
  def change_num_output(x:Int)=num_output = x
  var default_decomposer = 1
  var num_input   : Int = 0
  var num_output  : Int = 0
  def add_input_decomposer(d:Int) =
    input_word_width_decomposer = input_word_width_decomposer ::: List(d)
  def add_output_decomposer(d:Int)=
    output_word_width_decomposer = output_word_width_decomposer ::: List(d)
  def change_input_decomposer(d:Int,i:Int) =
    input_word_width_decomposer(i) = d
  def change_output_decomposer(d:Int,i:Int) =
    output_word_width_decomposer(i) = d
  var input_word_width_decomposer   : List[Int] = Nil
  var output_word_width_decomposer  : List[Int] = Nil
}

// Below is for those categories who can be instantiated but still have sub class,
// like we can have a tile hardware of PE, but PE still have different types

class Tile_IO_Bundle(word_width:Int) extends Bundle
  with DatapathParams{
  val req = Input(Bool())
  val ack = Output(Bool())
  val data = Input(UInt(word_width.W))
}

abstract class TileParams(parent_type: String,
                 parent_id: Int,
                 tile_id:Int) extends DatapathParams
  with IOParams
  with Module_Type_Params
  with isParameters {
  var x_location  : Int = -1
  var y_location  : Int = -1
  // get tile bundle
  def get_tile_bundle = {
    new Bundle {
      val in = MixedVec(input_word_width_decomposer.map(x=>Vec(x,new Tile_IO_Bundle(word_width/x))))
      val out = Flipped(MixedVec(output_word_width_decomposer.map(x=>Vec(x,new Tile_IO_Bundle(word_width/x)))))
    }
  }
  // Duplicate
  def copy = this
  // Judge
  def isPE = module_type == "PE"
  def isRouter = module_type == "router"
  def isInterfacePort = module_type == "if_port"
  // Returm Information
  def getParent = parent_type
  def getParent_id = parent_id
  def get_id = tile_id
  def haveID = tile_id >= 0
  // location operation
  def move_horizontal(x:Int)=x_location = x
  def move_vertical(y:Int)=y_location = y
  def at(x:Int,y:Int) = {x_location = x;y_location = y}
  // Connect
  def <-> (that:TileParams) : List[ConnectParam] =  {
    List(this --> that,this <-- that)
  }
  def --> (that:TileParams) : ConnectParam =  {
    val connect_Param = ConnectParam(getParent,getParent_id)
    connect_Param.source_tile_id = this.get_id
    connect_Param.destination_tile_id = that.get_id
    connect_Param.source_port_index = this.add_output_port
    connect_Param.destination_port_index = that.add_input_port
    connect_Param
  }
  def <-- (that:TileParams) : ConnectParam =  {
    that --> this
  }
}

class PeParams(parent_type: String,parent_id:Int,tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int)
  with isParameters {
  override val module_type:String = "PE"
  var inst_set : List[Int] = Nil
  val inst_firing : String = ""
  def isDedicated : Boolean = inst_firing == "dedicated"
  def isShared : Boolean = inst_firing == "shared"
}

/* Seems not very useful currently, might be useful when we have the chisel implementation of module
// Now just parameters
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
*/