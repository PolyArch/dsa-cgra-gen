package dsl

import scala.collection.mutable.Set

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
      val subnet_offset = getPropByKey("subnet_offset")
        .asInstanceOf[List[Int]]
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
      val curr_output_nodes:Set[Any] = getPropByKey("output_nodes")
        .asInstanceOf[Set[Any]]
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
      val curr_output_nodes:Set[Any] = getPropByKey("output_nodes")
        .asInstanceOf[Set[Any]]
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
      val curr_input_nodes:Set[Any] = getPropByKey("input_nodes")
        .asInstanceOf[Set[Any]]
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
      val curr_input_nodes:Set[Any] = getPropByKey("input_nodes")
        .asInstanceOf[Set[Any]]
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
