package cgra.IR

import org.yaml.snakeyaml.Yaml
import org.yaml.snakeyaml.constructor.Constructor
import java.io.{File, FileInputStream}
import java.util
import scala.beans.BeanProperty
import scala.collection.mutable._
import Convertor._
import chisel3.experimental.RawModule
import cgra.config.system.data_word_width


object IRreader extends App{
  def readCgra(filename:String): Cgra = {
    val input = new FileInputStream(new File(filename))
    val yaml = new Yaml(new Constructor(classOf[CgraYAML]))
    val t_cgra = yaml.load(input).asInstanceOf[CgraYAML]
    Cgra(t_cgra)
  }
  val cgra = readCgra("/home/sihao/ss-cgra-gen/sample-IR/cgra_3x3_new.yaml")
  chisel3.Driver.execute(args,()=>
    Class.forName("cgra.fabric.YamlV."+cgra.system.module_type+"_Hw")
      .getConstructor(classOf[Cgra])
      .newInstance(cgra).asInstanceOf[RawModule])
}

case class Cgra (t:CgraYAML) {
  val vector_ports : Map[String,vector_port] = t.vector_ports
  val dedicated_pes : Map[String,dedicated_pe] = t.dedicated_pes
  val topology : List[connection] = t.topology
  val shared_pes : Map[String,shared_pe] = t.shared_pes
  val routers : Map[String,router] = t.routers
  val system : system = t.system
}

class CgraYAML {
  @BeanProperty var system : system = _
  @BeanProperty var routers :       util.LinkedHashMap[String,Any] = _
  @BeanProperty var dedicated_pes : util.LinkedHashMap[String,Any] = _
  @BeanProperty var shared_pes :    util.LinkedHashMap[String,Any] = _
  @BeanProperty var vector_ports :  util.LinkedHashMap[String,Any] = _
  @BeanProperty var topology :      util.ArrayList[Any] = _
}

class system {
  @BeanProperty var module_type : String = ""
  @BeanProperty var data_word_width : Int = -1
  @BeanProperty var host_word_width : Int= -1
  @BeanProperty var num_test_data_memory_words : Int= -1
  @BeanProperty var test_data_memory_buffer_depth : Int= -1
  @BeanProperty var input_ports : Array[String] = _
  @BeanProperty var output_ports : Array[String] = _
}

class tile {
  @BeanProperty var module_type : String = ""
  @BeanProperty var input_ports : List[String] = Nil
  @BeanProperty var output_ports : List[String] = Nil
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
  @BeanProperty var decomposer : Int = -1
  @BeanProperty var inter_subnet_connection : List[subnet_connection] = _
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
  @BeanProperty var decomposer : Int = -1
  @BeanProperty var has_backpressure : backpressure = new backpressure
  @BeanProperty var has_metaReuse : metaReuse = new metaReuse
  @BeanProperty var instructions : Map[String,List[String]] = _
}

class shared_pe extends tile {
  @BeanProperty var architecture : String = ""
  @BeanProperty var immediate_width: Int = -1
  @BeanProperty var mm_instruction_width: Int =  -1
  @BeanProperty var num_instructions : Int = -1
  @BeanProperty var num_predicates: Int = -1
  @BeanProperty var num_registers: Int = -1
  // Instruction features.
  @BeanProperty var has_multiplier: Boolean = _
  @BeanProperty var has_two_word_product_multiplier: Boolean = _
  @BeanProperty var has_scratchpad: Boolean = _
  @BeanProperty var num_scratchpad_words: Int = -1
  // Instruction memory microarchitecture.
  @BeanProperty var latch_based_instruction_memory: Boolean = _
  @BeanProperty var ram_based_immediate_storage: Boolean = _
  // Channels.
  @BeanProperty var channel_buffer_depth: Int = -1 // Must be >= 2.
  @BeanProperty var max_num_input_channels_to_check: Int = -1
  @BeanProperty var num_tags: Int = -1
  // Pipeline features.
  @BeanProperty var has_speculative_predicate_unit: Boolean = _
  @BeanProperty var has_effective_queue_status: Boolean = _
  // Debugging and profiling features.
  @BeanProperty var has_debug_monitor: Boolean = _
  @BeanProperty var has_performance_counters: Boolean = _
}

class vector_port  extends tile{
  @BeanProperty var channel_buffer : Int = -1
  @BeanProperty var io_type : String = ""
}

class connection {
  class port_location {
    var module : String = ""
    var port : String = ""
  }
  @BeanProperty var source : port_location = new port_location
  @BeanProperty var sink : port_location = new port_location
}

// For the use of configuration

trait register_configured {
  var module_id : Int = -1
  @BeanProperty var config_input_port : String = ""
  @BeanProperty var config_output_port : String = ""
  var config_register_file_idx_width : Int = -1
  val config_register_file_data_width : Int = data_word_width
}