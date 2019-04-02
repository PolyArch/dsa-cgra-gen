package cgra.config

import cgra.config.system_var._
import cgra.config.system_util._

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
