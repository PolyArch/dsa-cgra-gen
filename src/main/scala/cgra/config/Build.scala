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
  var connects: List[Connect] = Nil

  // Parameter Operation
  private def as_tile_key[T](key:T) : Field[TileParams] = key.asInstanceOf[Field[TileParams]]

  def let[T](p_tile: Field[T]):T= {
    Params(p_tile).asInstanceOf[T]
  }

  // Tile Utility
  def count_tile: Int = tile_keys.length

  private def add_new_tile_id(id: Int): Int = {
    if (tile_keys.map(_.default.get.getID).contains(id)) {
      throw new Exception(s"ID: ${id} has already existed")
    } else {
      id
    }
  }

  private def add_new_tile_id: Int = {
    var new_id : Int = 0
    if(tile_keys.nonEmpty)
      new_id = 1 + (tile_keys.map(_.default.get.getID) max)
    new_id
  }

  def new_tile(tile_name: String): Field[TileParams] = new_tile(tile_name, add_new_tile_id)

  def new_tile(tile_name: String, tile_id: Int): Field[TileParams] = {
    val key = (tile_name match {
      case "Router" =>
        Router(current_type, current_id, add_new_tile_id(tile_id))
      case "Dedicated_PE" =>
        Dedicated_PE(current_type, current_id, add_new_tile_id(tile_id))
      case "Shared_PE" =>
        Shared_PE(current_type, current_id, add_new_tile_id(tile_id))
      case "Alu" =>
        Alu(current_type, current_id, add_new_tile_id(tile_id))
    }).asInstanceOf[Field[TileParams]]
    Params += key -> key.default.get
    tile_keys = key :: tile_keys
    tile_keys.head
  }

  def delete_tile(tile_key:Field[TileParams]) = {
    val connects_to_be_delete = get_connects_by_tile(tile_key)
    // delete connections which connects to this tile
    connects_to_be_delete foreach delete_connect
    // delete from tile_key list
    tile_keys = tile_keys.filter(_!=tile_key)
    Params -= tile_key
  }

  // Connection
  def new_connect_id: Int = {
    var new_id = 0
    if(connects.nonEmpty)
      new_id = 1 + (connects.map(_.id) max)
    new_id
  }

  def get_connects_by_tile (tile:Field[TileParams]) : List[Connect] = {
    connects.filter(c=>c.source_tile_id == let(tile).getID || c.destination_tile_id == let(tile).getID)
  }

  def add_connect[T](s: Field[T], d:Field[T]) = {
    val source_tile = let(s).asInstanceOf[TileParams]
    val destination_tile = let(d).asInstanceOf[TileParams]

    val connect = Connect(new_connect_id, source_tile.getID, destination_tile.getID)
    val destination_port_index = destination_tile.add_output_port
    val source_port_index = source_tile.add_input_port

    val connect_param = Connect_Param(connect.id)
    connect_param.destination_port_index = destination_port_index
    connect_param.source_port_index = source_port_index
    connects = connect :: connects
    Params += connect -> connect_param
  }

  def get_connect_tiles(connect_id: Connect): (TileParams, TileParams) = {
    // Get the config of such connect out
    val connect_config = Params(connect_id)
    // two tiles that connected
    val source_tile_id = connect_id.source_tile_id
    val destination_tile_id = connect_id.destination_tile_id
    // get the key out
    val source_tile_key = tile_keys.find(p => let(p).getID == source_tile_id).getOrElse(
      throw new Exception("Source Tile not found")
    )
    val destination_tile_key = tile_keys.find(p => let(p).getID == destination_tile_id).getOrElse(
      throw new Exception("Destination Tile not found")
    )
    (let(source_tile_key), let(destination_tile_key))
  }

  def delete_connect(connect_id: Connect) = {
    // Get the config
    val connect_config = let(connect_id)
    val source_port_index = connect_config.source_port_index
    val destination_port_index = connect_config.destination_port_index
    // Get connected tiles
    val connected_tiles = get_connect_tiles(connect_id)
    val source_tile = connected_tiles._1
    val destination_tile = connected_tiles._2
    // Find other connections that also connect to these two tiles, which have the higher index
    val other_connections: List[Connect] = connects
      .filter(c => c.destination_tile_id == destination_tile.getID
        && c.source_tile_id == source_tile.getID)
    // delete the num_output and num_input
    source_tile.decrease_output_port
    destination_tile.decrease_input_port
    // decrease the port index of other connection
    for (other_connection <- other_connections) {
      val connection = let(other_connection)
      if (connection.destination_port_index > destination_port_index)
        connection.destination_port_index -= 1
      if (connection.source_port_index > source_port_index)
        connection.source_port_index -= 1
    }
    Params -= connect_id
    // delete the connect_key in connection list
    connects = connects.filter(c => c.id != connect_id.id)
  }

  // Generator
  def Generate[T](pn: T) = {
    val pname = as_tile_key(pn)
    val para = let(pname)
    val tile_chisel_class =
      Class.forName("cgra.config."+para.module_type).getConstructor(classOf[Parameters])
    val module = tile_chisel_class.newInstance(para).asInstanceOf[RawModule]
    chisel3.Driver.execute(args,()=>module)
  }
}