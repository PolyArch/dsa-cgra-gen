package cgra.config

import cgra.IR.system
import cgra.config.encoding.update_encoding

object system {
  var data_word_width : Int = -1
  var host_word_width : Int= -1
  var num_test_data_memory_words : Int= -1
  var test_data_memory_buffer_depth : Int= -1
  var input_ports : List[String] = Nil
  var output_ports : List[String] = Nil
  def update_system (p:system) = {
    data_word_width = p.data_word_width
    host_word_width = p.host_word_width
    num_test_data_memory_words = p.num_test_data_memory_words
    test_data_memory_buffer_depth = p.test_data_memory_buffer_depth
    input_ports = p.input_ports
    output_ports = p.output_ports
    update_encoding
  }
}
