package cgra.config

import config._

// CGRA
class Build(module_t:String) extends App{



  var parent_type = module_t
  var parent_id : Int = 0
  var Params = Parameters.empty
  var tiles_id:List[Int] = Nil

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
  def addParameters(p:Parameters):Unit = {
    Params = Params ++ p
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
    key.asInstanceOf[Field[TileParams]]
  }

}

