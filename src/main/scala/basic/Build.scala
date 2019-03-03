package basic

import chisel3.experimental.RawModule
import scala.collection.mutable.{ListBuffer, Map}
import scala.xml.NodeSeq

class Build extends App{
  // Chisel Driver and Verilog Output
  def instantiate(p:Entity): Unit = {
    chisel3.Driver.execute(args,()=>
      Class.forName(p.entity_type+"_Hw")
        .getConstructor(classOf[Entity])
        .newInstance(p).asInstanceOf[RawModule])
  }

  // Save Entity to XML File
  def saveXMLFile(x:Entity,fileName:String):Unit = {
    scala.xml.XML.save(fileName,x toXML,"UTF-8",false,null)
  }

  // Load XML File
  def loadXMLFile(fileName:String):NodeSeq={
    scala.xml.XML.loadFile(fileName)
  }

  // Normalize the XML File to Entity
  def load_Entity_fromXML(xmlNode:NodeSeq):Entity = {

    val Parent = (xmlNode \ "Parent")
    val Current = (xmlNode \ "Current")
    val sources = xmlNode \ "Sources"
    val sinks = xmlNode \ "Sinks"
    val ports = xmlNode \ "Ports"
    val parameters = xmlNode \ "Parameters"
    val relationships = xmlNode \ "Relationships"
    val internalentities = xmlNode \ "InternalEntities"

    val loadEntity = new Entity {
      if(Parent.text != ""){
        parent_type = (Parent \ "Type").text
        parent_id = (Parent \ "ID").text.toInt
      }
      if(Current.text != ""){
        entity_type = (Current \ "Type").text
        entity_id = (Current \ "ID").text.toInt
      }
      if(parameters.text != ""){
        get_Parameters_fromXML(parameters).foreach(Parameters += _)
        get_DSE_Options_fromXML(parameters).foreach(DSE_Options += _)
      }
      if(sources.text != "")
        SourceSinkPortMap(sources).foreach(Sources += _)
      if(sinks.text != "")
        SourceSinkPortMap(sinks).foreach(Sinks += _)
      if(relationships.text != "")
        get_Relationship_fromXML(relationships).foreach(Relationships += _)
      if(ports.text != "")
        get_Port_fromXML(ports).foreach(Ports += _)
      if(internalentities.text != "")
        internalentities.map(load_Entity_fromXML(_)).foreach(Entities += _)
      override def forsyn: Unit = ???
    }
    loadEntity
  }
  def get_Port_fromXML(node:NodeSeq) : ListBuffer[Port] = {
    val port_entity_list = (node \ "Entity").map(load_Entity_fromXML(_))
    val temp_ports : ListBuffer[Port] = new ListBuffer[Port]()
    for (pe <- port_entity_list){
      val iotype = pe.get("IO Type").toString
      val hasValid = pe.get("hasValid").toString.toBoolean
      val hasReady = pe.get("hasReady").toString.toBoolean
      val temp_port = Port(iotype,hasValid,hasReady)
      temp_port.copyInternalEntity(pe)
      temp_ports += temp_port
    }
    temp_ports
  }
  def get_Parameters_fromXML(node:NodeSeq):Map[String,Any] = {
    var Parameters : Map[String,Any] = Map[String,Any]()
    val kv_list = node \ "KeyValue"
    for (kv <- kv_list){
      val key = (kv \ "PKey").text
      val value : Any = PValueNormalized((kv \ "PValue").text)
      Parameters += key -> value
    }
    Parameters
  }
  def get_DSE_Options_fromXML(node:NodeSeq):Map[String,List[Int]] = {
    var DSE_Options : Map[String,List[Int]] = Map[String,List[Int]]()
    val kv_list = node \ "KeyValue"
    for (kv <- kv_list){
      val isDSE = ((kv \ "PKey") \"@DSE").text.toBoolean
      if (isDSE){
        val k = (kv \ "PKey").text
        val value : List[Int] = PValueNormalized((kv \ "POptions").text).asInstanceOf[List[Int]]
        DSE_Options += k -> value
      }
    }
    DSE_Options
  }
  def PValueNormalized (value:String) :Any ={
    // Determine Type
    def isInt(value:String):Boolean = {
      try{
        value.toInt
        true
      }catch{
        case _ => false
      }
    }
    def isIntList(value:String):Boolean = value.split(" ").forall(isInt(_))
    def isBoolean(value:String):Boolean = {
      value match {
        case "true" => true
        case "false" => true
        case _ => false
      }
    }
    def isMap(value:String):Boolean = {
      value.split(" ").forall(x=>x.startsWith("(")&&x.endsWith(")"))
    }

    // Conevert
    def toIntList(v:String):List[Int]=value.split(" ").map(_.toInt).toList
    def toMap(value:String):Map[Any,Any]={
      val pairs = value.split(" ")
      val temp: Map[Any,Any] = Map[Any,Any]()
      for (pair <- pairs){
        val pp = pair.substring(1,pair.length-1).split(",")
        require(pp.length == 2)
        val p1 = PValueNormalized(pp(0))
        val p2 = PValueNormalized(pp(1))
        temp += p1 -> p2
      }
      temp
    }

    // Deserialize
    //val test = deserialize(value)
    //test

    // If-Else Condition
    if(isInt(value)){
      value.toInt
    }else if(isIntList(value)){
      toIntList(value)
    }else if(isBoolean(value)){
      value.toBoolean
    }else if(isMap(value)){
      toMap(value)
    }else{
      value
    }

  }
  def SourceSinkPortMap(node:NodeSeq):ListBuffer[(Int,Int)]={
    val sp_pairs = node \ "SPPair"
    val temp_pair : ListBuffer[(Int,Int)] = new ListBuffer[(Int,Int)]()
    for (sp <- sp_pairs){
      val s = (sp \ "ID").text.toInt
      val p = (sp \ "Port").text.toInt
      temp_pair += s -> p
    }
    temp_pair
  }
  def get_Relationship_fromXML(node:NodeSeq):ListBuffer[(Int,Int)]={
    val links = node \ "link"
    val temp_links : ListBuffer[(Int,Int)] = new ListBuffer[(Int,Int)]()
    for (l <- links){
      temp_links += (l \ "Source").text.toInt -> (l \ "Sink").text.toInt
    }
    temp_links
  }

  // Deserialize to Object
  import java.io.ByteArrayInputStream
  import java.io.IOException
  import java.io.ObjectInputStream
  import java.util.Base64
  @throws[IOException]
  @throws[ClassNotFoundException]
  private def deserialize(s: String) = {
    val data = Base64.getDecoder.decode(s)
    val ois = new ObjectInputStream(new ByteArrayInputStream(data))
    val o = ois.readObject
    ois.close()
    o
  }
}
