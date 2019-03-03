package basic


import basic.Constant._
import scala.collection.mutable.Map
import scala.collection.mutable.ListBuffer
import scala.xml.{Attribute, Elem, Text,Null}

case class Port(io:String,hasValid:Boolean,hasReady:Boolean) extends Entity
  with IsPort{
  Parameters("IO Type") = io
  Parameters("hasValid") = hasValid
  Parameters("hasReady") = hasReady
  def forsyn : Unit = ???
}

trait Entity {

  var parent_type : String = ""
  var parent_id : Int = -1
  var entity_type : String = ""
  var entity_id : Int = -1

  // Ports are special entity, Physical
  val Ports : ListBuffer[Port] = new ListBuffer[Port]()

  // External Sources and Sinks, Virtual
  val Sources : ListBuffer[(Int,Int)] = new ListBuffer[(Int,Int)]()
  val Sinks : ListBuffer[(Int,Int)] = new ListBuffer[(Int,Int)]()

  // Reconfigurability
  val DSE_Options :Map[String,List[Int]] = Map[String,List[Int]]()
  //(Whether it is configured or not, bottom bound, upper bound)

  // Internal Relationship and Entities
  val Relationships : ListBuffer[(Int,Int)] = new ListBuffer[(Int,Int)]()
  val Entities : ListBuffer[Entity] = new ListBuffer[Entity]()

  // Internal Parameter
  val Parameters : Map[String,Any] = Map[String,Any]()

  // Add Internal Entity or Relationship
  def have(a:Entity):Unit = Entities += a
  def have(ab:(Entity,Entity)) = Relationships += ab._1.entity_id -> ab._2.entity_id
  def have(aabb:List[(Entity,Entity)]):Unit = aabb.foreach(have)
  def have(Key:String, Value:Any) :Unit = Parameters += Key -> Value
  def have(Key:String, Value:Int,lowerBound:Int,upperBound:Int,stride:Int):Unit={
    val options:List[Int] = (lowerBound to upperBound by stride).toList
    have(Key,Value,options)
  }
  def have(Key:String, Value:Int,options:List[Int]):Unit={
    have(Key,Value)
    DSE_Options += Key -> options
  }
  def have(p:Port):Unit = {
    Ports += p
  }
  def have(key:String):Boolean = Parameters.isDefinedAt(key)
  def get(key:String):Any = {
    if(Parameters.isDefinedAt(key))
      Parameters(key)
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

  // Convenience method
  // word width pass down
  def passdown_word_width:Unit={
    if(Entities nonEmpty)
      Entities.foreach(x=>{
        x.have("Word_Width",get("Word_Width"))
        x.passdown_word_width
      })
    if(Ports nonEmpty)
      Ports.foreach(x=>{x.have("Word_Width",get("Word_Width"));x.passdown_word_width})
  }
  // assign port index
  def assign_index :Unit = {
    val p = Ports
    for(index<- 0 until p.length){
      p(index).have("Index",index)
    }
  }

  // Serialize to String
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
    }else{
        <Parent/>
    }}
      {if(entity_type != "" || entity_id != -1){
      <Current>
        <Type>{entity_type}</Type><ID>{entity_id}</ID>
      </Current>
    }else{
        <Current/>
    }}
      {if(Parameters nonEmpty){
      <Parameters>{Parameters.map(x=>{
        <KeyValue>
          {
            if(DSE_Options.isDefinedAt(x._1)){
              <PKey DSE="true">{x._1}</PKey>
              <PValue type={x._2.getClass.getName}>{x._2}</PValue>
              <POptions>{DSE_Options(x._1)}</POptions>
            }else{
              <PKey DSE="false">{x._1}</PKey>
              <PValue type={x._2.getClass.getName}>{x._2}</PValue>
            }
          }
        </KeyValue>
      })}</Parameters>
    }else{
      <Parameter/>
    }}
      {if(Sources nonEmpty){
      <Sources>{Sources.map(s=>{
        <SPPair><ID>{s._1}</ID><Port>{s._2}</Port></SPPair>
      })}</Sources>
    }else{
      <Sources/>
    }}
      {if(Sinks nonEmpty){
      <Sinks>{Sinks.map(s=>{
        <SPPair><ID>{s._1}</ID><Port>{s._2}</Port></SPPair>
      })}</Sinks>
    }else{
      <Sinks/>
    }}
      {if(Ports nonEmpty){<Ports>{Ports.map(i=>i.toXML)}</Ports>}else{<Ports/>}}
      {if(Relationships nonEmpty){
      <Relationships>{Relationships.map(r=>{<link><Source>{r._1}</Source><Sink>{r._2}</Sink></link>})}</Relationships>
    }else{<Relationships/>}}
      {if(Entities.nonEmpty){
      <InternalEntities>{Entities.map(e=>{e.toXML})}</InternalEntities>}else{<InternalEntities/>}}
    </Entity>
  }
}

