// This file contains parameters that can truly be turned to hardware(tiles), should be case class

package cgra.config

import config._

// ------ Keys ------

case class Router_Key(parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[RouterParams](RouterParams(parent_name,parent_id,tile_id))

case class Dedicated_PE_Key(parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[DedicatedPeParams](DedicatedPeParams(parent_name,parent_id,tile_id))

case class Shared_PE_Key(parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[SharedPeParams](SharedPeParams(parent_name,parent_id,tile_id))

case class Alu_Key(parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[AluParams](AluParams(parent_name,parent_id:Int,tile_id))

// ------ Parameters ------

// Arithmetic Logic Unit
case class AluParams(parent_type: String,parent_id:Int,tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int){
  override val module_type:String = "arithmetic_logic_unit"
  val inst_set : Array[Int] = null
}

// Dedicated Processing Unit
case class DedicatedPeParams(parent_type: String,
                             parent_id: Int,
                             tile_id:Int)
  extends HasPeParams(parent_type: String,parent_id:Int,tile_id:Int) {
  override val inst_firing : String = "dedicated"
  var mux_parameters : Parameters = null
  var alu_parameters : Parameters = null
  var delay_pipe_parameters : Parameters = null
}

// Triggered Instruction Architecture6
case class SharedPeParams(parent_type: String,
                          parent_id: Int,
                          tile_id:Int)
  extends HasPeParams(parent_type: String,parent_id:Int,tile_id:Int){
  override val inst_firing : String = "shared"

}

// Router
case class RouterParams(parent_type: String,
                        parent_id: Int,
                        tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int){
  override val module_type:String = "router"
  val ports_params : Array[port_param] = new Array[port_param](num_output)
}

// Interface Ports
case class InterfacePortParams(parent_type: String,
                               parent_id: Int,
                               tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int){
  override val module_type:String = "ip_port"
  var buffer_depth       : Array[Int] = null
}

