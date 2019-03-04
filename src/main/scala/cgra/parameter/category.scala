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
  refer_id = tile_id
  var x_location  : Int = -1
  var y_location  : Int = -1

  var config_file_width : Int = -1
  var num_config_register : Int = -1

  def ReadyForSynthesis : Unit

  def set_config_width(w:Int) = config_file_width = w
  val InternalParam = Map[IsKey,List[IsKey]]()

  // ------ Internal Connection ------
  def add_internal(key:IsKey,mux:MUX):Unit = {
    add_internal(key,mux.asInstanceOf[IsParameters])
    if(mux.hasSource)
      for (s<- mux.sources){
        val k = port_subnet(INPUT_TYPE,s.port,s.subnet,s.num_subnet)
        add_internal(k,mux.asInstanceOf[IsParameters])
      }
  }
  // MUX connection
  def add_mux_connect(in:port_subnet,out:port_subnet):Unit ={
    //require(in.num_subnet == out.num_subnet,"please use port index to connect two ports, that having different decomposer")
    val possible_mux_of_output = find_internal(out,MUX())
    val muxes:List[MUX] = possible_mux_of_output.distinct
    val mux = if (muxes.nonEmpty){
      require(muxes.length == 1)
      muxes.head
    }else{
      MUX()
    }
    mux.add_source(in)
    add_internal(out,mux)
    add_internal(in,mux)
  }
  def add_mux_connect(source_port:Int,des_port:Int):Unit = {
    val des_port_list = output_ports_list.filter(_.port == des_port)
    val source_port_list = input_ports_list.filter(_.port == source_port)
    val source_num_subnet = source_port_list.head.num_subnet
    val des_num_subnet = des_port_list.head.num_subnet
    if (source_num_subnet != des_num_subnet){
      if (source_num_subnet > des_num_subnet){
        for (out_s <- 0 until des_num_subnet){
          val d_ps = des_port_list.find(p=>p.subnet == out_s).get
          val s_matched_subnet:List[Int] = subnet_match_less(out_s,des_num_subnet,source_num_subnet)
          for (source_subnet <- s_matched_subnet){
            val source_port_subnet = source_port_list.find(p=>p.subnet == source_subnet).get
            add_mux_connect(source_port_subnet,d_ps)
          }
        }
      }else{
        for (out_s <- 0 until des_num_subnet){
          val d_ps = des_port_list.find(p=>p.subnet == out_s).get
          val s_matched_subnet:Int = subnet_match(out_s,des_num_subnet,source_num_subnet)
          val source_port_subnet = source_port_list.find(p=>p.subnet == s_matched_subnet).get
          add_mux_connect(source_port_subnet,d_ps)
        }
      }
    }else{
      for (s <- 0 until des_num_subnet){
        val s_ps = source_port_list.find(p=>p.subnet == s).get
        val d_ps = des_port_list.find(p=>p.subnet == s).get
        add_mux_connect(s_ps,d_ps)
      }
    }
  }
  def connect_internal (source:IsKey,des:IsKey) = {
    if (InternalParam.isDefinedAt(des))
      InternalParam(des) = InternalParam(des) ::: List(source)
    else
      InternalParam += des -> List(source)
    if (InternalParam.isDefinedAt(source))
      InternalParam(source) = InternalParam(source) ::: List(des)
    else
      InternalParam += source -> List(des)
  }

  // Parameters Operation
  // Find
  def find_internal(ps:port_subnet):List[IsKey] = {
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
  def isPE = TYPE == "PE"
  def isRouter = TYPE == "Router"
  def isInterfacePort = TYPE == "IfPort"

  // Returm Information
  def getParent = parent_type
  def getParent_id = parent_id
  def getType = TYPE
  def get_id = refer_id
  def haveID = refer_id >= 0

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
    connect_Param.source_refer_id = this.get_id
    connect_Param.destination_refer_id = that.get_id
    connect_Param.source_port_index = this.add_output_port
    connect_Param.destination_port_index = that.add_input_port
    connect_Param
  }
  def <-- (that:TileParams) : ConnectParam =  {
    that --> this
  }
  def connect_port (a:TileParams,ap:Int,b:TileParams,bp:Int) : ConnectParam = {
    val connectParam = ConnectParam(getParent,getParent_id)
    connectParam.source_refer_id = a.get_id
    connectParam.destination_refer_id = b.get_id
    connectParam.source_port_index = ap
    connectParam.destination_port_index = bp
    connectParam
  }
  def connect_port (a:TileParams,ap:String,b:TileParams,bp:String) : ConnectParam = {
    val connectParam = ConnectParam(getParent,getParent_id)
    connectParam.source_refer_id = a.get_id
    connectParam.destination_refer_id = b.get_id
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
    <INTERNAL_Modules>
    {InternalParam
      .filter(x=>x._1.asInstanceOf[port_subnet].io == OUTPUT_TYPE)
      .map(x=>{{x._2.map(_.toXML(x._1))}})}
    </INTERNAL_Modules>
  }

  def tile_basic_toXML = {
      <PARENT_TYPE>{parent_type}</PARENT_TYPE><PARENT_ID>{parent_id}</PARENT_ID>
      <TYPE>{TYPE}</TYPE><ID>{refer_id}</ID>
      <DataPath_Width>{word_width}</DataPath_Width>
      <X_location>{x_location}</X_location><Y_location>{y_location}</Y_location>
      <Num_Config_Register>{num_config_register}</Num_Config_Register>
      <Config_Register_Width>{config_file_width}</Config_Register_Width>
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
  def assign_refer_id = {
    var current_id = -1
    InternalParam.foreach(x=>x._2.foreach(y=>y.refer_id = {current_id+=1;current_id}))
  }
}

abstract class PeParams(parent_type: String,parent_id:Int,refer_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,refer_id:Int)
    with IsParameters {
  override val TYPE:String = "PE"
  var inst_set : List[Int] = Nil
  val inst_firing : String = ""
  def isDedicated : Boolean = inst_firing == "dedicated"
  def isShared : Boolean = inst_firing == "shared"
}