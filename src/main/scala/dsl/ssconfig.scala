package dsl

import java.io.{File, PrintWriter}
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

import org.yaml.snakeyaml.Yaml

import scala.collection.mutable.Map
import scala.collection.mutable.Set
import cgra.IR.IRconvertor._

import scala.collection.mutable

// Singleton identifier
object identifier {
  var key : List[String] = List("nodeType")
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

  // Set
  def apply(props:Map[String,Any]):IRPrintable={
    for (kv <- props){
      apply(kv._1,kv._2)
    }
    this
  }
  def apply(key:String, value:Any):IRPrintable={
    if(identifier.key.contains(key)){
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
      if(format == "yaml")
        println(this.toString(format))
      pw.write(this.toString(format))
      pw.close()
    }
  }
}

class ssnode(nodeType:String) extends IRPrintable {

  // pre-defined properties
  apply("decomposer", 8)
  apply("subnet_offset", List(0))

  // Private Variables
  private val output_links : Set[sslink] = Set[sslink]()
  private val input_links : Set[sslink] = Set[sslink]()

  // Postprocess before output
  def postprocess():Unit={
    val decomposer = getPropByKey("decomposer").asInstanceOf[Int]
    val num_input = input_links.size;apply("num_input", num_input)
    val num_output = output_links.size;apply("num_output", num_output)
    if(num_input > 0 && num_output > 0){
      val subnet_offset = getPropByKey("subnet_offset").asInstanceOf[List[Int]]
      val subnet_table = Array.ofDim[Boolean](
        num_output*decomposer,num_input*decomposer)
      for(op_idx <- 0 until num_output;os_idx <- 0 until decomposer;
          ip_idx <- 0 until num_input; is_idx <- 0 until decomposer){
        subnet_table( op_idx * decomposer + os_idx)(
          ip_idx * decomposer + is_idx)  =
          if(subnet_offset.contains(is_idx - os_idx) ||
             subnet_offset.contains(os_idx - decomposer + is_idx))
            true
          else
            false
      }
      apply("subnet_table", subnet_table)
    }
  }
  // Add/Delete Sink Node
  def add_sink(sink:ssnode):Unit={
    var sink_info = sink.getPropByKeys(identifier.key)
    if(getPropByKey("output_nodes")!= None){
      val curr_output_nodes:Set[Any] = getPropByKey("output_nodes").asInstanceOf[Set[Any]]
      apply("output_nodes", curr_output_nodes += sink_info)
    }else{
      apply("output_nodes", Set[Any]() += sink_info)
    }
  }
  def add_sink(link:sslink):Unit={
    output_links += link
  }
  def delete_sink(sink:ssnode):Unit={
    var sink_info = sink.getPropByKeys(identifier.key)
    if(getPropByKey("output_nodes")!= None){
      val curr_output_nodes:Set[Any] = getPropByKey("output_nodes").asInstanceOf[Set[Any]]
      apply("output_nodes", curr_output_nodes -= sink_info)
    }
  }
  def delete_sink(link:sslink):Unit={
    output_links -= link
  }
  def delete = {
    // delete source links (automatically delete nodes)
    for (source_link <- input_links){
      source_link.delete
      delete_source(source_link)
    }
    // delete sink links (automatically delete nodes)
    for (sink_link <- output_links){
      sink_link.delete
      delete_sink(sink_link)
    }
  }

  // Add/Delete Source Node
  def add_source(source:ssnode):Unit={
    val source_info : Any = source.getPropByKeys(identifier.key)
    if(getPropByKey("input_nodes")!= None){
      val curr_input_nodes:Set[Any] = getPropByKey("input_nodes").asInstanceOf[Set[Any]]
      this("input_nodes", curr_input_nodes += source_info)
    }else{
      this("input_nodes", Set[Any]() += source_info)
    }
  }
  def add_source(link:sslink):Unit={
    input_links += link
  }
  def delete_source(source:ssnode):Unit={
    val source_info : Any = source.getPropByKeys(identifier.key)
    if(getPropByKey("input_nodes")!= None){
      val curr_input_nodes:Set[Any] = getPropByKey("input_nodes").asInstanceOf[Set[Any]]
      this("input_nodes", curr_input_nodes -= source_info)
    }
  }
  def delete_source(link:sslink):Unit={
    input_links -= link
  }

  // ------ Basic Utility ------
  // Find possible links
  def ? (that:ssnode):Set[sslink]={
    this.output_links intersect that.input_links
  }
  // Duplicate ssnode
  def * (duplicate_time:Int) : Seq[ssnode] =
    for (idx <- 0 until duplicate_time) yield this.clone()
  // Connection
  def |=> (nodes : Seq[ssnode]) : Seq[sslink] = {
    for (node <- nodes) yield this --> node
  }
  def <=| (nodes : Seq[ssnode]) : Seq[sslink] = {
    for (node <- nodes) yield this <-- node
  }
  def --> (that:ssnode): sslink ={
    val link = new sslink
    this.add_sink(that)
    that.add_source(this)
    val source_info = this.getPropByKeys(identifier.key)
    val sink_info = that.getPropByKeys(identifier.key)
    link(this,that)
    this.add_sink(link)
    that.add_source(link)
    link("source",source_info)("sink",sink_info)
    link
  }
  def --> (that:ssnode, kvpairs:(String,Any)*):sslink = {
    val link = this --> that
    kvpairs.foreach(kv=>link.apply(kv._1,kv._2))
    link
  }
  def <-- (that:ssnode) : sslink = {
    that --> this
  }
  def <-- (that:ssnode,kvpairs:(String,Any)*):sslink = {
    val link = that --> this
    kvpairs.foreach(kv=>link.apply(kv._1,kv._2))
    link
  }
  def <-> (that:ssnode):Seq[sslink]={
    val alink = this --> that
    val blink = this <-- that
    Seq(alink,blink)
  }
  // Properties manipulation
  def apply(key:String)={
    this.getPropByKey(key)
  }// Get property
  def delete(keys:String*):Unit={
    keys.foreach(deletePropByKey(_))
  }// Delete property
  def has (keys:String*):Boolean = {
    val prop = getProps
    val keysExistance = for (key <- keys) yield prop.isDefinedAt(key)
    keysExistance.forall(x=>x)
  }// Test whether has this property
  override def clone(): ssnode = {
    val currNodeType:String = this.getPropByKey("nodeType")
    val node = new ssnode(currNodeType)
    val temp_cloned_prop = this.getProps
    var cloned_prop = temp_cloned_prop
    for (id <- identifier.key) {
      cloned_prop = cloned_prop - id
    }
    node("nodeType", currNodeType)
    node(cloned_prop - "output_nodes" - "input_nodes")
    node
  }

  apply("nodeType", nodeType)
  apply("id", this.hashCode())
}

class sslink extends IRPrintable{
  private var sink_node:ssnode = _
  private var source_node:ssnode = _
  def get_source = source_node
  def get_sink = sink_node
  def * (duplicate_time:Int) = {
    for (i <- 0 until duplicate_time) yield source_node --> sink_node
  }
  def postprocess():Unit={}
  /*
  def == (that:sslink): Boolean = {
    val thisSourceInfo = getPropByKey("source")
    val thisSinkInfo = getPropByKey("sink")
    val thatSourceInfo = that.getPropByKey("source")
    val thatSinkInfo = that.getPropByKey("sink")
    thisSourceInfo == thatSourceInfo && thisSinkInfo == thatSinkInfo
  }
  */
  def reverse():Unit={
    val thisSourceInfo = getPropByKey("source")
    val thisSinkInfo = getPropByKey("sink")
    // Delete Original
    sink_node.delete_source(source_node)
    source_node.delete_sink(sink_node)
    // Add Reverse
    sink_node.add_sink(source_node)
    source_node.add_source(sink_node)
    apply("source",thisSinkInfo)
    apply("sink",thisSourceInfo)
  }
  def apply(source:ssnode, sink:ssnode)={
      source_node = source
      sink_node = sink
  }
  def delete:Unit={
    source_node.delete_sink(sink_node)
    sink_node.delete_source(source_node)
  }
}

class ssfabric extends IRPrintable {
  // nodes and links
  private val nodes : Set[ssnode] = Set[ssnode]()
  private val links : Set[sslink] = Set[sslink]()

  // predefined properties
  apply("datawidth", 64) // datawidth

  // Clear all properties
  def reset():Unit={
    getProps.clear()
    nodes.clear()
    links.clear()
  }
  // Add link
  def apply(link:sslink):ssfabric={
    // Add linked nodes
    apply(link.get_sink);apply(link.get_source)
    // Add link
    if(getPropByKey("links")!= None){
      val currLinks = getPropByKey("links").asInstanceOf[Set[sslink]]
      if(!currLinks.contains(link)){
        this("links", currLinks += link)
      }
    }else{
      this("links", Set[sslink]() += link)
    }
    links += link
    this
  }
  // Delete link
  def delete(link:sslink):ssfabric={
    if(getPropByKey("links")!= None){
      val currLinks = getPropByKey("links").asInstanceOf[Set[sslink]]
      if(currLinks.contains(link)){
        this("links", currLinks -= link)
        link.delete
      }
    }
    links -= link
    this
  }
  // Add node
  def apply(node:ssnode) :ssfabric= {
    if(getPropByKey("nodes")!= None){
      val currNodes = getPropByKey("nodes").asInstanceOf[Set[ssnode]]
      if(!currNodes.contains(node)){
        node("id",currNodes.size)
        apply("nodes", currNodes += node)
      }
    }else{
      node("id",0)
      apply("nodes", Set[ssnode]() += node)
    }
    nodes += node
    this
  }
  // Delete node
  def delete(node:ssnode):ssfabric={
    if(getPropByKey("nodes")!= None){
      val currNodes = getPropByKey("nodes").asInstanceOf[Set[ssnode]]
      if(currNodes.contains(node)){
        apply("nodes", currNodes -= node)
        node.delete
      }
    }
    nodes -= node
    this
  }
  // Add nodes and links in batch mode
  def apply(seq:Seq[IRPrintable]):ssfabric={
    for (elem <- seq)
      elem match{
        case l:sslink =>
          apply(l)
          links += l
        case n:ssnode =>
          apply(n)
          nodes += n
      }
    this
  }
  // Add Graph
  def apply(graph:(Seq[IRPrintable],Seq[IRPrintable])):ssfabric={
    apply(graph._1)
    apply(graph._2)
    this
  }
  // Pick link by nodes
  def apply(source_node:ssnode, sink_node:ssnode):Set[sslink]={
    source_node ? sink_node
  }
  // Pick node in mesh
  def apply(row_idx:Int)(col_idx:Int)(nodeType:String):ssnode={
    val currNodes = getPropByKey("nodes").asInstanceOf[Set[ssnode]]
    val target_node = currNodes.filter(node=>{
      val target_values = Seq(row_idx,col_idx, nodeType)
      val node_info = node.getPropByKeys(Seq("row_idx","col_idx", "nodeType"))
      node_info.zipWithIndex.forall(value_idx => {
        val value = value_idx._1 match {
          case id:identifier => id.id
          case x => x
        }
        val idx = value_idx._2
        value == target_values(idx)
      })
    })
    require(target_node.size == 1)
    target_node.head
  }
  // Pick node with key value pair
  def apply(keys: String*)(values: Any*):Seq[ssnode] = {
    if(getPropByKey("nodes")!=None){
      val currNodes = getPropByKey("nodes").asInstanceOf[Set[ssnode]]
      currNodes.filter(node=>{node.getPropByKeys(keys).zipWithIndex.forall(value_idx =>{
        val value = value_idx._1 match {
          case id:identifier => id.id
          case x => x
        }
        val idx = value_idx._2
        value == values(idx)
      })}).toSeq
    }else{
      Seq[ssnode]()
    }
  }
  // Get node or else
  def getOrElse(keys: String*)(values: Any*)(elseNode:ssnode) = {
    if(getPropByKey("nodes")!=None){
      val currNodes = getPropByKey("nodes").asInstanceOf[Set[ssnode]]
      val cands = currNodes.filter(node=>{node.getPropByKeys(keys).zipWithIndex.forall(value_idx =>{
        val value = value_idx._1 match {
          case id:identifier => id.id
          case x => x
        }
        val idx = value_idx._2
        value == values(idx)
      })})
      if(cands.nonEmpty){
        cands.head
      }else{
        elseNode
      }
    }else{
      elseNode
    }
  }
  // Pick node that satisfies condition
  def satisfy(keys: String*)(funcs: (Any=>Boolean)*):Seq[ssnode] = {
    val currNodes = getPropByKey("nodes").asInstanceOf[Set[ssnode]]
    currNodes.filter(node=>{
      val satisfications = for(value_idx <- node.getPropByKeys(keys).zipWithIndex)
        yield {
          val value = value_idx._1 match {
            case id: identifier => id.id
            case _ =>
          }
          val idx = value_idx._2
          val fs = funcs.toList
          val f = fs(idx)
          f(value)
        }
      satisfications.forall(s=>s)
    }).toSeq
  }

  // --- Pre-Defined Topology ---

  // build mesh
  def buildMesh(node:ssnode, row:Int, col:Int) = {
    val mesh = Array.ofDim[ssnode](row,col)
    // Fill with initial node
    for (row_idx <- 0 until row;col_idx <- 0 until col){
      val temp_node = node.clone
      mesh(row_idx)(col_idx) = temp_node
    }
    connectMesh(mesh)
  }
  def connectMesh(mesh: Array[Array[ssnode]]) = {
    val row = mesh.length
    val col = mesh.head.length
    apply("numRow", row)("numCol", col)
    // Duplicate array nodes and assigne idx properties
    for (row_idx <- 0 until row; col_idx <- 0 until col){
      mesh(row_idx)(col_idx) = mesh(row_idx)(col_idx).clone()
      val temp_node = mesh(row_idx)(col_idx)
      apply(temp_node); temp_node("row_idx", row_idx)("col_idx", col_idx)
    }
    // Traverse
    for (row_idx <- 0 until row; col_idx <- 0 until col){
      // Connect
      if(row_idx + 1 < row)
        apply(mesh(row_idx)(col_idx) <-> mesh(row_idx + 1)(col_idx))
      if(col_idx + 1 < col)
        apply(mesh(row_idx)(col_idx) <-> mesh(row_idx)(col_idx + 1))
    }
    mesh
  }

  // BuildTree
  def buildTree(parent:ssnode, depth:Int,
                is_distribute:Boolean):(Seq[ssnode],Seq[sslink])={
    val childs = parent * 2
    parent("depth",depth)
    val links = if(is_distribute){
      parent |=> childs
    }else{
      parent <=| childs
    }
    if(depth >1){
      val left_childtree = buildTree(childs(0),depth-1,is_distribute)
      val right_childtree = buildTree(childs(1),depth-1,is_distribute)
      (left_childtree._1 union right_childtree._1 :+ parent,
        left_childtree._2 union right_childtree._2 union links)
    }else{
      childs.foreach(c=>c("depth",depth-1))
      (childs :+ parent, links)
    }
  }

  // Post-Process
  def postprocess():Unit={
    nodes.foreach(_.postprocess())
    links.foreach(_.postprocess())
    // Gather the ISA and Encode them
    val start_encoding = 2 //0 is saved for NOP, 1 is saved for copy
    val allFuNodes = this("nodeType")("function unit")
    if (!allFuNodes.isEmpty){
      val temp_allInsts = allFuNodes.map(n=>n.getPropByKey("Insts")).distinct
      var allInsts : List[String] = Nil
      for (insts <- temp_allInsts){
        insts match {
          case i:String => allInsts = allInsts :+ i
          case is:collection.immutable.Set[String] => allInsts = allInsts ::: is.toList
        }
      }
      val InstsWithEnc = Map[String, Int]() ++= (for (i <- allInsts.indices)
        yield allInsts(i) -> (i + start_encoding))
      apply("Instruction Set", InstsWithEnc)
    }
  }
}