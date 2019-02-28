package cgra.fabric

import cgra.parameter._
import chisel3._
import chisel3.util._
import cgra.common.mmio._
import cgra.parameter.Constant._


// ------ Parameters ------
case class RouterParams(parent_type: String,
                        parent_id: Int,
                        tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int)
  with IsParameters {
  override val module_type:String = "Router"
  // Parameter Operation
  private def add_internal(key:IsKey,mux:MUX):Unit = {
    add_internal(key,mux.asInstanceOf[IsParameters])
    if(mux.hasSource)
      for (s<- mux.sources){
        val k = port_subnet(INPUT_TYPE,s.port,s.subnet,s.num_subnet)
        add_internal(k,mux.asInstanceOf[IsParameters])
      }
  }

  // Add MUX connection
  def add_mux_connect(in:port_subnet,out:port_subnet):Unit ={
    //require(in.num_subnet == out.num_subnet,"please use port index to connect two ports, that having different decomposer")
    val possible_mux_of_output = find_internal(out,MUX())
    val muxes:List[MUX] = possible_mux_of_output.distinct
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
  def add_mux_connect(source_port:Int,des_port:Int):Unit = {
    val des_port_list = output_ports_list.filter(_.port == des_port)
    val source_port_list = input_ports_list.filter(_.port == source_port)
    val source_num_subnet = source_port_list.head.num_subnet
    val des_num_subnet = des_port_list.head.num_subnet
    if (source_num_subnet != des_num_subnet){
      if (source_num_subnet > des_num_subnet){
        for (out_s <- 0 until des_num_subnet){
          val d_ps = des_port_list.find(p=>p.subnet == out_s).get
          val s_matched_subnet:List[Int] = subnet_match_less(out_s,des_num_subnet,source_num_subnet)
          for (source_subnet <- s_matched_subnet){
            val source_port_subnet = source_port_list.find(p=>p.subnet == source_subnet).get
            add_mux_connect(source_port_subnet,d_ps)
          }
        }
      }else{
        for (out_s <- 0 until des_num_subnet){
          val d_ps = des_port_list.find(p=>p.subnet == out_s).get
          val s_matched_subnet:Int = subnet_match(out_s,des_num_subnet,source_num_subnet)
          val source_port_subnet = source_port_list.find(p=>p.subnet == s_matched_subnet).get
          add_mux_connect(source_port_subnet,d_ps)
        }
      }
    }else{
      for (s <- 0 until des_num_subnet){
        val s_ps = source_port_list.find(p=>p.subnet == s).get
        val d_ps = des_port_list.find(p=>p.subnet == s).get
        add_mux_connect(s_ps,d_ps)
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

  def arrange_mux_configuration_memory : Unit= {
    val key_muxes = get_mux_information(OUTPUT_TYPE).toList
    val key_mux = key_muxes.map(x=>(x._1,x._2.head))
    key_mux.head._2.config_sec = 0
    key_mux.head._2.base = 0
    key_mux.head._2.get_bound(key_mux.head._2.sources.length)
    for (i <- 1 until key_mux.length){
      val previous_sec = key_mux(i - 1)._2.config_sec
      val previous_base = key_mux(i - 1)._2.base
      val previous_bound = key_mux(i - 1)._2.bound
      val range = key_mux(i)._2.get_config_range
      val conf_bundle =
        calaulate_config_location(config_file_width,range,previous_sec,
          previous_bound,previous_base)
      key_mux(i)._2.config_sec = conf_bundle._1
      key_mux(i)._2.bound = conf_bundle._2
      key_mux(i)._2.base = conf_bundle._3
    }
    num_config_register = 1 + (key_mux.map(_._2.config_sec) max)
  }

  // Ready for Synthesis
  def ReadyForSynthesis = {
    arrange_mux_configuration_memory
  }

  // --- Check ---

  // All output port have mux
  def check_port_list_isDefined(a:List[port_subnet])  = {
    require(a.forall(InternalParam.isDefinedAt(_)),s"All ${a.head.io} port " +
      "and its subnet need to have at least one mux")
  }
}

// ------ Module ------
class Router(p:TileParams) extends Module {
  val param = p.asInstanceOf[RouterParams]
  val io = IO(new Bundle{
    val tile_io = param.get_tile_bundle
    val host_interface = new mmio_if
  })
  val word_width = param.get_word_width
  val input_decomposer = param.input_word_width_decomposer
  val output_decomposer = param.output_word_width_decomposer

  val ps_muxes_param = param.get_mux_information(OUTPUT_TYPE)
  val config_reg_width = param.config_file_width
  val num_config_reg = param.num_config_register

  // --- Hardware ---
  val config_registers = Reg(Vec(num_config_reg, UInt(config_reg_width.W)))

  // Destination
  for (ps_mux <- ps_muxes_param){
    val destination_port_subnet = ps_mux._1.asInstanceOf[port_subnet]
    val mux = ps_mux._2.head
    val des_port = destination_port_subnet.port
    val des_subnet = destination_port_subnet.subnet
    val des_num_subnet = destination_port_subnet.num_subnet
    val sources = mux.sources
    val decompoed_word_width = word_width / destination_port_subnet.num_subnet
    for (source_i <- sources.zipWithIndex){
      val index = source_i._2
      val source_port_subnet = source_i._1
      val source_port = source_port_subnet.port
      val source_subnet = source_port_subnet.subnet
      val source_num_subnet = source_port_subnet.num_subnet
      io.tile_io.out(des_port)(des_subnet).data := 0.U
      io.tile_io.out(des_port)(des_subnet).req := false.B
      if (des_num_subnet == source_num_subnet){
        when(config_registers(mux.config_sec)(mux.bound,mux.base) === index.U){
          io.tile_io.out(des_port)(des_subnet).data :=
            io.tile_io.in(source_port)(source_subnet).data
          io.tile_io.out(des_port)(des_subnet).req :=
            io.tile_io.in(source_port)(source_subnet).req
        }
      }else{
        val input_combined_word: UInt =
          io.tile_io.in(source_port).map(_.data).reduce(Cat(_, _))
        val input_combined_req: Bool =
          if (des_num_subnet > source_num_subnet){
            val ss = param.subnet_match(des_subnet,des_num_subnet,source_num_subnet)
            io.tile_io.in(source_port)(ss).req
          }else{
            io.tile_io.in(source_port).zipWithIndex
              .filter(x=>param.subnet_match(x._2,des_subnet,source_num_subnet,des_num_subnet))
              .map(_._1.req).reduce(_ && _)
          }
        io.tile_io.out(des_port)(des_subnet).data :=
          input_combined_word(decompoed_word_width * (des_subnet + 1) - 1, decompoed_word_width * des_subnet)
        io.tile_io.out(des_port)(des_subnet).req := input_combined_req
      }
    }
  }

  // Source
  val source_port_subnet_muxes = param.get_mux_information(INPUT_TYPE)
  for (source_muxes <- source_port_subnet_muxes){
    val muxes:List[MUX] = source_muxes._2
    val source = source_muxes._1.asInstanceOf[port_subnet]
    val source_port = source.port
    val source_subnet = source.subnet
    val combined_ack = muxes.map(x=>{
      val mux = x
      val output_port_subnet = param.InternalParam
        .filter(y=>y._2.contains(mux) && y._1.asInstanceOf[port_subnet].io == OUTPUT_TYPE)
        .head._1.asInstanceOf[port_subnet]
      val select_value = mux.sources.indexOf(source)
      val selected = config_registers(mux.config_sec)(mux.bound,mux.base) === select_value.U
      val des_port = output_port_subnet.port
      val des_subnet = output_port_subnet.subnet
      Mux(selected,io.tile_io.out(des_port)(des_subnet).ack,true.B)
    }).reduce(_ && _)
    io.tile_io.in(source_port)(source_subnet).ack := combined_ack
  }

  // Update the Registers
  val write_index = io.host_interface.write_index
  val write_data = io.host_interface.write_data
  val write_ack = io.host_interface.write_ack
  when(io.host_interface.write_req){
    config_registers(write_index) := write_data
  }

  // host interface is write-only, write ack is no-latency
  write_ack := true.B
  io.host_interface.read_ack := false.B
  io.host_interface.read_data := 0.U

}