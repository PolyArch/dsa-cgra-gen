package cgra.config

import chisel3.core._
import config._
/*
class Connect_Config(cid:Connect,
                     source_port_index:Int,
                     destination_port_index:Int) extends Config((site,here,up) => {
  case cid:Connect => {
    val new_connect_param = Connect_Param(cid.id)
    new_connect_param.source_tile_id = cid.source_tile_id
    new_connect_param.destination_tile_id = cid.destination_tile_id
    new_connect_param.source_port_index = source_port_index
    new_connect_param.destination_port_index = destination_port_index
    new_connect_param
  }

})
*/
case class Connect(id:Int,source_tile_id:Int,destination_tile_id:Int)
  extends Field[Connect_Param]

case class Connect_Param(connect_id:Int)
  extends isParameters{
  var source_tile_id :Int = -1
  var destination_tile_id : Int = -1
  var source_port_index : Int = -1
  var destination_port_index : Int = -1
}