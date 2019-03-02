package basic


import basic.Constant._
import scala.collection.mutable.Map
import scala.collection.mutable.ListBuffer
import scala.xml.Elem

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
  var ports : ListBuffer[Port] = new ListBuffer[Port]()

  // External Sources and Sinks, Virtual
  var sources : ListBuffer[Entity] = new ListBuffer[Entity]()
  var sinks : ListBuffer[Entity] = new ListBuffer[Entity]()

  // Virtual <-> Physical


  // Internal Relationship and Entities
  val Relationships : ListBuffer[(Entity,Entity)] = new ListBuffer[(Entity,Entity)]()
  val Entities : ListBuffer[Entity] = new ListBuffer[Entity]()

  // Internal Parameter
  val Parameters : Map[String,Any] = Map[String,Any]()

  // Add Internal Entity or Relationship
  def have(a:Entity):Unit = Entities += a
  def have(ab:(Entity,Entity)) = Relationships += ab
  def have(aabb:List[(Entity,Entity)]):Unit = aabb.foreach(have)
  def have(Key:String, Value:Any) :Unit = Parameters += Key -> Value
  def have(p:Port):Unit = {
    ports += p
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
    this.sinks += a
    a.sources += this
    this -> a
  }
  def <--(a:Entity)= a --> this
  def <->(a:Entity) = List(a-->this,a<--this)

  // Get Internal Entity or Relationship
  def find_source(sink:Entity):List[Entity]={
    Relationships.filter(x=>x._2 == sink).map(x=>x._1).toList
  }
  def find_sink(source:Entity):List[Entity]={
    Relationships.filter(x=>x._1 == source).map(x=>x._2).toList
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
    if(ports nonEmpty)
      ports.foreach(x=>{x.have("Word_Width",get("Word_Width"));x.passdown_word_width})
  }
  // assign port index
  def assign_index :Unit = {
    val p = ports
    for(index<- 0 until p.length){
      p(index).have("Index",index)
    }
  }


  // IR Output
  def toXML : Elem = {
    <Entity>
      {if(parent_type != "" && parent_id != -1){
      <Parent>
        <Type>{parent_type}</Type><ID>{parent_id}</ID>
      </Parent>
    }else{
        <Parent/>
    }}
      {if(entity_type != "" && entity_id != -1){
      <Current>
        <Type>{entity_type}</Type><ID>{entity_id}</ID>
      </Current>
    }else{
        <Current/>
    }}
      <Parameter>{Parameters.map(x=>{
        <KeyValue><PKey>{x._1}</PKey><PValue>{x._2}</PValue></KeyValue>
      })}</Parameter>
      <Sources>{sources.map(s=>{
        <ID>{s.entity_id}</ID><Port></Port> // TODO: Virtual Source to Physical Port
      })}</Sources>
      <Sinks>{sinks.map(s=>{
        <ID>{s.entity_id}</ID><Port></Port> // TODO: Virtual Sink to Physical Port
      })}</Sinks>
      <Ports>{ports.map(i=>i.toXML)}</Ports>
      <Relationships>{Relationships.map(r=>{<link><Source>{r._1.entity_id}</Source><Sink>{r._2.entity_id}</Sink></link>})}</Relationships>
      {if(Entities.nonEmpty){
      <InternalEntities>{Entities.map(e=>{e.toXML})}</InternalEntities>}
      else{<InternalEntities/>}}
    </Entity>
  }
}



