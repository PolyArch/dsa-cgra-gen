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
  with IsParameters {
  override val module_type:String = "arithmetic_logic_unit"
  val inst_set : Array[Int] = null
}

// Dedicated Processing Unit
case class DedicatedPeParams(parent_type: String,
                             parent_id: Int,
                             tile_id:Int)
  extends PeParams(parent_type: String,parent_id:Int,tile_id:Int)
  with IsParameters {
  override val inst_firing : String = "dedicated"

}

// Triggered Instruction Architecture6
case class SharedPeParams(parent_type: String,
                          parent_id: Int,
                          tile_id:Int)
  extends PeParams(parent_type: String,parent_id:Int,tile_id:Int)
  with IsParameters {
  override val inst_firing : String = "shared"

}

// Router
case class RouterParams(parent_type: String,
                        parent_id: Int,
                        tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int)
  with IsParameters {
  override val module_type:String = "Router"
/*
  // Get information
  def get_destination_subnet_by_source_subnet(port:Int,subnet:Int):List[(Int,Int)] = {
    val des = for {
      i <- 0 until get_num_output
      s <- 0 until output_word_width_decomposer(i)
      val subnet_param = output_ports_params(i).subnets_param(s)
      if subnet_param.source_param.map(x=>(x.port,x.subnet)).contains((port,subnet))
    } yield (i,s)
    des.toList
  }
  def get_num_config_of_destination_port(n:Int) = {
    get_output_port(n).source_configs.length
  }
  def calulate_all_output_config_mode(method:String):List[List[List[subnet_location_param]]] = {
    output_ports_params.foreach(_.method = method)
    output_ports_params.foreach(x=>x.get_source_mode(x.subnets_param.map(_.source_param)))
    output_ports_params.map(_.source_configs)
  }
  def calulate_all_output_config_mode:List[List[List[subnet_location_param]]] = {
    output_ports_params.foreach(x=>calulate_all_output_config_mode(x.method))
    output_ports_params.map(_.source_configs)
  }
  def calulate_output_config(i:Int,method:String) = {
    output_ports_params(i).get_source_mode(method,output_ports_params(i).subnets_param.map(_.source_param))
  }

  // Set up parameters
  def use_subnet_match_connect = {
    for (i<- 0 until num_output){
      for (s <- 0 until output_word_width_decomposer(i)){
        for(j <- 0 until num_input){
          connect_subnet(j,s,i,s)
        }
      }
    }
  }
  def add_neighbor_loop_connect(in:Int,out:Int,way:String) = {
    require(input_word_width_decomposer(in)==output_word_width_decomposer(out),
      s"In order to achieve inter-subnet communication, In Port ${in} and Out Port ${out}" +
        s"should have same amount of subnet")
    val num_subnet = input_word_width_decomposer(in)
    way match {
      case "ascend" =>
        for (s <- 0 until num_subnet - 1){
          connect_subnet(in,s,out,s+1)
        }
        connect_subnet(in,num_subnet - 1,out,0)
      case "descend" =>
        for (s <- 1 until num_subnet){
          connect_subnet(in,s,out,s-1)
        }
        connect_subnet(in,0,out,num_subnet - 1)
    }
  }
  def connect_subnet(in_port:Int,in_sub:Int,out_port:Int,out_subnet:Int): Unit ={
    output_ports_params(out_port).subnets_param(out_subnet).source_param =
      subnet_location_param(in_port,in_sub) :: output_ports_params(out_port).subnets_param(out_subnet).source_param
  }
  */
}

// Interface Ports
case class InterfacePortParams(parent_type: String,
                               parent_id: Int,
                               tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int)
  with IsParameters {
  override val module_type:String = "ip_port"
  var buffer_depth       : Array[Int] = null
}

// CGRA (for further use, in case we need one CGRA to be a tile itself, which means we can have multiple CGRAs)
case class CgraParams(parent_type: String,
                parent_id: Int,
                tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int)
  with IsParameters {

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