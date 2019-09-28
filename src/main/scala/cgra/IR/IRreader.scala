package cgra.IR

import IRconvertor._
import cgra.IR.IRpreprocessor._
import dsl.{IRPrintable, identifier, ssnode}
import java.io.{File, FileInputStream}
import java.util

import org.yaml.snakeyaml.Yaml
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.dataformat.yaml.YAMLFactory

import scala.collection.JavaConverters._
import scala.collection.mutable.{ListBuffer, Map, Set}
import scala.util.parsing.json.JSONObject
import scala.collection.JavaConversions._
import scala.collection.JavaConverters.{asScalaBuffer, mapAsScalaMap}
import scala.collection.mutable

object IRreader {
  def readIR(filename:String) = {
    val input = new FileInputStream(new File(filename))
    val yaml = new Yaml()
    val j_cgra = yaml.load(input).asInstanceOf[util.Map[String,Any]]
    val s_cgra = JavaMap2ScalaMap(j_cgra)
    s_cgra += "description_filename" -> filename
    s_cgra += "config_filename" -> filename.replace("yaml","xml")

    //preprocess(s_cgra)
    s_cgra
  }
}

object IRconvertor {
  // ------ Common ------
  implicit def JavaMap2ScalaMap(javaMap:util.Map[String,Any]):mutable.Map[String,Any]={
    val scalaMap = mapAsScalaMap(javaMap)
    for(kv <- scalaMap){
      val (key,value) = kv
      println("key = " + key + ", value = " + value)
      scalaMap(key) = toScala(value)
    }
    scalaMap
  }
  implicit def JavaListString2ScalaListString(a:util.ArrayList[String]):List[String]={
    asScalaBuffer(a).toList
  }

  // Object Convertion
  def convertYamlToJson(yaml: String): String = {
    val yamlReader = new ObjectMapper(new YAMLFactory())
    val obj = yamlReader.readValue(yaml, classOf[Any])
    val jsonWriter:ObjectMapper = new ObjectMapper()
    jsonWriter.writerWithDefaultPrettyPrinter().writeValueAsString(obj)
  }
  def convertJsonToYaml(json: String):String={
    val jsonReader = new ObjectMapper()
    val obj = jsonReader.readValue(json, classOf[Any])
    val yamlWriter = new ObjectMapper(new YAMLFactory())
    yamlWriter.writerWithDefaultPrettyPrinter().writeValueAsString(obj)
  }
  /*
  def toJSON(tree:Any):Any={
    tree match {
      case imSet:collection.immutable.Set[_] => toJSON(imSet.toList)
      case set:Set[_]=> toJSON(set.toList)
      case map:Map[String, Any] =>
        for (kv <- map) map(kv._1) = toJSON(kv._2)
        JSONObject(map.toMap)
      case seq:Seq[_] => seq.map(toJSON)
      case yaml:IRPrintable => toJSON(yaml.getProps)
      case _ => tree
    }
  }
   */
  def toJava(scala:Any):Any={
    scala match {
      case imSet:collection.immutable.Set[_] => toJava(imSet.toSeq)
      case set:Set[_]=> toJava(set.toSeq)
      case imMap:collection.immutable.Map[_,_] =>
        toJava(Map(imMap.toSeq: _*) )
      case map:Map[_, Any] =>
        for (kv <- map) {
          map(kv._1) = toJava(kv._2)
        }
        map.toMap.asJava
      case seq:Seq[_] => seq.map(toJava).asJava
      case yaml:IRPrintable => toJava(yaml.getProps)
      case id:identifier =>
        toJava(id.id)
      case None => "N/A"
      case tuple:(_, _) => toJava(List(tuple._1, tuple._2))
      case listBuffer:ListBuffer[_] => toJava(listBuffer.toList)
      case _ => scala
    }
  }

  def toScala(java:Any):Any={
    java match{
      case i:Int => i
      case d:Double =>  d
      case b:Boolean => b
      case s:String => s
      case ll:List[_] => ll
      case l:util.ArrayList[_] => {
        asScalaBuffer(l.map(p => toScala(p))).toList
      }
      case jMap:util.Map[String,Any] => JavaMap2ScalaMap(jMap)
    }
  }
}

