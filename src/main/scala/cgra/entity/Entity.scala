package cgra.entity

import cgra.config.Constant._
import scala.collection.mutable.Map
import scala.collection.mutable.ListBuffer
import scala.xml.{Attribute, Elem, Text,Null}

case class Port(io:String,hasValid:Boolean,hasReady:Boolean) extends Entity
  with IsPort{
  Parameters("IO_Type").value = io
  Parameters("hasValid").value = hasValid
  Parameters("hasReady").value = hasReady
  entity_type = this.getClass.getName
  def * (multi:Int) :ListBuffer[Port]={
    val temp : ListBuffer[Port] = new ListBuffer[Port]()
    for (i <- 0 until multi){
      temp += Port(this.io,this.hasValid,this.hasReady)
    }
    temp
  }
  def forsyn : Unit = ???
}

case class PValue(v:Any) {
  var value : Any = v
}

object Entity {
  private var counter = -1
  def getNumOfInstances: Int = {counter+=1;counter}
}

trait Entity extends EntityUtil{
  var parent_type = ""
  var parent_id : Int = -1
  var entity_type = ""
  var entity_id : Int = Entity.getNumOfInstances

  // Ports are special entity, Physical
  var port_index = 0
  val Ports = new ListBuffer[Port]()

  // External Sources and Sinks, Virtual map to Physical Port Index
  val Sources : Map[Int,Int] = Map[Int,Int]()
  val Sinks : Map[Int,Int] = Map[Int,Int]()

  // Reconfigurability
  val DSE_Options :Map[String,List[Int]] = Map[String,List[Int]]()
  //(Whether it is configured or not, bottom bound, upper bound)

  // Internal Relationship and Entities
  val Relationships = new ListBuffer[(Int,Int)]()
  val Entities = new ListBuffer[Entity]()

  // Internal Parameter
  val Parameters : Map[String,PValue] = Map[String,PValue]()

  // Add Internal Entity or Relationship
  def have(a:Entity,as:Entity*):Unit = {
    if(!a.have("Word_Width"))
      a.have("Word_Width",get("Word_Width"))
    a.parent_id = entity_id
    a.parent_type = entity_type
    Entities += a
    as.foreach(a=>{
      if(!a.have("Word_Width"))
        a.have("Word_Width",get("Word_Width"))
      a.parent_id = entity_id
      a.parent_type = entity_type
      Entities += a
    })
  }
  def have(ab:(Entity,Entity),aibi:(Int,Int)) ={
    Relationships += ab._1.entity_id -> ab._2.entity_id
    ab._2.Sources(ab._1.entity_id) = aibi._1
    ab._1.Sinks(ab._2.entity_id) = aibi._2
  }
  def have(aabb:List[(Entity,Entity)],aabbii:List[(Int,Int)]):Unit =
    aabb.zipWithIndex.foreach(x=>have(x._1,aabbii(x._2)))
  def have(Key:String, Value:Any) :Unit = {
    if(!Parameters.isDefinedAt(Key)){
      Parameters += Key -> PValue(Value)
      Parameters(Key).value = Value
    }
    else
      Parameters(Key).value = Value
  }
  def have(Key:String, DefaultValue:Int, lowerBound:Int, upperBound:Int, stride:Int):Unit={
    val options = (lowerBound to upperBound by stride).toList
    have(Key,DefaultValue,options)
  }
  def have(Key:String, Value:Int,options:List[Int]):Unit={
    have(Key,Value)
    DSE_Options += Key -> options
  }

  val a = Array()
  def have(p:Port,ps:Port*):Unit = {
    if(!p.have("Word_Width"))
      p.have("Word_Width",get("Word_Width"))
    p.parent_type = entity_type
    p.parent_id = entity_id
    Ports += p
    ps.foreach(p=>{
      if(!p.have("Word_Width"))
        p.have("Word_Width",get("Word_Width"))
      p.parent_type = entity_type
      p.parent_id = entity_id
      Ports += p
    })
  }
  def have(p:ListBuffer[Port]):Unit={
    p.foreach(x=>have(x))
  }
  def have(key:String):Boolean = Parameters.isDefinedAt(key)
  def get(key:String):Any = {
    if(Parameters.isDefinedAt(key))
      Parameters(key).value
    else
      None
  }

  // External Relationship
  def -->(a:Entity)= {
    this.Sinks += a.entity_id -> -1
    a.Sources += this.entity_id -> -1
    this -> a
  }
  def <--(a:Entity)= a --> this
  def <->(a:Entity) = List(a-->this,a<--this)

  // Get Internal Entity or Relationship
  def find_source(sink:Int):List[Int]={
    Relationships.filter(x=>x._2 == sink).map(x=>x._1).toList
  }
  def find_sink(source:Int):List[Int]={
    Relationships.filter(x=>x._1 == source).map(x=>x._2).toList
  }

  //Dulplicate
  def copyInternalEntity(s:Entity):Unit={
    s.Ports.foreach(this.Ports+=_)
    s.Sources.foreach(this.Sources += _)
    s.Sinks.foreach(this.Sinks += _)
    s.Relationships.foreach(this.Relationships += _)
    s.Entities.foreach(this.Entities += _)
    s.Parameters.foreach(this.Parameters += _)
    /*
    t.parent_type = s.parent_type
    t.parent_id = s.parent_id
    t.entity_type = s.entity_type
    t.entity_id = s.entity_id
    t.Ports --= t.Ports
    t.Sources --= t.Sources
    t.Sinks --= t.Sinks
    t.Relationships --= t.Relationships
    t.Entities --= t.Entities
    */
  }

  // Ready for Synthesis
  def forsyn: Unit

  // ------ Convenience method with Side effect------
  // Assign parent type and id offspring
  /*
  def assign_parent : Unit ={
    Ports.foreach(p=>{p.parent_id = entity_id;p assign_parent;p.parent_type = entity_type})
    Entities.foreach(e=>{e.parent_id = entity_id;e.parent_type = entity_type;e.assign_parent})
  }
  */
  // Check connection between port have same word width
  def check_port_connection : Unit = {
    Relationships.foreach(r=>{
      val source_id = r._1
      val sink_id = r._2
      val all_ports = Ports.toList ::: Entities.flatMap(e=>e.Ports).toList
      val source_port = all_ports.find(_.entity_id == source_id).get
      val sink_port = all_ports.find(_.entity_id == sink_id).get
      require(source_port.get("Word_Width").asInstanceOf[Int] == sink_port.get("Word_Width").asInstanceOf[Int])
    })
  }


  // Serialize to String --- Seams useless
  import java.io.ByteArrayOutputStream
  import java.io.IOException
  import java.io.ObjectOutputStream
  import java.util.Base64
  @throws[IOException]
  private def serialize(o: Any) = {
    val baos = new ByteArrayOutputStream
    val oos = new ObjectOutputStream(baos)
    oos.writeObject(o)
    oos.close()
    Base64.getEncoder.encodeToString(baos.toByteArray)
  }

  // IR Output
  def toXML : Elem = {
    <Entity>
      {if(parent_type != "" || parent_id != -1){
      <Parent>
        <Type>{parent_type}</Type><ID>{parent_id}</ID>
      </Parent>
    }}
      {if(entity_type != "" || entity_id != -1){
      <Current>
        <Type>{entity_type}</Type><ID>{entity_id}</ID>
      </Current>
    }}
      {if(Parameters nonEmpty){
      <Parameters>{Parameters.map(x=>{
        <KeyValue>
          {
            if(DSE_Options.isDefinedAt(x._1)){
              <PKey DSE="true">{x._1}</PKey>
              <PValue type={x._2.getClass.getName}>{x._2.value}</PValue>
              <POptions>{DSE_Options(x._1)}</POptions>
            }else{
              <PKey DSE="false">{x._1}</PKey>
              <PValue type={x._2.value.getClass.getName}>{x._2.value}</PValue>
            }
          }
        </KeyValue>
      })}</Parameters>
    }}
      {if(Sources nonEmpty){
      <Sources>{Sources.map(s=>{
        <SPPair><ID>{s._1}</ID><Port>{s._2}</Port></SPPair>
      })}</Sources>
    }}
      {if(Sinks nonEmpty){
      <Sinks>{Sinks.map(s=>{
        <SPPair><ID>{s._1}</ID><Port>{s._2}</Port></SPPair>
      })}</Sinks>
    }}
      {if(Ports nonEmpty){<Ports>{Ports.map(i=>i.toXML)}</Ports>}}
      {if(Relationships nonEmpty){
      <Relationships>{Relationships.map(r=>{<link><Source>{r._1}</Source><Sink>{r._2}</Sink></link>})}</Relationships>
    }}
      {if(Entities.nonEmpty){
      <InternalEntities>{Entities.map(e=>{e.toXML})}</InternalEntities>}}
    </Entity>
  }
}

