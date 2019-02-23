package cgra.config

import chisel3.experimental.RawModule
import config._

// CGRA
trait Build extends App {
  // Parent ID
  var parent_type: String
  var parent_id: Int = 0
  var Params = Parameters.empty

  // Tile Information
  var tiles_id: List[Int] = Nil
  var tile_keys: List[Field[TileParams]] = Nil

  // Connection Information
  var connects: List[Connect_Key] = Nil

  // Parameter Operation
  private def addParameters(p: Parameters): Unit = {
    Params = Params ++ p
  }

  private def getParameters[T](p: Field[T]) = {
    Params(p)
  }

  // General Operation (mean using the methos in Parameters)
  // can be treated as getParameter from a tile
  def let[T](p_tile: Field[T]): T = {
    Params(p_tile)
  }

  // Tile Utility
  def count_tile: Int = tiles_id.length

  private def add_new_tile_id(id: Int): Int = {
    if (tiles_id.contains(id)) {
      throw new Exception(s"ID: ${id} has already existed")
    } else {
      add_new_tile_id
    }
  }

  private def add_new_tile_id: Int = {
    val new_id = 1 + (tiles_id max)
    tiles_id = new_id :: tiles_id
    new_id
  }

  def new_tile(tile_name: String): Field[TileParams] = new_tile(tile_name, add_new_tile_id)

  def new_tile(tile_name: String, tile_id: Int): Field[TileParams] = {
    val key = tile_name match {
      case "Router" =>
        Router_Key(parent_type, parent_id, add_new_tile_id(tile_id))
      case "Dedicated_PE" =>
        Dedicated_PE_Key(parent_type, parent_id, add_new_tile_id(tile_id))
      case "Shared_PE" =>
        Shared_PE_Key(parent_type, parent_id, add_new_tile_id(tile_id))
      case "Alu" =>
        Alu_Key(parent_type, parent_id, add_new_tile_id(tile_id))
    }
    addParameters(new Tile_Config(key))
    tile_keys = key.asInstanceOf[Field[TileParams]] :: tile_keys
    tile_keys.head
  }

  def delete_tile(tile_key:Field[TileParams]) : Unit = {
    val connects_to_be_delete = get_connects_by_tile(tile_key)
    connects_to_be_delete foreach delete_connect
    tile_keys = tile_keys.filter(_!=tile_key)
    tiles_id = tiles_id.filter(_!=let(tile_key).getID)
    // TODO: delete from Param is not implemented yet
  }

  // Connection
  def new_connect_id: Int = {
    1 + (connects.map(_.id) max)
  }

  def get_connects_by_tile (tile:Field[TileParams]) : List[Connect_Key] = {
    connects.filter(c=>c.source_tile_id == let(tile).getID || c.destination_tile_id == let(tile).getID)
  }

  def add_connect(source: Field[TileParams], destination: Field[TileParams]) = {
    val source_tile = Params(source)
    val destination_tile = Params(destination)
    val connect = Connect_Key(new_connect_id, source_tile.getID, destination_tile.getID)
    val destination_port_index = destination_tile.add_output_port
    val source_port_index = source_tile.add_input_port
    val Connect_Config = new Connect_Config(connect, source_port_index, destination_port_index)
    addParameters(Connect_Config)
  }

  def get_connect_tiles(connect_id: Connect_Key): (TileParams, TileParams) = {
    // Get the config of such connect out
    val connect_config = Params(connect_id)
    // two tiles that connected
    val source_tile_id = connect_id.source_tile_id
    val destination_tile_id = connect_id.destination_tile_id
    // get the key out
    val source_tile_key = tile_keys.find(p => Params(p).getID == source_tile_id).getOrElse(
      throw new Exception("Source Tile not found")
    )
    val destination_tile_key = tile_keys.find(p => Params(p).getID == destination_tile_id).getOrElse(
      throw new Exception("Destination Tile not found")
    )
    (Params(source_tile_key), Params(destination_tile_key))
  }

  def delete_connect(connect_id: Connect_Key) = {
    // Get the config
    val connect_config = Params(connect_id)
    val source_port_index = connect_config.source_port_index
    val destination_port_index = connect_config.destination_port_index
    // Get connected tiles
    val connected_tiles = get_connect_tiles(connect_id)
    val source_tile = connected_tiles._1
    val destination_tile = connected_tiles._2
    // Find other connections that also connect to these two tiles, which have the higher index
    val other_connections: List[Connect_Key] = connects
      .filter(c => c.destination_tile_id == destination_tile.getID
        && c.source_tile_id == source_tile.getID)
    // delete the num_output and num_input
    source_tile.decrease_output_port
    destination_tile.decrease_input_port
    // decrease the port index of other connection
    for (other_connection <- other_connections) {
      val connection = Params(other_connection)
      if (connection.destination_port_index > destination_port_index)
        connection.destination_port_index -= 1
      if (connection.source_port_index > source_port_index)
        connection.source_port_index -= 1
    }
    //TODO:delete in Params

    // delete the connect_key in connection list
    connects = connects.filter(c => c.id != connect_id.id)
  }

  // Generator
  def GenerateTile(pname: Field[TileParams]) = {
    val para = Params(pname)
    val tile_chisel_class =
      Class.forName("cgra.config."+para.module_type).getConstructor(classOf[Parameters])
    val module = tile_chisel_class.newInstance(para).asInstanceOf[RawModule]
    chisel3.Driver.execute(args,()=>module)
  }

  def Generate: Unit = {

  }
}