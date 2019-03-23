package cgra.config

import cgra.config.system._
import cgra.IR.global_var.module_id_width

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
}
