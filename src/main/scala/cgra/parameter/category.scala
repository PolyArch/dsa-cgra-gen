package cgra.parameter

import cgra.fabric._
import chisel3._
import chisel3.util.MixedVec
import scala.collection.mutable.Map
import cgra.parameter.Constant._

// FILE Category is for those categories who can be instantiated but still have sub class,
// like we can have a tile hardware of PE, but PE still have different types

class Tile_IO_Bundle(word_w:Int) extends Bundle{
  val req = Input(Bool())
  val ack = Output(Bool())
  val data = Input(UInt(word_w.W))
  override def cloneType = new Tile_IO_Bundle(word_w).asInstanceOf[this.type]
}
abstract class TileParams  (parent_type: String,
                            parent_id: Int,
                            tile_id:Int) extends DatapathParams
  with IOParams
  with Module_Type_Params
  with IsParameters {
  var x_location  : Int = -1
  var y_location  : Int = -1

  var config_file_width : Int = -1
  var num_config_register : Int = -1

  def ReadyForSynthesis : Unit

  def set_config_width(w:Int) = config_file_width = w
  val InternalParam = Map[IsKey,List[IsParameters]]()

  // Parameters Operation
  // Find
  def find_internal(ps:port_subnet):List[IsParameters] = {
    val io = ps.io
    val port = ps.port
    val subnet = ps.subnet
    val found_port_subnet:List[port_subnet] = InternalParam.filter(x=>{
      val exist_destination_key = x._1.asInstanceOf[port_subnet]
      exist_destination_key.io == io &&
        exist_destination_key.port == port &&
        exist_destination_key.subnet == subnet
    }).map(_._1.asInstanceOf[port_subnet]).toList
    require(found_port_subnet.length <= 1,"find multiple keys with same io,port and subnet")
    if (found_port_subnet.nonEmpty)
      InternalParam(found_port_subnet.head)
    else
      Nil // Not found
  }
  def find_internal[T](ps:port_subnet, p:T):List[T] = {
    val list_p = find_internal(ps)
    val target_ps = list_p.filter(_.isInstanceOf[T]).asInstanceOf[List[T]]
    if (target_ps.nonEmpty){
      List(target_ps.head)
    }else{
      Nil
    }
  }
  // Add Internal Parameter
  def add_internal(key:IsKey, Params:List[IsParameters]):TileParams.this.InternalParam.type = {
    if(InternalParam.isDefinedAt(key))
      InternalParam += key -> AddInUniqueList(InternalParam(key),Params)
    else
      InternalParam += key -> Params
  }
  def add_internal(key:IsKey, Params:IsParameters):TileParams.this.InternalParam.type= {
    add_internal(key,List(Params))
  }

  // get tile bundle
  def get_tile_bundle = {
    new Bundle {
      val in = MixedVec(input_word_width_decomposer.map(x=>Vec(x,new Tile_IO_Bundle(word_width/x))))
      val out = MixedVec(output_word_width_decomposer.map(x=>Flipped(Vec(x,new Tile_IO_Bundle(word_width/x)))))
    }
  }

  // Judge
  def isPE = module_type == "PE"
  def isRouter = module_type == "Router"
  def isInterfacePort = module_type == "IfPort"

  // Returm Information
  def getParent = parent_type
  def getParent_id = parent_id
  def getType = module_type
  def get_id = tile_id
  def haveID = tile_id >= 0

  // location operation
  def move_horizontal(x:Int)=x_location = x
  def move_vertical(y:Int)=y_location = y
  def at(x:Int,y:Int) = {x_location = x;y_location = y}

  // --- Connect ---
  // symbol connect will add extra port
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
  def connect_port (a:TileParams,ap:Int,b:TileParams,bp:Int) : ConnectParam = {
    val connectParam = ConnectParam(getParent,getParent_id)
    connectParam.source_tile_id = a.get_id
    connectParam.destination_tile_id = b.get_id
    connectParam.source_port_index = ap
    connectParam.destination_port_index = bp
    connectParam
  }
  def connect_port (a:TileParams,ap:String,b:TileParams,bp:String) : ConnectParam = {
    val connectParam = ConnectParam(getParent,getParent_id)
    connectParam.source_tile_id = a.get_id
    connectParam.destination_tile_id = b.get_id
    connectParam.source_port_index = a.get_Port_by_Direction(ap)
    connectParam.destination_port_index = b.get_Port_by_Direction(bp)
    connectParam
  }

  // Add to unique list
  def AddInUniqueList [T](v:T,list:List[T]) : List[T]={
    if(list.contains(v))
      list
    else
      list ::: List(v)
  }
  def AddInUniqueList [T](l:List[T],list:List[T]) : List[T]={
    var ll : List[T] = list
    for (v <- l){
      ll = AddInUniqueList(v,list)
    }
    ll
  }

  // Calculate config sec, basc and bound
  def calaulate_config_location(config_width:Int,range:Int,
                                previous_sec:Int,previous_bound:Int,previous_base:Int) :(Int,Int,Int)= {
    var try_base = previous_bound + 1
    var try_bound = previous_bound + range
    var try_config_sec = previous_sec
    if (try_bound/config_width == 1){
      try_base = 0
      try_bound = try_base + range - 1
      try_config_sec += 1
    }else if (try_bound/config_width > 1){
      throw new Exception("Range cover two config registers")
    }
    (try_config_sec,try_bound,try_base)
  }

  // IR output
  def internal_parameter_xml = {
    <INTERNAL_PARAMETER>
    {InternalParam
      .filter(x=>x._1.asInstanceOf[port_subnet].io == OUTPUT_TYPE)
      .map(x=>{<KEY>{x._1.toXML}</KEY><VALUE>{x._2.map(_.toXML)}</VALUE>})}
    </INTERNAL_PARAMETER>
  }
  def ports_to_XML = {
    <PORTS>
      <INPUT>{input_word_width_decomposer.zipWithIndex.map(x=>{
        val decomposer = x._1
        val index = x._2
        <INDEX>{index}</INDEX><Decomposer>{decomposer}</Decomposer>
      })}</INPUT>
      <OUTPUT>{output_word_width_decomposer.zipWithIndex.map(x=>{
        val index = x._2
        val decomposer = x._1
        <INDEX>{index}</INDEX><Decomposer>{decomposer}</Decomposer>
      })}</OUTPUT>
    </PORTS>
  }
  def toXML =
    <TILE>
      <PARENT>{parent_type}</PARENT><PARENT_ID>{parent_id}</PARENT_ID>
      <NAME>{module_type}</NAME><ID>{tile_id}</ID>
      <DataPath_Width>{word_width}</DataPath_Width>
      <X_location>{x_location}</X_location><Y_location>{y_location}</Y_location>
      <Num_Config_Register>{num_config_register}</Num_Config_Register>
      <Config_Register_Width>{config_file_width}</Config_Register_Width>
      {ports_to_XML}
      {internal_parameter_xml}
    </TILE>
}

abstract class PeParams(parent_type: String,parent_id:Int,tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int)
    with IsParameters {
  override val module_type:String = "PE"
  var inst_set : List[Int] = Nil
  val inst_firing : String = ""
  def isDedicated : Boolean = inst_firing == "dedicated"
  def isShared : Boolean = inst_firing == "shared"
}