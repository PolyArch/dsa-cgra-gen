package cgra.IR

import org.yaml.snakeyaml.Yaml
import org.yaml.snakeyaml.constructor.Constructor
import java.io.{File, FileInputStream}
import java.util

import scala.beans.BeanProperty
import scala.collection.mutable._
import IRconvertor._
import chisel3.experimental.RawModule
import cgra.config.system.data_word_width
import cgra.fabric.YamlV.Cgra_Hw
import chisel3.core.Module

import scala.collection.JavaConverters._
import scala.collection.convert.WrapAsJava
import scala.collection.mutable


object IRreader {
  def readCgra(filename:String) = {
    val input = new FileInputStream(new File(filename))
    val yaml = new Yaml()
    val j_cgra = yaml.load(input).asInstanceOf[util.Map[String,Any]]
    val s_cgra = JavaMap2ScalaMap(j_cgra)
    s_cgra += "description_filename" -> filename
    s_cgra += "config_filename" -> filename.replace("yaml","xml")
    s_cgra
  }
}

case class Cgra (t:Map[String,Any]) {
   var description_filename : String = t("description_filename") toString
   var config_filename : String = t("config_filename") toString
   val system : system = t("system").asInstanceOf[Map[String,Any]]
   val vector_ports : Map[String,vector_port] = t("vector_ports").asInstanceOf[Map[String,Any]]
   val dedicated_pes : Map[String,dedicated_pe] = t("dedicated_pes").asInstanceOf[Map[String,Any]]
   val shared_pes : Map[String,shared_pe] = t("shared_pes").asInstanceOf[Map[String,Any]]
   val routers : Map[String,router] = t("routers").asInstanceOf[Map[String,Any]]
   val topology : List[connection] = t("topology").asInstanceOf[List[Map[String,Any]]]
}

/*
class CgraYAML {
   var system : system = _
   var routers :       util.LinkedHashMap[String,Any] = _
   var dedicated_pes : util.LinkedHashMap[String,Any] = _
   var shared_pes :    util.LinkedHashMap[String,Any] = _
   var vector_ports :  util.LinkedHashMap[String,Any] = _
   var topology :      util.ArrayList[Any] = _
}
*/

class system {
   var module_type : String = ""
   var data_word_width : Int = -1
   var host_word_width : Int= -1
   var num_test_data_memory_words : Int= -1
   var test_data_memory_buffer_depth : Int= -1
   var input_ports : List[String] = _
   var output_ports : List[String] = _
}

class tile {
   var module_type : String = ""
   var input_ports : List[String] = Nil
   var output_ports : List[String] = Nil
}

class port_subnet {
  var port : String = ""
  var subnet : Int = -1
  override def equals(o: Any): Boolean = {
    o match {
      case o:port_subnet => this.port == o.port && this.subnet == o.subnet
      case _ => false
    }
  }
}
class subnet_connection {
  var source : port_subnet = new port_subnet
  var sink : port_subnet = new port_subnet
}
class router extends tile
  with register_configured{
   var decomposer : Int = -1
   var inter_subnet_connection : List[subnet_connection] = _
}

class backpressure {
  var valid : Boolean = _
  var max_delay : Int = -1
}
class metaReuse {
  var valid : Boolean = _
  var num_reuse : Int = -1
}
class dedicated_pe extends tile
  with register_configured{
   var decomposer : Int = -1
   var has_backpressure : backpressure = new backpressure
   var has_metaReuse : metaReuse = new metaReuse
   var instructions : Map[String,List[String]] = _
}

class shared_pe extends tile
  with register_configured{
   var architecture : String = ""
   var immediate_width: Int = -1
   var mm_instruction_width: Int =  -1
   var num_instructions : Int = -1
   var num_predicates: Int = -1
   var num_registers: Int = -1
  // Instruction features.
   var has_multiplier: Boolean = _
   var has_two_word_product_multiplier: Boolean = _
   var has_scratchpad: Boolean = _
   var num_scratchpad_words: Int = -1
  // Instruction memory microarchitecture.
   var latch_based_instruction_memory: Boolean = _
   var ram_based_immediate_storage: Boolean = _
  // Channels.
   var channel_buffer_depth: Int = -1 // Must be >= 2.
   var max_num_input_channels_to_check: Int = -1
   var num_tags: Int = -1
  // Pipeline features.
   var has_speculative_predicate_unit: Boolean = _
   var has_effective_queue_status: Boolean = _
  // Debugging and profiling features.
   var has_debug_monitor: Boolean = _
   var has_performance_counters: Boolean = _
}

class vector_port  extends tile{
   var channel_buffer : Int = -1
   var io_type : String = ""
}

class connection {
  class port_location {
    var module : String = ""
    var port : String = ""
  }
   var source : port_location = new port_location
   var sink : port_location = new port_location
}

// For the use of configuration

trait register_configured {
  var module_id : Int = -1
   var config_input_port : String = ""
   var config_output_port : String = ""
  var config_register_file_idx_width : Int = -1
  val config_register_file_data_width : Int = data_word_width
}