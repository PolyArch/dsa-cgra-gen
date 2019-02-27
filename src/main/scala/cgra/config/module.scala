// This file contains parameters that can truly be turned to hardware(tiles), should be case class

package cgra.config

import config._
import cgra.config.Constant._


// ------ Keys ------
case class Router private (parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[RouterParams](RouterParams(parent_name,parent_id,tile_id))

case class Dedicated_PE private (parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[DedicatedPeParams](DedicatedPeParams(parent_name,parent_id,tile_id))

case class Shared_PE private (parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[SharedPeParams](SharedPeParams(parent_name,parent_id,tile_id))
/*
case class Alu private (parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[AluParams](AluParams(parent_name,parent_id:Int,tile_id))
*/
case class Cgra private (parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[CgraParams](CgraParams(parent_name,parent_id,tile_id))

// ------ Parameters ------
/*
// Arithmetic Logic Unit
case class AluParams(parent_type: String,parent_id:Int,tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int)
  with IsParameters {
  override val module_type:String = "arithmetic_logic_unit"
  val inst_set : Array[Int] = null
}
*/
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
  // Parameter Operation
  def add_internal(key:IsKey,mux:MUX):Unit = {
    add_internal(key,mux.asInstanceOf[IsParameters])
    if(mux.hasSource)
      for (s<- mux.sources){
        val k = port_subnet(INPUT_TYPE,s.port,s.subnet,s.num_subnet)
        add_internal(k,mux.asInstanceOf[IsParameters])
      }
  }

  // Add MUX connection
  def add_mux_connect(in:port_subnet,out:port_subnet):Unit ={
    val possible_mux_of_input = Nil//find_Param(in,MUX())
    val possible_mux_of_output = find_Param(out,MUX())
    val muxes:List[MUX] = (possible_mux_of_input union possible_mux_of_output).distinct
    val mux = if (muxes.nonEmpty){
      require(muxes.length == 1)
      muxes.head
    }else{
      MUX()
    }
    mux.add_source(in)
    add_internal(out,mux)
    add_internal(in,mux)
  }
  def add_neighbor_loop_connect(in:Int,out:Int,way:String) = {
    require(input_word_width_decomposer(in)==output_word_width_decomposer(out),
      s"In order to achieve inter-subnet communication, In Port ${in} and Out Port ${out}" +
        s"should have same amount of subnet")
    val num_subnet = input_word_width_decomposer(in)
    way match {
      case "ascend" =>
        for (s <- 0 until num_subnet - 1){
          val source_port_subnet = port_subnet(INPUT_TYPE,in,s,num_subnet)
          source_port_subnet.num_subnet = num_subnet
          val destination_port_subnet = port_subnet(OUTPUT_TYPE,out,s+1,num_subnet)
          destination_port_subnet.num_subnet = num_subnet
          add_mux_connect(source_port_subnet,destination_port_subnet)
        }
        val source_port_subnet = port_subnet(INPUT_TYPE,in,num_subnet-1,num_subnet)
        source_port_subnet.num_subnet = num_subnet
        val destination_port_subnet = port_subnet(OUTPUT_TYPE,out,0,num_subnet)
        destination_port_subnet.num_subnet = num_subnet
        add_mux_connect(source_port_subnet,destination_port_subnet)
      case "descend" =>
        for (s <- 1 until num_subnet){
          val source_port_subnet = port_subnet(INPUT_TYPE,in,s,num_subnet)
          source_port_subnet.num_subnet = num_subnet
          val destination_port_subnet = port_subnet(OUTPUT_TYPE,out,s-1,num_subnet)
          destination_port_subnet.num_subnet = num_subnet
          add_mux_connect(source_port_subnet,destination_port_subnet)
        }
        val source_port_subnet = port_subnet(INPUT_TYPE,in,0,num_subnet)
        source_port_subnet.num_subnet = num_subnet
        val destination_port_subnet = port_subnet(OUTPUT_TYPE,out,num_subnet - 1,num_subnet)
        destination_port_subnet.num_subnet = num_subnet
        add_mux_connect(source_port_subnet,destination_port_subnet)
    }
  }

  def get_mux_information(io_type:String) = {
    InternalParam.filter(x=>x._1.asInstanceOf[port_subnet].io == io_type&&
      x._2.exists(y=>y.isInstanceOf[MUX]))
      .map(x=>(x._1,x._2.filter(y=>y.isInstanceOf[MUX]).asInstanceOf[List[MUX]]))
  }

  def arrange_mux_configuration_memory(cf_b_width:Int) : Int= {
    config_file_width = cf_b_width
    val key_muxes = get_mux_information(OUTPUT_TYPE).toList
    val key_mux = key_muxes.map(x=>(x._1,x._2.head))

    key_mux.head._2.config_sec = 0
    key_mux.head._2.base = 0
    key_mux.head._2.get_bound(key_mux.head._2.sources.length)

    for (i <- 1 until key_mux.length){

      val try_base:Int = key_mux(i-1)._2.bound + 1
      key_mux(i)._2.base = try_base
      val try_bound:Int = key_mux(i)._2.get_bound(key_mux(i)._2.sources.length)

      if (try_base/cf_b_width != try_bound/cf_b_width) {
        key_mux(i)._2.config_sec = key_mux(i - 1)._2.config_sec + 1
        key_mux(i)._2.base = (try_bound / cf_b_width) * cf_b_width
      }else if(try_base >= cf_b_width){
        key_mux(i)._2.config_sec = key_mux(i - 1)._2.config_sec + 1
        key_mux(i)._2.base = 0
      }else{
        key_mux(i)._2.config_sec = key_mux(i - 1)._2.config_sec
        key_mux(i)._2.base = try_base
      }

      key_mux(i)._2.get_bound(key_mux(i)._2.sources.length)
    }
    val test = 1
    1 + (key_mux.map(_._2.config_sec) max)
  }

  // Check all output port have mux
  def check_port_list_isDefined(a:List[port_subnet])  = {
    require(a.forall(InternalParam.isDefinedAt(_)),"All input/output port " +
      "and its subnet need to have at least one mux")
  }

  /* TODO This part code is totally shit, my brain must fucked up when I wrote them
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