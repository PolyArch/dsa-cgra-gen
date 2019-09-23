package dsl

import java.io.{File, PrintWriter}
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

import org.yaml.snakeyaml.Yaml
import scala.collection.mutable.Map
import scala.collection.mutable.Set
import cgra.IR.IRconvertor._

// Singleton identifier
object identifier {
  var key = List("id", "nodeType")
}

// Identifier Class
class identifier(original_value:Any){
  var id : Any = original_value
}

trait PrintableNode {
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
  def  getPropByKeys(keys:Seq[String]):Seq[Any]={
    for (key <- keys) yield
        getPropByKey(key)
  }

  // Set
  def apply(props:Map[String,Any]):PrintableNode={
    for (kv <- props){
      properties(kv._1) = kv._2
    }
    this
  }
  def apply(key:String, value:Any):PrintableNode={
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
  def apply(kvpairs:(String, Any)*):PrintableNode ={
    for (kv <- kvpairs){
      val key: String = kv._1
      val value: Any = kv._2
      apply(key, value)
    }
    this
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

class ssnode(nodeType:String) extends PrintableNode {

  private val output_links : Set[sslink] = Set[sslink]()
  private val input_links : Set[sslink] = Set[sslink]()

  def postprocess():Unit={}
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
    for (id <- identifier.key)
      cloned_prop = cloned_prop - id
    node(cloned_prop - "output_nodes" - "input_nodes")
    node
  }

  apply("nodeType", nodeType)
  apply("id", this.hashCode())
}

class sslink extends PrintableNode{
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

class ssfabric extends PrintableNode {
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
    apply(link.get_sink);apply(link.get_source)
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
  def apply(seq:Seq[PrintableNode]):ssfabric={
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
  def apply(graph:(Seq[PrintableNode],Seq[PrintableNode])):ssfabric={
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
  def buildMesh(fu:ssnode, switch:ssnode, row:Int, col:Int) = {
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
  def buildMeshfromText(fuGrid: Array[Array[ssnode]], switch:ssnode) = {
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
    (nodes.toSeq, links.toSeq)
  }

  // Post-Process
  def postprocess():Unit={
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