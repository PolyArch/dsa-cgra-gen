// This file contains parameters that can truly be turned to hardware(tiles), should be case class

package cgra.config

import config._

// ------ Keys ------
case class Router(parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[RouterParams](RouterParams(parent_name,parent_id,tile_id))

case class Dedicated_PE(parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[DedicatedPeParams](DedicatedPeParams(parent_name,parent_id,tile_id))

case class Shared_PE(parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[SharedPeParams](SharedPeParams(parent_name,parent_id,tile_id))

case class Alu(parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[AluParams](AluParams(parent_name,parent_id:Int,tile_id))

case class Cgra(parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[CgraParams](CgraParams(parent_name,parent_id,tile_id))

// ------ Parameters ------

// Arithmetic Logic Unit
case class AluParams(parent_type: String,parent_id:Int,tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int)
  with isParameters {
  override val module_type:String = "arithmetic_logic_unit"
  val inst_set : Array[Int] = null
}

// Dedicated Processing Unit
case class DedicatedPeParams(parent_type: String,
                             parent_id: Int,
                             tile_id:Int)
  extends PeParams(parent_type: String,parent_id:Int,tile_id:Int)
  with isParameters {
  override val inst_firing : String = "dedicated"
  def has_ports(n:Int) = {num_output = n;num_input = n}
  def has_outputs(n:Int) = {num_output = n}
  def has_inputs(n:Int) = {num_input = n}
  var mux_parameters : Parameters = null
  var alu_parameters : Parameters = null
  var delay_pipe_parameters : Parameters = null
}

// Triggered Instruction Architecture6
case class SharedPeParams(parent_type: String,
                          parent_id: Int,
                          tile_id:Int)
  extends PeParams(parent_type: String,parent_id:Int,tile_id:Int)
  with isParameters {
  override val inst_firing : String = "shared"

}

// Router
case class RouterParams(parent_type: String,
                        parent_id: Int,
                        tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int)
  with isParameters {
  override val module_type:String = "router"
  var ports_params : List[port_param] = Nil
  def port(port_index:Int)={
    ports_params(port_index)
  }
  def has_ports(n:Int) = {num_output = n;num_input = n
    for (i <- 0 until n){
      ports_params = port_param(i,1) :: ports_params
    }
  }
  def has_ports(n:Int,num_subnet:Int)= {num_output = n;num_input = n
    for (i <- 0 until n){
      ports_params = port_param(i,num_subnet) :: ports_params
    }
  }
  def has_outputs(n:Int) = {num_output = n}
  def has_inputs(n:Int) = {num_input = n}
}

// Interface Ports
case class InterfacePortParams(parent_type: String,
                               parent_id: Int,
                               tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int)
  with isParameters {
  override val module_type:String = "ip_port"
  var buffer_depth       : Array[Int] = null
}

// CGRA (for further use, in case we need one CGRA to be a tile itself, which means we can have multiple CGRAs)
case class CgraParams(parent_type: String,
                parent_id: Int,
                tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int)
  with isParameters {

  override val module_type: String = "CGRA"

  var ProcessingElements_Size:(Int,Int) = (0,0)

  var routers_params :List[RouterParams] = Nil
  var pe_params : List[PeParams] = Nil
  var interface_port_params : List[InterfacePortParams] = Nil
  var connects_params : List[Connect_Param] = Nil

  def fill_processing_element(pe:TileParams) : Unit = {

  }
}