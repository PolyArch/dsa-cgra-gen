package dsl

import java.io.{File, PrintWriter}
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

import org.yaml.snakeyaml.Yaml
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.dataformat.yaml.YAMLFactory
import scala.util.parsing.json._
import scala.collection.mutable.Map
import scala.collection.mutable.Set
import scala.collection.JavaConverters._

trait PrintableNode {
  private val properties : Map[String,Any] = Map[String,Any]()
  private val yaml = new Yaml()

  // Get
  def getProps = properties
  def getPropByKey(key:String):Any = {
    if(properties.isDefinedAt(key)){
      properties(key)
    }else{
      None
    }
  }
  def  getPropByKeys(keys:Seq[String]):Seq[Any]={
    for (key <- keys) yield
      if(properties.isDefinedAt(key))
        properties(key)
      else
        None
  }

  // Set
  def apply(props:Map[String,Any]):PrintableNode={
    for (kv <- props){
      properties(kv._1) = kv._2
    }
    this
  }
  def apply(key:String, value:Any):PrintableNode= {
    properties += (key -> value)
    this
  }
  def apply(kvpairs:(String, Any)*):PrintableNode ={
    for (kv <- kvpairs){
      val key: String = kv._1
      val value: Any = kv._2
      apply(key, value)
    }
    this
  }

  override def toString: String = {
    toString("json")
  }

  def toString(format:String):String = {
    format match {
      case "json" => convertYamlToJson(yaml.dump(toJava(properties)))
      case "yaml" => yaml.dump(toJava(properties))
    }
  }

  def convertYamlToJson(yaml: String): String = {
    val yamlReader = new ObjectMapper(new YAMLFactory())
    val obj = yamlReader.readValue(yaml, classOf[Any])
    val jsonWriter:ObjectMapper = new ObjectMapper()
    jsonWriter.writerWithDefaultPrettyPrinter().writeValueAsString(obj)
  }

  def toJSON(tree:Any):Any={
    tree match {
      case imSet:collection.immutable.Set[_] => toJSON(imSet.toList)
      case set:Set[_]=> toJSON(set.toList)
      case map:Map[String, Any] =>
        for (kv <- map) map(kv._1) = toJSON(kv._2)
        JSONObject(map.toMap)
      case seq:Seq[_] => seq.map(toJSON)
      case yaml:PrintableNode => toJSON(yaml.getProps)
      case _ => tree
    }
  }

  def toJava(scala:Any):Any={
    scala match {
      case imSet:collection.immutable.Set[_] => toJava(imSet.toSeq)
      case set:Set[_]=> toJava(set.toSeq)
      case map:Map[String, Any] =>
        for (kv <- map) map(kv._1) = toJava(kv._2)
        map.toMap.asJava
      case seq:Seq[_] => seq.map(toJava).asJava
      case yaml:PrintableNode => toJava(yaml.getProps)
      case _ => scala
    }
  }
  def printfile(filename:String):Unit=
    printfile(filename,"json","yaml")
  def printfile(filename:String,formats:String*):Unit={
    postprocess()
    // Create File Name
    // Timestamp
    val tp : String = DateTimeFormatter.ofPattern("_yyMMdd_HHmmss").format(LocalDateTime.now)
    // Print to File
    for (format <- formats){
      val tempFileName : String = filename + "." + format
      val tempFile = new File(tempFileName)
      val pw = new PrintWriter(tempFile)
      println(this.toString(format))
      pw.write(this.toString(format))
      pw.close()
    }
  }

  def postprocess():Unit
}

class ssnode(nodeType:String) extends PrintableNode {
  def postprocess():Unit={}
  def add_sink(sink:ssnode):Unit={
    val sink_info = Map(
      "nodeType" -> sink.getPropByKey("nodeType"),
      "id" -> sink.getPropByKey("id")
    )
    if(getPropByKey("output_nodes")!= None){
      val curr_output_nodes:Set[Map[String, Any]] = getPropByKey("output_nodes").asInstanceOf[Set[Map[String, Any]]]
      this("output_nodes", curr_output_nodes += sink_info)
    }else{
      this("output_nodes", Set[Map[String, Any]]() += sink_info)
    }
  }
  def add_source(source:ssnode):Unit={
    val source_info = Map(
      "nodeType" -> source.getPropByKey("nodeType"),
      "id" -> source.getPropByKey("id")
    )
    if(getPropByKey("input_nodes")!= None){
      val curr_input_nodes:Set[Map[String, Any]] = getPropByKey("input_nodes").asInstanceOf[Set[Map[String, Any]]]
      this("input_nodes", curr_input_nodes += source_info)
    }else{
      this("input_nodes", Set[Map[String, Any]]() += source_info)
    }
  }

  def * (duplicate_time:Int) : Seq[ssnode] =
    for (idx <- 0 until duplicate_time) yield this.clone()
  def |=> (nodes : Seq[ssnode]) : Seq[sslink] = {
    for (node <- nodes) yield this --> node
  }
  def |=> (nodes : Set[ssnode]) : Seq[sslink] = {
    this |=> nodes.toSeq
  }
  def <=| (nodes : Seq[ssnode]) : Seq[sslink] = {
    for (node <- nodes) yield this <-- node
  }
  def <=| (nodes : Set[ssnode]) : Seq[sslink] = {
    this <=| nodes.toSeq
  }
  def --> (that:ssnode): sslink ={
    val link = new sslink
    this.add_sink(that)
    that.add_source(this)
    val source_info = Map(
      "nodeType" -> this.getPropByKey("nodeType"),
      "id" -> this.getPropByKey("id")
    )
    val sink_info = Map(
      "nodeType" -> that.getPropByKey("nodeType"),
      "id" -> that.getPropByKey("id")
    )
    link(("source",source_info),("sink",sink_info))
    link
  }
  def --> (that:ssnode, kvpairs:(String,Any)*):sslink = {
    val link = this --> that
    kvpairs.foreach(link.apply(_))
    link
  }
  def <-- (that:ssnode) : sslink = {
    that --> this
  }
  def <-- (that:ssnode,kvpairs:(String,Any)*):sslink = {
    val link = that --> this
    kvpairs.foreach(link.apply(_))
    link
  }
  def <-> (that:ssnode):Seq[sslink]={
    val alink = this --> that
    val blink = this <-- that
    Seq(alink,blink)
  }
  def == (that:ssnode): Boolean = {
    val thisid:Int = this.getPropByKey("id").asInstanceOf[Int]
    val thatid:Int = that.getPropByKey("id").asInstanceOf[Int]
    thisid == thatid
  }
  def has (keys:String*):Boolean = {
    val prop = getProps
    val keysExistance = for (key <- keys) yield prop.isDefinedAt(key)
    keysExistance.forall(x=>x)
  }
  override def clone(): ssnode = {
    val node = new ssnode(nodeType)
    val prop = Map[String,Any]() ++ this.getProps
    node(prop)
    node(("id", node.hashCode()))
    node
  }

  this(("nodeType", nodeType))
  this(("id", this.hashCode()))
}

class sslink extends PrintableNode{
  def postprocess():Unit={}
  def == (that:sslink): Boolean = {
    val thisSourceInfo = getPropByKey("source").asInstanceOf[Map[String,Any]]
    val thisSinkInfo = getPropByKey("sink").asInstanceOf[Map[String,Any]]
    val thatSourceInfo = that.getPropByKey("source").asInstanceOf[Map[String,Any]]
    val thatSinkInfo = that.getPropByKey("sink").asInstanceOf[Map[String,Any]]
    thisSourceInfo("nodeType") == thatSourceInfo("nodeType") &&
      thisSinkInfo("nodeType") == thatSinkInfo("nodeType") &&
      thisSourceInfo("id") == thatSourceInfo("id") &&
      thisSinkInfo("id") == thatSinkInfo("id")
  }
}

class ssfabric extends PrintableNode {
  def reset():Unit={
    getProps.clear()
  }
  def apply(link:sslink):ssfabric={
    if(getPropByKey("topology")!= None){
      val currLinks:Set[sslink] = getPropByKey("topology").asInstanceOf[Set[sslink]]
      if(!currLinks.exists(l=>l == link))
        this("topology", currLinks += link)
    }else{
      this("topology", Set[sslink]() += link)
    }
    this
  }
  def apply(node:ssnode) :ssfabric= {
    if(getPropByKey("nodes")!= None){
      val currNodes:Set[ssnode] = getPropByKey("nodes").asInstanceOf[Set[ssnode]]
      if(!currNodes.exists(n=>n == node))
        this("nodes", currNodes += node)
    }else{
      this("nodes", Set[ssnode]() += node)
    }
    this
  }
  def apply(seq:Seq[PrintableNode]):ssfabric={
    for (elem <- seq)
      elem match{
        case l:sslink => this(l)
        case n:ssnode => this(n)
      }
    this
  }
  def apply(row_idx:Int)(col_idx:Int)(nodeType:String):ssnode={
    val currNodes:Set[ssnode] = getPropByKey("nodes").asInstanceOf[Set[ssnode]]
    val target_node = currNodes.filter(node=>{
      val node_info = node.getPropByKeys(Seq("row_idx","col_idx", "nodeType"))
      node_info == Seq(row_idx, col_idx, nodeType)
    })
    require(target_node.size == 1)
    target_node.head
  }
  def apply(keys: String*)(value: Any*):Seq[ssnode] = {
    val currNodes:Set[ssnode] = getPropByKey("nodes").asInstanceOf[Set[ssnode]]
    currNodes.filter(node=>{node.getPropByKeys(keys)== value}).toSeq
  }

  def satisfy(keys: String*)(funcs: (Any=>Boolean)*):Seq[ssnode] = {
    val currNodes:Set[ssnode] = getPropByKey("nodes").asInstanceOf[Set[ssnode]]
    currNodes.filter(node=>{
      val satisfications = for(value_idx <- node.getPropByKeys(keys).zipWithIndex)
        yield {
          val value = value_idx._1
          val idx = value_idx._2
          val fs = funcs.toList
          val f = fs(idx)
          f(value)
        }
      satisfications.forall(s=>s)
    }).toSeq
  }

  // Pre-Defined Topology
  def formMesh(fu:ssnode, switch:ssnode, row:Int, col:Int) : Unit = {
    reset()
    apply(("numRow", row), ("numCol", col))
    val fuGrid = Array.ofDim[ssnode](row,col)
    val swGrid = Array.ofDim[ssnode](row+1,col+1)
    // Fill with initial FU and Switch
    for (row_idx <- 0 until row;col_idx <- 0 until col){
      val temp_fu = fu.clone
      apply(temp_fu); temp_fu(("row_idx", row_idx),("col_idx", col_idx))
      fuGrid(row_idx)(col_idx) = temp_fu
    }
    for (row_idx <- 0 until row + 1;col_idx <- 0 until col + 1){
      val temp_switch = switch.clone
      apply(temp_switch); temp_switch(("row_idx", row_idx),("col_idx", col_idx))
      swGrid(row_idx)(col_idx) = temp_switch
    }
    // Connect Them Together
    Input4Output1Mesh(fuGrid, swGrid, row, col)
  }
  def formMeshfromText(fuGrid: Array[Array[ssnode]], switch:ssnode) : Unit = {
    reset()
    val row = fuGrid.length
    val col = fuGrid.head.length
    apply(("numRow", row), ("numCol", col))
    val swGrid = Array.ofDim[ssnode](row+1,col+1)
    // Adding Fu Node
    for (row_idx <- 0 until row; col_idx <- 0 until col){
      val temp_fu = fuGrid(row_idx)(col_idx).clone()
      fuGrid(row_idx)(col_idx) = temp_fu
      apply(temp_fu); temp_fu(("row_idx", row_idx), ("col_idx", col_idx))
    }
    // Adding Switch Node
    for (row_idx <- 0 until row + 1;col_idx <- 0 until col + 1){
      val temp_switch = switch.clone
      apply(temp_switch); temp_switch(("row_idx", row_idx),("col_idx", col_idx))
      swGrid(row_idx)(col_idx) = temp_switch
    }
    Input4Output1Mesh(fuGrid, swGrid, row, col)
  }
  def Input4Output1Mesh(fuGrid:Array[Array[ssnode]], swGrid:Array[Array[ssnode]], row:Int, col:Int) = {
    // Connect Them Together
    for (row_idx <- 0 until row;col_idx <- 0 until col){
      // 4 Input 1 Output Fu connections
      this(fuGrid(row_idx)(col_idx) <-> swGrid(row_idx+1)(col_idx+1))
      this(fuGrid(row_idx)(col_idx) <-- swGrid(row_idx)(col_idx+1))
      this(fuGrid(row_idx)(col_idx) <-- swGrid(row_idx+1)(col_idx))
      this(fuGrid(row_idx)(col_idx) <-- swGrid(row_idx)(col_idx))
      // Square Switches connections
      this(swGrid(row_idx)(col_idx) <-> swGrid(row_idx)(col_idx+1))
      this(swGrid(row_idx)(col_idx) <-> swGrid(row_idx+1)(col_idx))
      this(swGrid(row_idx+1)(col_idx) <-> swGrid(row_idx+1)(col_idx+1))
      this(swGrid(row_idx)(col_idx+1) <-> swGrid(row_idx+1)(col_idx+1))
    }
  }

  // Post-Process
  def postprocess():Unit={
    // Gather the ISA and Encode them
    val start_encoding = 2 //0 is saved for NOP, 1 is saved for copy
    val allFuNodes = this("nodeType")("function unit")
    val allInsts = allFuNodes.flatMap(n=>n.getPropByKey("Insts")
      .asInstanceOf[collection.immutable.Set[String]]).distinct
    val InstsWithEnc = Map[String, Int]() ++= (for (i <- allInsts.indices)
      yield allInsts(i) -> (i + start_encoding))
    apply("Instruction Set", InstsWithEnc)
  }
}