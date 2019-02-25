// This file contains parameters that can truly be turned to hardware(tiles), should be case class

package cgra.config

import config._

// ------ Keys ------
case class Router private (parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[RouterParams](RouterParams(parent_name,parent_id,tile_id))

case class Dedicated_PE private (parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[DedicatedPeParams](DedicatedPeParams(parent_name,parent_id,tile_id))

case class Shared_PE private (parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[SharedPeParams](SharedPeParams(parent_name,parent_id,tile_id))

case class Alu private (parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[AluParams](AluParams(parent_name,parent_id:Int,tile_id))

case class Cgra private (parent_name:String,parent_id:Int,tile_id:Int)
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
  override val module_type:String = "Router"
  var input_ports_params : List[port_param] = Nil
  var output_ports_params : List[port_param] = Nil

  // Port Operation
  def get_port(port_index:Int)={
    (input_ports_params(port_index),output_ports_params(port_index))
  }
  def get_input_port(i:Int) = {
    input_ports_params(i)
  }
  def get_output_port(i:Int) = {
    output_ports_params(i)
  }
  def has_ports(n:Int):Unit = {
    has_ports(n,default_decomposer)
  }
  def has_ports(n:Int,num_subnet:Int):Unit= {
    has_inputs(n,num_subnet)
    has_outputs(n,num_subnet)
  }
  def has_inputs(n:Int):Unit = has_inputs(n,default_decomposer)
  def has_inputs(n:Int, d:Int):Unit = {
    change_num_input(n)
    for (i <- 0 until n){
      input_ports_params = input_ports_params ::: List(port_param("input",i,d))
      add_input_decomposer(d)
    }
  }
  def had_outputs(n:Int) :Unit= has_outputs(n,default_decomposer)
  def has_outputs(n:Int,d:Int):Unit = {
    change_num_output(n)
    for (i <- 0 until n){
      output_ports_params = output_ports_params ::: List(port_param("output",i,d))
      add_output_decomposer(d)
    }
  }

  // Get information
  def get_destination_subnet_by_source_subnet(port:Int,subnet:Int)
  :List[(Int,Int)] = {
    val des = for {
      i <- 0 until get_num_output
      s <- 0 until output_word_width_decomposer(i)
      val subnet_param = output_ports_params(i).subnets_param(s)
      if subnet_param.source_param.map(x=>(x.port,x.subnet)).contains((port,subnet))
    } yield (i,s)
    des.toList
  }
  def get_num_config_of_destination_port(n:Int) = {
    get_output_port(n).destination_config.length
  }
  def calulate_all_output_config_mode(method:String):List[List[List[subnet_location_param]]] = {
    output_ports_params.foreach(_.method = method)
    output_ports_params.foreach(_.get_source_mode)
    output_ports_params.map(_.destination_config)
  }
  def calulate_all_output_config_mode:List[List[List[subnet_location_param]]] = {
    output_ports_params.foreach(x=>calulate_all_output_config_mode(x.method))
    output_ports_params.map(_.destination_config)
  }
  def calulate_output_config(i:Int,method:String) = {
    output_ports_params(i).get_source_mode(method)
  }

  // Set up parameters
  def use_subnet_match_connect = {
    for (i<- 0 until num_output){
      for (s <- 0 until output_word_width_decomposer(i)){
        for(j <- 0 until num_input){
          output_ports_params(i).subnets_param(s).source_param =
            subnet_location_param(j,s) :: output_ports_params(i).subnets_param(s).source_param
        }
      }
    }
  }
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

  private var routers_params :List[RouterParams] = Nil
  private var pe_params : List[PeParams] = Nil
  private var interface_port_params : List[InterfacePortParams] = Nil
  private var connects_params : List[ConnectParam] = Nil

  def fill_processing_element(pe:TileParams) : Unit = {

  }
  def interconnect (connects:List[ConnectParam]) : Unit ={
    connects_params = connects
  }
}