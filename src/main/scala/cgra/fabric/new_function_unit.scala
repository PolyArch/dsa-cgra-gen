package cgra.fabric

import chisel3._
import chisel3.util._
import cgra.common.mmio._
import cgra.config._

class Dedicated_PE(p:TileParams) extends Module {
  val param = p.asInstanceOf[DedicatedPeParams]
  val io = IO(new Bundle{
    val tile_io = param.get_tile_bundle
    val host_interface = new mmio_if
  })
  /*
  val num_output = param.get_num_output
  val num_input = param.get_num_input
  val word_width = param.get_word_width

  val input_decomposer = param.input_word_width_decomposer
  val output_decomposer = param.output_word_width_decomposer

  val inst_lists_of_all_alus_of_all_outputs : List[List[List[Int]]] =
    param.output_ports_params.map(_.subnets_param.map(_.multiple_alu_param))

  for (o<- 0 until num_output){
    val num_subnet = output_decomposer(o)
    val decomp_word_width = word_width / num_subnet

    val source_configs = param.output_ports_params(o).subnets_param.map(_.multiple_source_param)

    for (s <- 0 until num_subnet){
      val subnet_param = param.output_ports_params(o).subnets_param(s)

      val multiple_factor = subnet_param.multiple_factor
      val multi_source = subnet_param.multiple_source_param
      val delay_pipes_max_lens = subnet_param.multiple_delay_param
      val alu_inst_list = subnet_param.multiple_alu_param


      for (multi_fac <- 0 until multiple_factor){
      }


    }
  }
*/
}