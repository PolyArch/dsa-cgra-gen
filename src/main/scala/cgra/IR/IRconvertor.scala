package cgra.IR

import java.util

import chisel3.util.log2Ceil

import scala.beans.BeanProperty
import scala.collection.mutable._
import scala.collection.JavaConversions._
import cgra.config.encoding.update_encoding

import scala.collection.JavaConverters.{asScalaBuffer, mapAsScalaMap}
import scala.collection.mutable

object global_var {
   var module_id = -1
   var module_id_width : Int = -1
   var module_id_list : ListBuffer[Int] = new ListBuffer[Int]()
  def get_new_id = {
    module_id += 1
    module_id_list += module_id
    module_id_width = log2Ceil(module_id_list.length)
    update_encoding
    module_id
  }
}

import global_var.get_new_id

object IRconvertor {
  // ------ Common ------
  implicit def JavaMap2ScalaMap(javaMap:util.Map[String,Any]):mutable.Map[String,Any]={
    val scalaMap = mapAsScalaMap(javaMap)
    for(kv <- scalaMap){
      val (key,value) = kv
      scalaMap(key) = value match {
        case i:Int => i
        case d:Double =>  d
        case b:Boolean => b
        case s:String => s
        case ll:List[_] => ll
        case l:util.ArrayList[_] => {
          asScalaBuffer(l.map(p => p match {
            case p:util.Map[String,Any] => JavaMap2ScalaMap(p)
            case _ => p
          })).toList
        }
        case jMap:util.Map[String,Any] => JavaMap2ScalaMap(jMap)
      }
    }
    scalaMap
  }
  implicit def JavaListString2ScalaListString(a:util.ArrayList[String]):List[String]={
    asScalaBuffer(a).toList
  }

  // ------ System ------
  implicit def convert2system(c:Map[String,Any]):system={
    val temp = new system
    temp.module_type = c("module_type").toString
    temp.data_word_width = c("data_word_width").asInstanceOf[Int]
    temp.host_word_width = c("host_word_width").asInstanceOf[Int]
    temp.num_test_data_memory_words = c("num_test_data_memory_words").asInstanceOf[Int]
    temp.test_data_memory_buffer_depth = c("test_data_memory_buffer_depth").asInstanceOf[Int]
    temp.input_ports = c("input_ports").asInstanceOf[List[String]]
    temp.output_ports = c("output_ports").asInstanceOf[List[String]]
    temp
  }

  // ------ Topology ------
  implicit def convert2connection_list(lc:List[mutable.Map[String,Any]]):List[connection]={
    lc map (ll => convert2connection(ll))
  }
  implicit def convert2connection(c:mutable.Map[String,Any]):connection={
    val temp_connection = new connection
    val temp_source = c("source").asInstanceOf[Map[String,Any]]
    val temp_sink = c("sink").asInstanceOf[Map[String,Any]]
    temp_connection.source.module = temp_source("module").toString
    temp_connection.source.port = temp_source("port").toString
    temp_connection.sink.module = temp_sink("module").toString
    temp_connection.sink.port = temp_sink("port").toString
    temp_connection
  }

  // ------ To List Wrapper ------
  implicit def convert2list_v(mv:Map[String,Any]):Map[String,vector_port]=
    mv.map(m=>{val v :(String,vector_port) = m;v})

  implicit def convert2list_r(mv:Map[String,Any]):Map[String,router]=
    mv.map(m=>{val v :(String,router) = m;v})

  implicit def convert2list_d(mv:Map[String,Any]):Map[String,dedicated_pe]=
    mv.map(m=>{val v :(String,dedicated_pe) = m;v})

  implicit def convert2list_s(mv:Map[String,Any]):Map[String,shared_pe]=
    mv.map(m=>{val v :(String,shared_pe) = m;v})

  // ------ Vector Port ------
  implicit def convert2vectorport(v:(String,Any)):(String,vector_port)={
    val name = v._1
    val c = v._2.asInstanceOf[mutable.Map[String,Any]]
    val temp = new vector_port
    temp.module_type = c("module_type").toString
    temp.channel_buffer = c("channel_buffer").asInstanceOf[Int]
    temp.io_type = c("io_type").toString
    temp.input_ports = c("input_ports").asInstanceOf[List[String]]
    temp.output_ports = c("output_ports").asInstanceOf[List[String]]
    (name,temp)
  }

  // ------ Router ------
  implicit def convert2router(kv:(String,Any)):(String,router)={
    val name = kv._1;val c = kv._2.asInstanceOf[mutable.Map[String,Any]]
    implicit def convert2inter_subnet_connection(c:Any):subnet_connection ={
      val cc = c.asInstanceOf[Map[String,Any]]
      val temp : subnet_connection = new subnet_connection
      val temp_source = cc("source").asInstanceOf[Map[String,Any]]
      val temp_sink = cc("sink").asInstanceOf[Map[String,Any]]
      temp.source.port = temp_source("port").toString
      temp.source.subnet = temp_source("subnet").asInstanceOf[Int]
      temp.sink.port = temp_sink("port").toString
      temp.sink.subnet = temp_sink("subnet").asInstanceOf[Int]
      temp
    }
    val temp = new router
    temp.module_id = get_new_id
    temp.config_input_port = c("config_input_port").toString
    temp.config_output_port = c("config_output_port").toString
    temp.module_type = c("module_type").toString
    temp.input_ports = c("input_ports").asInstanceOf[List[String]]
    temp.output_ports = c("output_ports").asInstanceOf[List[String]]
    temp.decomposer = c("decomposer").asInstanceOf[Int]
    temp.inter_subnet_connection = c("inter_subnet_connection").asInstanceOf[List[Any]].map(p=>convert2inter_subnet_connection(p))
    (name,temp)
  }

  // ------ Dedicated PE ------
  implicit def convert2dedicatedpe(kv:(String,Any)):(String,dedicated_pe)={
    val name = kv._1
    val c = kv._2.asInstanceOf[Map[String,Any]]
    implicit def convertBp (a:Any):backpressure={
      val y = a.asInstanceOf[Map[String,Any]]
      val temp = new backpressure
      temp.valid = y("valid").asInstanceOf[Boolean]
      temp.max_delay = y("max_delay").asInstanceOf[Int]
      temp
    }
    implicit  def convertMR (a:Any):metaReuse={
      val y = a.asInstanceOf[Map[String,Any]]
      val temp = new metaReuse
      temp.valid = y("valid").asInstanceOf[Boolean]
      temp.num_reuse = y("num_reuse").asInstanceOf[Int]
      temp
    }
    implicit def convertInst (a:Any): Map[String,List[String]] = {
      val temp : Map[String,List[String]] = Map[String,List[String]]()
      val y = a.asInstanceOf[Map[String,Any]]
      for (entry <- y.entrySet()) {
        val key : String = entry.getKey
        val value : List[String] = entry.getValue.asInstanceOf[List[String]]
        temp += key -> value
      }
      temp
    }
    val temp = new dedicated_pe
    temp.module_id = get_new_id
    temp.module_type = c("module_type").toString
    temp.config_input_port = c("config_input_port").toString
    temp.config_output_port = c("config_output_port").toString
    temp.input_ports = c("input_ports").asInstanceOf[List[String]]
    temp.output_ports = c("output_ports").asInstanceOf[List[String]]
    temp.decomposer = c("decomposer").asInstanceOf[Int]
    temp.has_backpressure = c("has_backpressure")
    temp.has_metaReuse = c("has_metaReuse")
    temp.instructions = c("instructions")
    (name,temp)
  }

  // ------ Shared PE ------
  implicit def convert2sharedpe(kv:(String,Any)):(String,shared_pe)={
    val name = kv._1;val c = kv._2.asInstanceOf[Map[String,Any]]
    val temp = new shared_pe
    temp.module_id = get_new_id
    temp.module_type = c("module_type").toString
    temp.input_ports = c("input_ports").asInstanceOf[List[String]]
    temp.output_ports = c("output_ports").asInstanceOf[List[String]]
    temp.architecture = c("architecture").toString
    temp.immediate_width = c("immediate_width").asInstanceOf[Int]
    temp.mm_instruction_width = c("mm_instruction_width").asInstanceOf[Int]
    temp.num_instructions = c("num_instructions").asInstanceOf[Int]
    temp.num_predicates = c("num_predicates").asInstanceOf[Int]
    temp.num_registers = c("num_registers").asInstanceOf[Int]
    temp.has_multiplier = c("has_multiplier").asInstanceOf[Boolean]
    temp.has_two_word_product_multiplier = c("has_two_word_product_multiplier").asInstanceOf[Boolean]
    temp.has_scratchpad = c("has_scratchpad").asInstanceOf[Boolean]
    temp.num_scratchpad_words = c("num_scratchpad_words").asInstanceOf[Int]
    temp.latch_based_instruction_memory = c("latch_based_instruction_memory").asInstanceOf[Boolean]
    temp.ram_based_immediate_storage = c("ram_based_immediate_storage").asInstanceOf[Boolean]
    temp.channel_buffer_depth = c("channel_buffer_depth").asInstanceOf[Int]
    temp.max_num_input_channels_to_check = c("max_num_input_channels_to_check").asInstanceOf[Int]
    temp.num_tags = c("num_tags").asInstanceOf[Int]
    temp.has_speculative_predicate_unit = c("has_speculative_predicate_unit").asInstanceOf[Boolean]
    temp.has_effective_queue_status = c("has_effective_queue_status").asInstanceOf[Boolean]
    temp.has_debug_monitor = c("has_debug_monitor").asInstanceOf[Boolean]
    temp.has_performance_counters = c("has_performance_counters").asInstanceOf[Boolean]
    (name,temp)
  }
}
