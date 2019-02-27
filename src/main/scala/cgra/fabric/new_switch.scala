package cgra.fabric

import cgra.config._
import chisel3._
import chisel3.util._
import cgra.common.mmio._
import cgra.config.Constant._

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
  val num_config_reg = param.arrange_mux_configuration_memory(config_reg_width)

  // --- Hardware ---
  val config_registers = RegInit(Vec(num_config_reg,0.U(config_reg_width.W)))

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
      if (destination_port_subnet.num_subnet == source_port_subnet.num_subnet){
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

  /*
  // Output Port Connection (data and req)
  for (i <- 0 until param.get_num_output) {
    val configs = param.output_ports_params(i).source_configs
    val num_subnet = output_decomposer(i)
    val decompoed_word_width = word_width / num_subnet
    for (s <- 0 until num_subnet) {
      io.tile_io.out(i)(s).data := 0.U
      io.tile_io.out(i)(s).req := false.B
      for (j <- 0 until nums_config(i)) {
        val source_port = configs(j)(s)
        val source_port_de = input_decomposer(source_port.port)
        when(configs_registers(i) === j.U) {

          if (source_port_de == num_subnet) {

            io.tile_io.out(i)(s).data := io.tile_io.in(source_port.port)(source_port.subnet).data
            io.tile_io.out(i)(s).req := io.tile_io.in(source_port.port)(source_port.subnet).req

          } else {

            val input_combined_word: UInt =
              io.tile_io.in(source_port.port).map(_.data).reduce(Cat(_, _))
            val input_combined_req: Bool =
              io.tile_io.in(source_port.port).map(_.req).reduce(_ || _)
            io.tile_io.out(i)(s).data :=
              input_combined_word(decompoed_word_width * (s + 1) - 1, decompoed_word_width * s)
            io.tile_io.out(i)(s).req := input_combined_req

          }

        }
      }
    }
  }

  // Input Port Connection (ack)
  for (i <- 0 until param.get_num_input){
    val num_subnet = input_decomposer(i)
    for (s <- 0 until num_subnet){
      val destinations = param.get_destination_subnet_by_source_subnet(i,s)
      val output_combined_ack:Bool = destinations.map(x=>{
        val port = x._1
        val subnet = x._2
        io.tile_io.out(port)(subnet).ack
      }).reduce(_&&_)
      io.tile_io.in(i)(s).ack := output_combined_ack
    }
  }
  */
}