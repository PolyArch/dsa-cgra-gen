package cgra.config

import cgra.config.encoding.update_encoding
import chisel3.util.log2Ceil
import scala.collection.mutable.ListBuffer
import cgra.config.system_var._
import scala.collection.mutable

/*
 * All System Variable can be access by all module
 */

object system_var {
  //
  var data_word_width : Int = -1
  var host_word_width : Int= -1
  var num_test_data_memory_words : Int= -1
  var test_data_memory_buffer_depth : Int= -1
  // Module Num / ID
  var num_module : Int = -1
  var _module_id = 0
  var module_id_width : Int = -1
  var module_id_list : ListBuffer[Int] = new ListBuffer[Int]()

}

/*
  * All System Method Should be followed with Update
  */
object system_util {
  def set_system(pp:Any) = {
    val p : mutable.Map[String,Any] = pp.asInstanceOf[mutable.Map[String,Any]]
    if(p.isDefinedAt("data_word_width"))
      data_word_width = p("data_word_width").asInstanceOf[Int]
    if(p.isDefinedAt("host_word_width"))
      host_word_width = p("host_word_width").asInstanceOf[Int]
    if(p.isDefinedAt("num_test_data_memory_words"))
      num_test_data_memory_words = p("num_test_data_memory_words").asInstanceOf[Int]
    if(p.isDefinedAt("test_data_memory_buffer_depth"))
      test_data_memory_buffer_depth = p("test_data_memory_buffer_depth").asInstanceOf[Int]
    if(p.isDefinedAt("num_module")){
      num_module = p("num_module").asInstanceOf[Int]
      set_module_id_num(num_module)
    }
    update
  }
  def get_new_id = {
    var temp : Int = -1
    val curr_max = try{
      module_id_list max
    }catch{
      case _:Throwable => -1
    }
    try{
      temp = module_id_list(_module_id)
    }catch{
      case _:Throwable =>
        temp = 1 + curr_max
        module_id_list += temp
        _module_id += 1
    }
    temp
  }
  def set_module_id_num(num:Int):Unit={
    module_id_list = List.range(0,num).to[ListBuffer]
    update
  }
  def update:Unit={
    if(module_id_list.nonEmpty)
      module_id_width = log2Ceil(module_id_list.length)
    update_encoding
  }
}
