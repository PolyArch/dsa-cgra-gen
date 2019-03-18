package cgra.IR

import java.util
import chisel3.util.log2Ceil
import scala.beans.BeanProperty
import scala.collection.mutable._
import scala.collection.JavaConversions._
import cgra.config.encoding.update_encoding

object global_var {
  @BeanProperty var module_id = -1
  @BeanProperty var module_id_width : Int = -1
  @BeanProperty var module_id_list : ListBuffer[Int] = new ListBuffer[Int]()
  def get_new_id = {
    module_id += 1
    module_id_list += module_id
    module_id_width = log2Ceil(module_id_list.length)
    update_encoding
    module_id
  }
}

import global_var.get_new_id

object Convertor {
  // ------ Common ------
  implicit def JavaListString2ScalaListString(a:util.ArrayList[String]):List[String]={
    asScalaBuffer(a).toList
  }

  // ------ Topology ------
  implicit def convert2topology(c:util.ArrayList[Any]):List[connection]={
    val temp : ListBuffer[connection] = new ListBuffer[connection]()
    val ct = asScalaBuffer(c).toList
    ct.foreach(cc=>{
      temp += cc.asInstanceOf[util.LinkedHashMap[String,Any]]
    })
    temp.toList
  }
  implicit def convert2Connection(c:util.LinkedHashMap[String,Any]):connection={
    val temp_connection = new connection
    val temp_source = c.get("source").asInstanceOf[util.LinkedHashMap[String,Any]]
    val temp_sink = c.get("sink").asInstanceOf[util.LinkedHashMap[String,Any]]
    temp_connection.source.module = temp_source.get("module").toString
    temp_connection.source.port = temp_source.get("port").toString
    temp_connection.sink.module = temp_sink.get("module").toString
    temp_connection.sink.port = temp_sink.get("port").toString
    temp_connection
  }

  // ------ Vector Port ------
  implicit def convert2vectorport_list(c:util.LinkedHashMap[String,Any]):Map[String,vector_port]={
    val temp_map : Map[String,vector_port] = Map[String,vector_port]()
    for (entry <- c.entrySet) {
      val key : String = entry.getKey
      val value :vector_port = entry.getValue.asInstanceOf[util.LinkedHashMap[String,Any]]
      temp_map += key -> value
    }
    temp_map
  }
  implicit def convert2vectorport(c:util.LinkedHashMap[String,Any]):vector_port={
    val temp = new vector_port
    temp.module_type = c.get("module_type").toString
    temp.channel_buffer = c.get("channel_buffer").asInstanceOf[Int]
    temp.io_type = c.get("io_type").toString
    temp.input_ports = asScalaBuffer(c.get("input_ports").asInstanceOf[util.ArrayList[String]]).toList
    temp.output_ports = asScalaBuffer(c.get("output_ports").asInstanceOf[util.ArrayList[String]]).toList
    temp
  }

  // ------ Router ------
  implicit def convert2router_list(c:util.LinkedHashMap[String,Any]):Map[String,router]={
    val temp_map : Map[String,router] = Map[String,router]()
    for (entry <- c.entrySet()) {
      val key : String = entry.getKey
      val value :router = entry.getValue.asInstanceOf[util.LinkedHashMap[String,Any]]
      temp_map += key -> value
    }
    temp_map
  }
  implicit def convert2router(c:util.LinkedHashMap[String,Any]):router={
    implicit def convert2inter_subnet_connection(cc:util.LinkedHashMap[String,Any]):subnet_connection ={
      val temp : subnet_connection = new subnet_connection
      val temp_source = cc.get("source").asInstanceOf[util.LinkedHashMap[String,Any]]
      val temp_sink = cc.get("sink").asInstanceOf[util.LinkedHashMap[String,Any]]
      temp.source.port = temp_source.get("port").toString
      temp.source.subnet = temp_source.get("subnet").asInstanceOf[Int]
      temp.sink.port = temp_sink.get("port").toString
      temp.sink.subnet = temp_sink.get("subnet").asInstanceOf[Int]
      temp
    }
    implicit def covert2inter_subnet_connection_list(l:List[Any]):List[subnet_connection]={
      val temp : ListBuffer[subnet_connection] = new ListBuffer[subnet_connection]()
      for (ll <- l){
        temp += ll.asInstanceOf[util.LinkedHashMap[String,Any]]
      }
      temp.toList
    }
    val temp = new router
    temp.module_id = get_new_id
    temp.config_input_port = c.get("config_input_port").toString
    temp.config_output_port = c.get("config_output_port").toString
    temp.module_type = c.get("module_type").toString
    temp.input_ports = c.get("input_ports").asInstanceOf[util.ArrayList[String]]
    temp.output_ports = c.get("output_ports").asInstanceOf[util.ArrayList[String]]
    temp.decomposer = c.get("decomposer").asInstanceOf[Int]
    temp.inter_subnet_connection = asScalaBuffer(c.get("inter_subnet_connection").asInstanceOf[util.ArrayList[Any]]).toList
    temp
  }

  // ------ Dedicated PE ------
  implicit def convert2dedicatedpe_list(c:util.LinkedHashMap[String,Any]):Map[String,dedicated_pe]={
    val temp_map : Map[String,dedicated_pe] = Map[String,dedicated_pe]()
    for (entry <- c.entrySet()) {
      val key : String = entry.getKey
      val value : dedicated_pe = entry.getValue.asInstanceOf[util.LinkedHashMap[String,Any]]
      temp_map += key -> value
    }
    temp_map
  }
  implicit def convert2dedicatedpe(c:util.LinkedHashMap[String,Any]):dedicated_pe={
    implicit def convertBp (a:Any):backpressure={
      val y = a.asInstanceOf[util.LinkedHashMap[String,Any]]
      val temp = new backpressure
      temp.valid = y.get("valid").asInstanceOf[Boolean]
      temp.max_delay = y.get("max_delay").asInstanceOf[Int]
      temp
    }
    implicit  def convertMR (a:Any):metaReuse={
      val y = a.asInstanceOf[util.LinkedHashMap[String,Any]]
      val temp = new metaReuse
      temp.valid = y.get("valid").asInstanceOf[Boolean]
      temp.num_reuse = y.get("num_reuse").asInstanceOf[Int]
      temp
    }
    implicit def convertInst (a:Any): Map[String,List[String]] = {
      val temp : Map[String,List[String]] = Map[String,List[String]]()
      val y = a.asInstanceOf[util.LinkedHashMap[String,Any]]
      for (entry <- y.entrySet()) {
        val key : String = entry.getKey
        val value : List[String] = entry.getValue.asInstanceOf[util.ArrayList[String]]
        temp += key -> value
      }
      temp
    }
    val temp = new dedicated_pe
    temp.module_id = get_new_id
    temp.module_type = c.get("module_type").toString
    temp.config_input_port = c.get("config_input_port").toString
    temp.config_output_port = c.get("config_output_port").toString
    temp.input_ports = c.get("input_ports").asInstanceOf[util.ArrayList[String]]
    temp.output_ports = c.get("output_ports").asInstanceOf[util.ArrayList[String]]
    temp.decomposer = c.get("decomposer").asInstanceOf[Int]
    temp.has_backpressure = c.get("has_backpressure")
    temp.has_metaReuse = c.get("has_metaReuse")
    temp.instructions = c.get("instructions")
    temp
  }

  // ------ Shared PE ------
  implicit def convert2sharedpe_list(c:util.LinkedHashMap[String,Any]):Map[String,shared_pe]={
    val temp : Map[String,shared_pe] = Map[String,shared_pe]()
    for (entry <- c.entrySet()){
      val key: String = entry.getKey
      val value: shared_pe = entry.getValue.asInstanceOf[util.LinkedHashMap[String,Any]]
      temp += key -> value
    }
    temp
  }
  implicit def convert2sharedpe(c:util.LinkedHashMap[String,Any]):shared_pe={
    val temp = new shared_pe
    temp.module_type = c.get("module_type").toString
    temp.input_ports = c.get("input_ports").asInstanceOf[util.ArrayList[String]]
    temp.output_ports = c.get("output_ports").asInstanceOf[util.ArrayList[String]]
    temp.architecture = c.get("architecture").toString
    temp.immediate_width = c.get("immediate.width").asInstanceOf[Int]
    temp.mm_instruction_width = c.get("mm_instruction_width").asInstanceOf[Int]
    temp.num_instructions = c.get("num_instructions").asInstanceOf[Int]
    temp.num_predicates = c.get("num_predicates").asInstanceOf[Int]
    temp.num_registers = c.get("num_registers").asInstanceOf[Int]
    temp.has_multiplier = c.get("has_multiplier").asInstanceOf[Boolean]
    temp.has_two_word_product_multiplier = c.get("has_two_word_product_multiplier").asInstanceOf[Boolean]
    temp.has_scratchpad = c.get("has_scratchpad").asInstanceOf[Boolean]
    temp.num_scratchpad_words = c.get("num_scratchpad_words").asInstanceOf[Int]
    temp.latch_based_instruction_memory = c.get("latch_based_instruction_memory").asInstanceOf[Boolean]
    temp.ram_based_immediate_storage = c.get("ram_based_immediate_storage").asInstanceOf[Boolean]
    temp.channel_buffer_depth = c.get("channel_buffer_depth").asInstanceOf[Int]
    temp.max_num_input_channels_to_check = c.get("max_num_input_channels_to_check").asInstanceOf[Int]
    temp.num_tags = c.get("num_tags").asInstanceOf[Int]
    temp.has_speculative_predicate_unit = c.get("has_speculative_predicate_unit").asInstanceOf[Boolean]
    temp.has_effective_queue_status = c.get("has_effective_queue_status").asInstanceOf[Boolean]
    temp.has_debug_monitor = c.get("has_debug_monitor").asInstanceOf[Boolean]
    temp.has_performance_counters = c.get("has_performance_counters").asInstanceOf[Boolean]
    temp
  }
}
