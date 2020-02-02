package dsl

import scala.collection.mutable.{ListBuffer, Set}

class ssnode(nodeType:String) extends IRPrintable {

  // Private Variables
  private val output_links : ListBuffer[sslink] = ListBuffer[sslink]()
  private val input_links : ListBuffer[sslink] = ListBuffer[sslink]()

  // Add/Delete Sink Node
  def add_sink(sink:ssnode) : Int ={
    var sink_info = sink.getPropByKeys(identifier.keys.toList)
    if(getPropByKey("output_nodes")!= None){
      val curr_output_nodes:ListBuffer[Any] = getPropByKey("output_nodes")
        .asInstanceOf[ListBuffer[Any]]
      apply("output_nodes", curr_output_nodes += sink_info)
      return curr_output_nodes.length - 1
    }else{
      apply("output_nodes", ListBuffer[Any]() += sink_info)
      return 0
    }
  }
  def add_sink(link:sslink):Unit={
    output_links += link
  }
  def delete_sink(sink:ssnode):Unit={
    var sink_info = sink.getPropByKeys(identifier.keys.toList)
    if(getPropByKey("output_nodes")!= None){
      val curr_output_nodes:ListBuffer[Any] = getPropByKey("output_nodes")
        .asInstanceOf[ListBuffer[Any]]
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
  def add_source(source:ssnode):Int={
    val source_info : Any = source.getPropByKeys(identifier.keys.toList)
    if(getPropByKey("input_nodes")!= None){
      val curr_input_nodes:ListBuffer[Any] = getPropByKey("input_nodes")
        .asInstanceOf[ListBuffer[Any]]
      this("input_nodes", curr_input_nodes += source_info)
      return curr_input_nodes.length - 1
    }else{
      this("input_nodes", ListBuffer[Any]() += source_info)
      return 0
    }
  }
  def add_source(link:sslink):Unit={
    input_links += link
  }
  def delete_source(source:ssnode):Unit={
    val source_info : Any = source.getPropByKeys(identifier.keys.toList)
    if(getPropByKey("input_nodes")!= None){
      val curr_input_nodes:ListBuffer[Any] = getPropByKey("input_nodes")
        .asInstanceOf[ListBuffer[Any]]
      this("input_nodes", curr_input_nodes -= source_info)
    }
  }
  def delete_source(link:sslink):Unit={
    input_links -= link
  }

  // ------ Basic Utility ------
  // Find possible links
  def ? (that:ssnode):ListBuffer[sslink]={
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
    val out_link_idx : Int = this.add_sink(that)
    val in_link_idx : Int = that.add_source(this)
    val source_info = this.getPropByKeys(identifier.keys.toList)
    val sink_info = that.getPropByKeys(identifier.keys.toSeq)
    link(this,that)
    this.add_sink(link)
    that.add_source(link)
    link("source",source_info)(
      "sink",sink_info)(
      "source_out_idx", out_link_idx)(
      "sink_in_idx", in_link_idx)
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
    for (id <- identifier.keys) {
      cloned_prop = cloned_prop - id
    }
    node("nodeType", currNodeType)
    node(cloned_prop - "output_nodes" - "input_nodes")
    node
  }

  // Pre-process
  // pre-defined properties
  apply("nodeType", nodeType)
  apply("id", this.hashCode())


  // Postprocess
  def postprocess():Unit={

    // datapath properties
    val data_width = getPropByKey("data_width").asInstanceOf[Int]
    val granularity = {
      if(has("granularity"))
        getPropByKey("granularity").asInstanceOf[Int]
      else {
        apply("granularity", data_width)
        data_width
      }
    }
    val decomposer = data_width / granularity;
    require(data_width == decomposer * granularity,"data_width = " + data_width +
      ", granularity = " + granularity + ", decomposer = " + decomposer)

    // I/O Port Properties
    val num_input = input_links.size; apply("num_input", num_input)
    val num_output = output_links.size; apply("num_output", num_output)
    if(num_input > 0){
      val input_nodes = apply("input_nodes").asInstanceOf[ListBuffer[ssnode]]
      require(num_input == input_nodes.length)
    }
    if(num_output > 0){
      val output_nodes = apply("output_nodes").asInstanceOf[ListBuffer[ssnode]]
      require(num_output == output_nodes.length)
    }

    // Function-Unit specific process
    if(getValue(getPropByKey("nodeType"))=="function unit"){
      val insts = getPropByKey("instructions")
      insts match {
        case single:String => apply("instructions", collection.immutable.Set(single))
        case _ =>
      }
    }
  }
}
