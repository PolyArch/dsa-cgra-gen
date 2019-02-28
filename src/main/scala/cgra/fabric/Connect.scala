package cgra.fabric

import cgra.parameter._

// ------ Parameters ------
case class ConnectParam(parent_type:String,parent_id:Int)
  extends IsParameters{
  var source_tile_id :Int = -1
  var destination_tile_id : Int = -1
  var source_port_index : Int = -1
  var destination_port_index : Int = -1
  def toXML =
    <CONNECT>
      <SOURCE_TILE_ID>{source_tile_id}</SOURCE_TILE_ID><SOURCE_PORT_INDEX>{source_port_index}</SOURCE_PORT_INDEX>
      <DESTINATION_TILE_ID>{destination_tile_id}</DESTINATION_TILE_ID><DESTINATION_PORT_INDEX>{destination_port_index}</DESTINATION_PORT_INDEX>
    </CONNECT>

}

// ------ Module ------
class Connect_Module {

}