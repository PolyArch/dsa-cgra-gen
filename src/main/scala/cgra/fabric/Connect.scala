package cgra.fabric

import cgra.parameter._

// ------ Parameters ------
case class ConnectParam(parent_type:String,parent_id:Int)
  extends IsParameters{
  var source_tile_id :Int = -1
  var destination_tile_id : Int = -1
  var source_port_index : Int = -1
  var destination_port_index : Int = -1
}

// ------ Module ------
class Connect_Module {

}