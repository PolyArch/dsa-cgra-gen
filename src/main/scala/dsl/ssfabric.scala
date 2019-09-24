package dsl

import scala.collection.mutable.{Map, Set}


class ssfabric extends IRPrintable {
  //pre-processs
  apply("identifier", identifier.key)

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
        nodes -= node
      }else{
        assert(false, "No such node")
      }
    }else{
      assert(false, "Empty mesh")
    }
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
    require(target_node.size == 1,
      target_node.size + " nodes found")
    target_node.head
  }
  // Pick out the nodes that have right kv pair
  private def findNodeByKey(currNodes:Set[ssnode],
                            keys:Seq[String],values:Seq[Any]) = {
    currNodes.filter(node=>{node.getPropByKeys(keys).zipWithIndex.forall(value_idx =>{
      val value = getValue(value_idx._1)
      val idx = value_idx._2
      value == values(idx)
    })})
  }
  // Pick node with key value pair
  def apply(keys: String*)(values: Any*):Seq[ssnode] = {
    if(getPropByKey("nodes")!=None){
      val currNodes = getPropByKey("nodes").asInstanceOf[Set[ssnode]]
      findNodeByKey(currNodes, keys,values).toSeq
    }else{
      Seq[ssnode]()
    }
  }
  // Get node or else
  def getOrElse(keys: String*)(values: Any*)(elseNode:ssnode) = {
    if(getPropByKey("nodes")!=None){
      val currNodes = getPropByKey("nodes").asInstanceOf[Set[ssnode]]
      val cands = findNodeByKey(currNodes, keys,values)
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
    childs.foreach(c=>c("depth",depth-1))
    // Determine the direction of tree
    val links = if(is_distribute){
      parent |=> childs
    }else{
      parent <=| childs
    }
    // Connect
    if(depth >1){
      val left_childtree = buildTree(childs(0),depth-1,is_distribute)
      val right_childtree = buildTree(childs(1),depth-1,is_distribute)
      (left_childtree._1 union right_childtree._1 :+ parent,
        left_childtree._2 union right_childtree._2 union links)
    }else{
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
      val temp_allInsts = allFuNodes.map(n=>n.getPropByKey("Insts"))
        .distinct
      var allInsts : List[String] = Nil
      for (insts <- temp_allInsts){
        insts match {
          case i:String => allInsts = allInsts :+ i
          case is:collection.immutable.Set[String] =>
            allInsts = allInsts ::: is.toList
        }
      }
      val InstsWithEnc = Map[String, Int]() ++= (for (i <- allInsts.indices)
        yield allInsts(i) -> (i + start_encoding))
      apply("Instruction Set", InstsWithEnc)
    }
    // TODO: Make sure all nodes have different identifier
  }
}
