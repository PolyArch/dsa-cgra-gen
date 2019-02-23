package cgra.config

import chisel3.core._
import config._

class Connect_Config(cid:Connect_ID,
                     source_port_index:Int,
                     destination_port_index:Int) extends Config((site,here,up) => {
  case cid:Connect_ID => Connect_Tile_Param(cid.id,cid.source_tile_id,cid.destination_tile_id,source_port_index,destination_port_index)
})

case class Connect_ID(id:Int,source_tile_id:Int,destination_tile_id:Int)
  extends Field[Connect_Tile_Param]

case class Connect_Tile_Param(connect_id:Int,
                              source_tile_id :Int,
                              destination_tile_id : Int,
                              source_port_index : Int,
                              destination_port_index : Int)