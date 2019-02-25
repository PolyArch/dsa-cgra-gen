package cgra.fabric

import cgra.config._
import chisel3._
import chisel3.util._
import cgra.common.mmio._

class Router(p:TileParams) extends Module {
  val param = p.asInstanceOf[RouterParams]
  val io = IO(new Bundle{
    val tile_io = param.get_tile_bundle
    val host_interface = new mmio_if
  })

  val word_width = param.get_word_width
  val input_decomposer = param.input_word_width_decomposer
  val output_decomposer = param.output_word_width_decomposer

  // Hardware
  val nums_config = param.output_ports_params.map(_.num_config)
  val configs_registers = nums_config.map(x=>RegInit(0.U(log2Ceil(x).W)))

  // Output Port Connection (data and req)
  for (i <- 0 until param.get_num_output) {
    val configs = param.output_ports_params(i).destination_config
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
            val input_combined_word: UInt = io.tile_io.in(source_port.port).map(_.data).reduce(Cat(_, _))
            val input_combined_req: Bool = io.tile_io.in(source_port.port).map(_.req).reduce(_ || _)
            io.tile_io.out(i)(s).data := input_combined_word(decompoed_word_width * (s + 1) - 1, decompoed_word_width * s)
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

  // Update the Registers
  val write_index = io.host_interface.write_index
  val write_data = io.host_interface.write_data
  val write_ack = io.host_interface.write_ack
  for (i <- 0 until param.get_num_output){
    when(io.host_interface.write_req && write_index === i.U){
      configs_registers(i) := write_data(log2Ceil(nums_config(i))-1,0)
    }
  }

  // host interface is write-only, write ack is no-latency
  write_ack := true.B
  io.host_interface.read_ack := false.B
  io.host_interface.read_data := 0.U
}