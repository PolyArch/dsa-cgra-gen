package cgra.fabric

import cgra.parameter._

// ------ Parameters ------
case class InterfacePortParams(parent_type: String,
                               parent_id: Int,
                               tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int)
  with IsParameters {
  override val module_type:String = "ip_port"
  var buffer_depth       : Array[Int] = null
}

// ------ Module ------
class new_Interface_Port {

}
