package cgra.config

import config._

// CGRA
class Build(module_t:String) extends App {
  // Parent ID
  val parent_type = module_t
  var parent_id : Int = 0
  var Params = Parameters.empty

  // Tile Information
  var tiles_id:List[Int] = Nil
  var tile_keys:List[Field[TileParams]] = Nil

  // Connection Information
  var connects : List[Connect_ID] = Nil

  // Parameter Side Effect
  def addParameters(p:Parameters):Unit = {
    Params = Params ++ p
  }

  // Tile Utility
  def count_tile : Int = tiles_id.length
  def new_tile_id(id:Int) :Int= {
    if(tiles_id.contains(id)){
      throw new Exception(s"ID: ${id} has already existed")
    }else{
      tiles_id = id :: tiles_id
      id
    }
  }
  def new_tile_id : Int = {
    val new_id = 1 + (tiles_id max)
    tiles_id = new_id :: tiles_id
    new_id
  }
  def newtile(tile_name:String):Field[TileParams] = newtile(tile_name,new_tile_id)
  def newtile(tile_name:String,tile_id:Int):Field[TileParams] = {
    val key = tile_name match{
      case "Router" =>
        val key = Router_Key(parent_type,parent_id,new_tile_id(tile_id))
        addParameters(new Router_Config(key))
        key
      case "Dedicated_PE" =>
        val key = Dedicated_PE_Key(parent_type,parent_id,new_tile_id(tile_id))
        addParameters(new Dedicated_PE_Config(key))
        key
      case "Shared_PE" =>
        val key = Shared_PE_Key(parent_type,parent_id,new_tile_id(tile_id))
        addParameters(new Shared_PE_Config(key))
        key
      case "Alu" =>
        val key = Alu_Key(parent_type,parent_id,new_tile_id(tile_id))
        addParameters(new Alu_Config(key))
        key
    }
    tile_keys = key.asInstanceOf[Field[TileParams]] :: tile_keys
    tile_keys.head
  }

  // Location
  def let(p_tile:Field[TileParams]) : TileParams = {
    Params(p_tile)
  }

  // Connection
  def new_connect_id : Int = {
    connects.length
  }
  def add_connect (source:Field[TileParams],destination:Field[TileParams]) = {
    val source_tile = Params(source)
    val destination_tile = Params(destination)
    val connect = Connect_ID(new_connect_id,source_tile.getID,destination_tile.getID)
    val destination_port_index = destination_tile.add_output_port
    val source_port_index = source_tile.add_input_port
    val Connect_Config = new Connect_Config(connect,source_port_index,destination_port_index)
    addParameters(Connect_Config)
  }
  def get_connect_tile(connect_id:Connect_ID):(TileParams,TileParams)={
    // Get the config of such connect out
    val connect_config = Params(connect_id)
    // two tiles that connected
    val source_tile_id = connect_id.source_tile_id
    val destination_tile_id = connect_id.destination_tile_id
    // get the key out
    val source_tile_key = tile_keys.find(p=>Params(p).getID == source_tile_id)
    val destination_tile_key = tile_keys.find(p=>Params(p).getID == destination_tile_id)
    (Params(source_tile_key),Params(destination_tile_key))
  }
  def delete_connect (connect_id:Connect_ID) = {
    // Get the config
    val connect_config = Params(connect_id)
    val source_port_index = connect_config.source_port_index
    val destination_port_index = connect_config.destination_port_index
    // Get connected tiles
    val connected_tiles = get_connect_tile(connect_id)
    val source_tile = connected_tiles._1
    val destination_tile = connected_tiles._2
    // Find other connections that also connect to these two tiles, which have the higher index
    val other_connection = connects
      .filter(c=>c.destination_tile_id == destination_tile.getID
        && c.source_tile_id == source_tile.getID)
    // delete the num_output and num_input

  }
}