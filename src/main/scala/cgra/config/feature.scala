package cgra.config

/*  abstract key is not useful for now
case object NameKey extends Field[Module_Type_Params]
case object DatapathKey extends Field[DatapathParams]
case object IOKey extends Field[IOParams]
case object TileKey extends Field[TileParams]
*/
import cgra.config.Constant._
import chisel3._
import chisel3.util.MixedVec
import scala.collection.mutable.Map


trait Module_Type_Params extends IsParameters{
  val module_type : String
  def get_module_type = module_type
}

trait DatapathParams extends IsParameters{
  def get_word_width = word_width
  def set_word_width (w:Int) = word_width = w
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
    input_word_width_decomposer = input_word_width_decomposer.updated(i,d)
  def change_output_decomposer(d:Int,i:Int) =
    output_word_width_decomposer = output_word_width_decomposer.updated(i,d)
  var input_word_width_decomposer   : List[Int] = Nil
  var output_word_width_decomposer  : List[Int] = Nil
}

// Below is for those categories who can be instantiated but still have sub class,
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

  //var input_ports_params : List[port_param] = Nil
  //var output_ports_params : List[port_param] = Nil

  var input_ports_list : List[port_subnet] = Nil
  var output_ports_list : List[port_subnet] = Nil

  // This is a port/subnet/operand based internal module parameter storage
  val InternalParam = Map[IsKey,List[IsParameters]]()
  // Parameters
  def add_internal(key:IsKey, Params:List[IsParameters]) = {
    InternalParam += key -> Params
    if(InternalParam.isDefinedAt(key))
      InternalParam += key -> AddInUniqueList(InternalParam(key),Params)
    else
      InternalParam += key -> Params
  }
  def add_internal(key:IsKey, Params:IsParameters) = {
    add_internal(key,List(Params))
  }

  // Port Operation
  def get_port_by_port(i:Int)={
    (get_input_port_by_port(i),get_output_port_by_port(i))
  }
  def get_input_port_by_port(i:Int) = {
    input_ports_list.filter(_.port==i)
  }
  def get_output_port_by_port(i:Int) = {
    output_ports_list.filter(_.port==i)
  }
  def has_ports(n:Int):Unit = {
    has_ports(n,default_decomposer)
  }
  def has_ports(n:Int,num_subnet:Int):Unit= {
    has_inputs(n,num_subnet)
    has_outputs(n,num_subnet)
  }
  def has_inputs(n:Int):Unit = has_inputs(n,default_decomposer)
  def has_inputs(n:Int, d:Int):Unit = {
    change_num_input(n)
    for (i <- 0 until n){
      input_ports_list = input_ports_list ::: List(new port_subnet(INPUT_TYPE,i,d))
      add_input_decomposer(d)
    }
  }
  def has_outputs(n:Int) :Unit= has_outputs(n,default_decomposer)
  def has_outputs(n:Int,d:Int):Unit = {
    change_num_output(n)
    for (i <- 0 until n){
      output_ports_list = output_ports_list ::: List(new port_subnet(OUTPUT_TYPE,i,d))
      add_output_decomposer(d)
    }
  }
  /*
  def get_port(port_index:Int)={
    (input_ports_params(port_index),output_ports_params(port_index))
  }
  def get_input_port(i:Int) = {
    input_ports_params(i)
  }
  def get_output_port(i:Int) = {
    output_ports_params(i)
  }
  def has_ports(n:Int):Unit = {
    has_ports(n,default_decomposer)
  }
  def has_ports(n:Int,num_subnet:Int):Unit= {
    has_inputs(n,num_subnet)
    has_outputs(n,num_subnet)
  }
  def has_inputs(n:Int):Unit = has_inputs(n,default_decomposer)
  def has_inputs(n:Int, d:Int):Unit = {
    change_num_input(n)
    for (i <- 0 until n){
      input_ports_params = input_ports_params ::: List(port_param("input",i,d))
      add_input_decomposer(d)
    }
  }
  def has_outputs(n:Int) :Unit= has_outputs(n,default_decomposer)
  def has_outputs(n:Int,d:Int):Unit = {
    change_num_output(n)
    for (i <- 0 until n){
      output_ports_params = output_ports_params ::: List(port_param("output",i,d))
      add_output_decomposer(d)
    }
  }
  */

  // Mux is a unique module which have side effect of adding connected input port
  def add_mux(k:IsKey) = {
    val key = k.asInstanceOf[port_subnet]
    val mux:Mux_source_param = key.io match {
      case INPUT_TYPE =>
        val m = Mux_source_param()
        m.add_source(key.port,key.subnet)
        m
      case OUTPUT_TYPE =>
        Mux_source_param()
    }
    add_module(k,mux)
  }

  // add internal module
  def add_module(key:IsKey, s:IsParameters) = {
    add_internal(key,s)
    s match {
      case s:Mux_source_param =>
        if (s.hasSource)
          for (ps <- s.source_port_subnet)
            add_internal(port_subnet(INPUT_TYPE,ps._1,ps._2),s)
    }
  }
  def add_module(key:IsKey, source:List[IsParameters]) = {
    for (s <- source){
      add_module(key,s)
    }
  }

  // get tile bundle
  def get_tile_bundle = {
    new Bundle {
      val in = MixedVec(input_word_width_decomposer.map(x=>Vec(x,new Tile_IO_Bundle(word_width/x))))
      val out = MixedVec(output_word_width_decomposer.map(x=>Flipped(Vec(x,new Tile_IO_Bundle(word_width/x)))))
    }
  }
  // Duplicate
  def copy = this
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
}

class PeParams(parent_type: String,parent_id:Int,tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int)
  with IsParameters {
  override val module_type:String = "PE"
  var inst_set : List[Int] = Nil
  val inst_firing : String = ""
  def isDedicated : Boolean = inst_firing == "dedicated"
  def isShared : Boolean = inst_firing == "shared"
}