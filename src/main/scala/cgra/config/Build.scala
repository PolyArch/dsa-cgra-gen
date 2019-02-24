package cgra.config

import scala.collection.mutable.Map
import chisel3.experimental.RawModule
import config._

// CGRA
trait Build extends App {
  // Parent ID
  val current_type: String
  val current_id: Int

  val Params = Map[Field[_],isParameters]()

  // Tile Information
  var tile_keys: List[Field[TileParams]] = Nil

  // Connection Information
  var connect_keys: List[Connect] = Nil

  // Parameter Operation
  def pick[T](p_tile: Field[T]):T= {
    Params(p_tile).asInstanceOf[T]
  }
  def have[T](key:Field[T]) = {
    Params += key -> key.default.get.asInstanceOf[isParameters]
  }
  def have(param : isParameters) = {
    val key:Field[_] = param match{
      case param:TileParams =>
        new_tile(param)
      case param:Connect_Param =>
        Connect(new_connect_id,param.source_tile_id,param.destination_tile_id)
    }
    Params += key -> param
  }
  def have(params:List[isParameters]) = {
    for (param <- params){
      val key:Field[_] = param match{
        case param:TileParams =>
          new_tile(param)
        case param:Connect_Param =>
          Connect(new_connect_id,param.source_tile_id,param.destination_tile_id)
      }
      Params += key -> param
    }
  }
  def let[T](f:TileParams => isParameters,key:Field[T]) = {
    have(f(pick(key)))
  }

  // Tile Utility
  private def new_tile_id(id: Int): Int = {
    if (tile_keys.map(_.default.get.get_id).contains(id)) {
      throw new Exception(s"ID: ${id} has already existed")
    } else {
      id
    }
  }
  private def new_tile_id: Int = {
    var new_id : Int = 0
    if(tile_keys.nonEmpty)
      new_id = 1 + (tile_keys.map(_.default.get.get_id) max)
    new_id
  }
  private def add_tile(k:Field[TileParams],v:TileParams):Field[TileParams] = {
    Params += k -> v
    tile_keys = k :: tile_keys
    k
  }
  def count_tiles: Int = tile_keys.length
  def new_tile(tile_name: String): Field[TileParams] = new_tile(tile_name, new_tile_id)
  def new_tile(tile_name: String, tile_id: Int): Field[TileParams] = {
    val key = (tile_name match {
      case "Router" =>
        Router(current_type, current_id, new_tile_id(tile_id))
      case "Dedicated_PE" =>
        Dedicated_PE(current_type, current_id, new_tile_id(tile_id))
      case "Shared_PE" =>
        Shared_PE(current_type, current_id, new_tile_id(tile_id))
      case "Alu" =>
        Alu(current_type, current_id, new_tile_id(tile_id))
      case "Cgra" =>
        Cgra(current_type,current_id,new_tile_id(tile_id))
    }).asInstanceOf[Field[TileParams]]
    add_tile(key,key.default.get)
  }
  def new_tile(param:isParameters):Field[_] = {
    val key = (param match {
      case p:AluParams => Alu(p.getParent,p.getParent_id,p.get_id)
      case p:DedicatedPeParams => Dedicated_PE(p.getParent,p.getParent_id,p.get_id)
      case p:SharedPeParams => Shared_PE(p.getParent,p.getParent_id,p.get_id)
      case p:RouterParams => Router(p.getParent,p.getParent_id,p.get_id)
      case p:CgraParams => Cgra(p.getParent,p.getParent_id,p.get_id)
    }).asInstanceOf[Field[TileParams]]
    add_tile(key,param.asInstanceOf[TileParams])
  }
  def delete_tile(tile_key:Field[TileParams]) = {
    val connects_to_be_depicke = get_connects_by_tile(tile_key)
    // depicke connections which connects to this tile
    connects_to_be_depicke foreach delete_connect
    // depicke from tile_key list
    tile_keys = tile_keys.filter(_!=tile_key)
    Params -= tile_key
  }

  // Connection
  def new_connect_id: Int = {
    var new_id = 0
    if(connect_keys.nonEmpty)
      new_id = 1 + (connect_keys.map(_.id) max)
    new_id
  }
  def get_connects_by_tile (tile:Field[TileParams]) : List[Connect] = {
    connect_keys.filter(c=>c.source_tile_id == pick(tile).get_id || c.destination_tile_id == pick(tile).get_id)
  }
  def add_connect(s: Field[TileParams], d:Field[TileParams]) = {
    val source_tile = pick(s)
    val destination_tile = pick(d)
    val connect = Connect(new_connect_id, source_tile.get_id, destination_tile.get_id)
    have(source_tile --> destination_tile)
  }
  def get_connect_tiles(connect_id: Connect): (TileParams, TileParams) = {
    // Get the config of such connect out
    val connect_config = Params(connect_id)
    // two tiles that connected
    val source_tile_id = connect_id.source_tile_id
    val destination_tile_id = connect_id.destination_tile_id
    // get the key out
    val source_tile_key = tile_keys.find(p => pick(p).get_id == source_tile_id).getOrElse(
      throw new Exception("Source Tile not found")
    )
    val destination_tile_key = tile_keys.find(p => pick(p).get_id == destination_tile_id).getOrElse(
      throw new Exception("Destination Tile not found")
    )
    (pick(source_tile_key), pick(destination_tile_key))
  }
  def delete_connect(connect_id: Connect) = {
    // Get the config
    val connect_config = pick(connect_id)
    val source_port_index = connect_config.source_port_index
    val destination_port_index = connect_config.destination_port_index
    // Get connected tiles
    val connected_tiles = get_connect_tiles(connect_id)
    val source_tile = connected_tiles._1
    val destination_tile = connected_tiles._2
    // Find other connections that also connect to these two tiles, which have the higher index
    val other_connections: List[Connect] = connect_keys
      .filter(c => c.destination_tile_id == destination_tile.get_id
        && c.source_tile_id == source_tile.get_id)
    // depicke the num_output and num_input
    source_tile.decrease_output_port
    destination_tile.decrease_input_port
    // decrease the port index of other connection
    for (other_connection <- other_connections) {
      val connection = pick(other_connection)
      if (connection.destination_port_index > destination_port_index)
        connection.destination_port_index -= 1
      if (connection.source_port_index > source_port_index)
        connection.source_port_index -= 1
    }
    Params -= connect_id
    // depicke the connect_key in connection list
    connect_keys = connect_keys.filter(c => c.id != connect_id.id)
  }

  // Multiple Tiles


  // Generator
  def Generate[T](pname: Field[T]) = {
    val para = pick(pname).asInstanceOf[TileParams]
    val tile_chisel_class =
      Class.forName("cgra.config."+para.module_type).getConstructor(classOf[T])
    val module = tile_chisel_class.newInstance(classOf[T]).asInstanceOf[RawModule]
    chisel3.Driver.execute(args,()=>module)
  }
}