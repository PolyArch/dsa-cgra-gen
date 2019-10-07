package cgra.config

import cgra.config.system_var._
import cgra.config.system_util._
import chisel3.util.log2Ceil

object encoding {
  var data_high = data_word_width - 1
  var data_low = 0
  var config_module_id_high : Int = -1
  var config_module_id_low : Int = -1
  def update_encoding : Unit = {
    data_high = data_word_width - 1
    config_module_id_high = data_high
    config_module_id_low = config_module_id_high - module_id_width + 1
  }

  def get_config_range(low_bit:Int, num_conf:Int) :(Int,Int)={
    (low_bit + log2Ceil(num_conf) - 1, low_bit)
  }

  def get_config_range(start_bit:Int, num_confs:Seq[Int]):Seq[(Int,Int)]={
    var low_bit = start_bit
    for(num_conf <- num_confs) yield {
      val range = get_config_range(low_bit, num_conf)
      low_bit = range._1 + 1
      range
    }
  }
  def get_config_range(num_confs:Seq[Int]):Seq[(Int,Int)]={
    get_config_range(0,num_confs)
  }
}
