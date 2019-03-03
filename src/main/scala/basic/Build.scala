package basic

import chisel3.experimental.RawModule
import scala.collection.mutable.{ListBuffer, Map}
import scala.xml.NodeSeq

class Build extends App{

  def instantiate(p:Entity): Unit = {
    chisel3.Driver.execute(args,()=>
      Class.forName(p.entity_type+"_Hw")
        .getConstructor(classOf[Entity])
        .newInstance(p).asInstanceOf[RawModule])
  }

  def loadXMLFile(fileName:String):NodeSeq={
    scala.xml.XML.loadFile(fileName)
  }
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
      if(parameters.text != "")
        get_Parameters_fromXML(parameters).foreach(Parameters += _)
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
      copyInternalEntity(temp_port,pe)
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
  def copyInternalEntity(t:Entity,s:Entity):Unit={
    t.parent_type = s.parent_type
    t.parent_id = s.parent_id
    t.entity_type = s.entity_type
    t.entity_id = s.entity_id
    t.Ports --= t.Ports;s.Ports.foreach(t.Ports+=_)
    t.Sources --= t.Sources;s.Sources.foreach(t.Sources += _)
    t.Sinks --= t.Sinks;s.Sinks.foreach(t.Sinks += _)
    t.Relationships --= t.Relationships;s.Relationships.foreach(t.Relationships += _)
    t.Entities --= t.Entities;s.Entities.foreach(t.Entities += _)
    s.Parameters.foreach(t.Parameters += _)
  }

}
