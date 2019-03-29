package cgra.config

import cgra.config.encoding.update_encoding

import scala.collection.mutable

object system {
  var data_word_width : Int = -1
  var host_word_width : Int= -1
  var num_test_data_memory_words : Int= -1
  var test_data_memory_buffer_depth : Int= -1
  var input_ports : List[String] = Nil
  var output_ports : List[String] = Nil
  def update_system (pp:Any) = {
    val p : mutable.Map[String,Any] = pp.asInstanceOf[mutable.Map[String,Any]]
    data_word_width = p("data_word_width").asInstanceOf[Int]
    host_word_width = p("host_word_width").asInstanceOf[Int]
    num_test_data_memory_words = p("num_test_data_memory_words").asInstanceOf[Int]
    test_data_memory_buffer_depth = p("test_data_memory_buffer_depth").asInstanceOf[Int]
    input_ports = p("input_ports").asInstanceOf[List[String]]
    output_ports = p("output_ports").asInstanceOf[List[String]]
    update_encoding
  }
}
