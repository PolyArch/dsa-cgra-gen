package dsl

import java.io.{File, PrintWriter}
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

import cgra.IO.ReqAckConf_if
import org.yaml.snakeyaml.Yaml

import scala.collection.mutable.Map
import scala.collection.mutable.Set
import cgra.IR.IRconvertor._
import chisel3.{Bundle, Vec}

import scala.collection.mutable

// Singleton identifier
object identifier {
  var keys : mutable.Set[String] = mutable.Set("id", "nodeType")
  def apply(add_keys:String*) = {
    for(k <- add_keys){
      keys += k
    }
    this
  }
  def delete(del_keys:String*) = {
    for(k <- del_keys){
      if(k != "id" && k!="nodeType"){
        keys -= k
      }
    }
    this
  }
}

// Identifier Class
class identifier(original_value:Any){
  var id : Any = original_value
}

trait IRPrintable {
  // Variable
  private val properties : Map[String,Any] = Map[String,Any]()
  private val yaml = new Yaml()

  // Member
  def postprocess():Unit
  implicit def value2string(value:Any):String = {
    value match {
      case id:identifier => id.id.toString
      case _ => value.toString
    }
  }

  // Get
  def getProps = properties
  def getAllKeys = {
    properties.keys
  }
  def getPropByKey(key:String):Any = {
    if(properties.isDefinedAt(key)){
      properties(key)
    }else{
      None
    }
  }
  def getPropByKeys(keys:Seq[String]):Seq[Any]={
    for (key <- keys) yield
        getPropByKey(key)
  }
  // Pick the real value of Properties (extract out the identifier)
  def getValue(value:Any):Any={
    value match {
      case id:identifier => id.id
      case x => x
    }
  }

  // Set
  def apply(props:collection.mutable.Map[String,Any]):IRPrintable={
    for (kv <- props){
      apply(kv._1,kv._2)
    }
    this
  }
  def apply(key:String, value:Any):IRPrintable={
    if(identifier.keys.contains(key)){
      if (!properties.isDefinedAt(key)) {
        // Initial
        val init_id = new identifier(value)
        properties += key -> init_id
        this
      } else {
        // Update old data
        val old_id = properties(key).asInstanceOf[identifier]
        old_id.id = value
        this
      }
    }else{
      properties(key) = value
      this
    }
  }
  def addProp(key:String, value:Any):IRPrintable={
    apply(key,value)
  }

  // Delete
  def deletePropByKey(key:String*):Unit={
    properties -= key
  }

  // Print
  // toString
  override def toString: String = {
    toString("json")
  }
  def toString(format:String):String = {
    val yamlString = yaml.dump(toJava(properties))
    format match {
      case "json" => convertYamlToJson(yamlString)
      case "yaml" => yamlString
    }
  }
  // to File
  def printfile() : Unit =
    printfile("IR/" + getPropByKey("name").toString)
  def printfile(filename:String):Unit=
    printfile(filename,"json","yaml")
  def printfile(filename:String,formats:String*):Unit={
    postprocess()
    // Create File Name
    // Timestamp
    val tp : String = DateTimeFormatter.ofPattern("_yyMMdd_HHmmss")
      .format(LocalDateTime.now)
    // Print to File
    for (format <- formats){
      val tempFileName : String = filename + "." + format
      val tempFile = new File(tempFileName)
      val pw = new PrintWriter(tempFile)
      if(format == "yaml")
        println(this.toString(format))
      pw.write(this.toString(format))
      pw.close()
    }
  }
}