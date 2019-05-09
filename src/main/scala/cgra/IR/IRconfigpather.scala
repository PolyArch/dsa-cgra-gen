package cgra.IR

import scala.collection.mutable
import scala.collection.mutable.ListBuffer
import IRpreprocessor._

object IRconfigpather {
  type ssnode_t = (String, mutable.Map[String, Any])

  var num_ssnode : Int = 0
  val rand = scala.util.Random
  val ssnodeGraph = new Graph[ssnode_t]
  var ssnodeGraphMatrix : Array[Array[Boolean]] = Array.ofDim[Boolean](1,1)
  var ssnodeConfigPathMatrix : Array[Array[Boolean]] = Array.ofDim[Boolean](1,1)
  val ssnodeList : ListBuffer[ssnode_t] = new ListBuffer[ssnode_t]()
  var ssnodeMap = ssnodeList.toMap
  var ssnodeTopology : List[String] = Nil
  var ssnodeConnection : List[connection] = Nil

  var input_ssnodes_list : List[ssnode_t] = Nil

  def getGraph(ir:mutable.Map[String,Any])= {
    if(ir.isDefinedAt("routers"))
      ssnodeList ++= ssnodeGroup2List(ir("routers"))
    if(ir.isDefinedAt("dedicated_pes"))
      ssnodeList ++= ssnodeGroup2List(ir("dedicated_pes"))
    if(ir.isDefinedAt("shared_pes"))
      ssnodeList ++= ssnodeGroup2List(ir("shared_pes"))
    ssnodeTopology = ir("topology").asInstanceOf[List[String]]
    buildGraph()
    buildConfigPath()

    val startNode = ssnodeList(rand.nextInt(ssnodeList.length))
    val testBFS = ssnodeGraph.BFS(startNode)
    val testDFS = ssnodeGraph.DFS(startNode)
    ssnodeGraph
  }

  def buildGraph() :Unit = {
    ssnodeMap = ssnodeList.toMap
    num_ssnode = ssnodeList.length
    ssnodeGraphMatrix = Array.ofDim[Boolean](num_ssnode,num_ssnode)
    ssnodeConnection = ssnodeTopology map parse_conn
    for (source_ssnode <- ssnodeList){
      // Connection List
      val sink_nodes : List[ssnode_t] =
        ssnodeConnection.filter(c=>c.source.module == source_ssnode._1).map(_.sink.module)
          .filter(ssnodeMap.isDefinedAt(_)).map(n=>(n,ssnodeMap(n)))
      ssnodeGraph.g += source_ssnode -> sink_nodes
      // Connection Matrix
      val row_idx : Int = ssnodeList.indexOf(source_ssnode)
      for (sink_node <- sink_nodes){
        val col_idx : Int = ssnodeList.indexOf(sink_node)
        ssnodeGraphMatrix(row_idx)(col_idx) = true
      }
    }
    input_ssnodes_list =
      ssnodeConnection.filter(_.source.module contains("vec_in"))
      .map(_.sink.module).map(n=>(n,ssnodeMap(n)))
  }

  def buildConfigPath() = {
    num_ssnode = ssnodeList.length
    ssnodeConfigPathMatrix = Array.ofDim[Boolean](num_ssnode,num_ssnode)
    initializeConfigMatrix()

    while(!printConfigPath()){
      initializeConfigMatrix()
    }
    getConfigPathPerf()
    optimizeConfigMatrix()
  }

  def initializeConfigMatrix() = {
    // Assign Random Input Config Port
    for (col_idx <- 0 until num_ssnode){
      val curr_node_name = ssnodeList(col_idx)._1
      val conn_idxs = ssnodeGraphMatrix.map(_(col_idx)).zipWithIndex.filter(_._1).map(_._2)
      val rand_conn_idx = conn_idxs(rand.nextInt(conn_idxs.length))
      ssnodeConfigPathMatrix(rand_conn_idx)(col_idx) = true
    }
    // Delete Input Config Port in Input node
    for (startNode <- input_ssnodes_list){
      val start_col_idx = ssnodeList.indexOf(startNode)
      for (row_idx <- 0 until num_ssnode)
        ssnodeConfigPathMatrix(row_idx)(start_col_idx) = false
    }
  }

  def getConfigPathPerf() = {
    val visited : Array[Boolean] = Array.fill[Boolean](num_ssnode)(false)
    var currNodeList : List[ssnode_t] = Nil
    for (startNode <- input_ssnodes_list){
      currNodeList = List(startNode)
      println("----------" + startNode._1 + " Start ----------")
      while(currNodeList != Nil){
        println(currNodeList.map(_._1))
        val nextNodeList : ListBuffer[ssnode_t] = new ListBuffer[ssnode_t]()
        for (currNode <- currNodeList){
          val curr_idx = ssnodeList.indexOf(currNode)
          visited(curr_idx) = true
          val next_nodes_idx = ssnodeConfigPathMatrix(curr_idx).zipWithIndex.filter(_._1)
          if(next_nodes_idx != null){
            for (next_node_idx <- next_nodes_idx){
              if (!visited(next_node_idx._2)) {
                nextNodeList += ssnodeList(next_node_idx._2)
              }
            }
          }
        }
        currNodeList = nextNodeList.toList
      }
      println("----------" + startNode._1 + "  End ----------")
    }
  }

  def optimizeConfigMatrix() = {

  }

  def printConfigPath() = {
    val visited : Array[Boolean] = Array.fill[Boolean](num_ssnode)(false)
    var currNodeList : List[ssnode_t] = Nil
    for (startNode <- input_ssnodes_list){
      currNodeList = List(startNode)
      println("----------" + startNode._1 + " Start ----------")
      while(currNodeList != Nil){
        println(currNodeList.map(_._1))
        val nextNodeList : ListBuffer[ssnode_t] = new ListBuffer[ssnode_t]()
        for (currNode <- currNodeList){
          val curr_idx = ssnodeList.indexOf(currNode)
          visited(curr_idx) = true
          val next_nodes_idx = ssnodeConfigPathMatrix(curr_idx).zipWithIndex.filter(_._1)
          if(next_nodes_idx != null){
            for (next_node_idx <- next_nodes_idx){
              if (!visited(next_node_idx._2)) {
                nextNodeList += ssnodeList(next_node_idx._2)
              }
            }
          }
        }
        currNodeList = nextNodeList.toList
      }
      println("----------" + startNode._1 + "  End ----------")
    }
    val all_visited = visited.forall(x=>x)
    println("All nodes visited ? " + all_visited)
    all_visited
  }

  def ssnodeGroup2List(g:Any) ={
    val group = g.asInstanceOf[mutable.Map[String, Any]]
    val ssnodeList : ListBuffer[ssnode_t] = new ListBuffer[ssnode_t]()
    for (node <- group){
      if (!node._1.contains("default")){
        val node_name = node._1
        val node_value = node._2.asInstanceOf[mutable.Map[String, Any]]
        val ssnode = (node_name, node_value)
        ssnodeList += ssnode
      }
    }
    ssnodeList
  }
}


class Graph[T] {
  type Vertex = T
  type GraphMap = mutable.Map[Vertex,List[Vertex]]
  val g:GraphMap = mutable.Map[Vertex,List[Vertex]]()

  def BFS(start: Vertex): List[List[Vertex]] = {

    def BFS0(elems: List[Vertex],visited: List[List[Vertex]]): List[List[Vertex]] = {
      val newNeighbors = elems.flatMap(g(_)).filterNot(visited.flatten.contains).distinct
      if (newNeighbors.isEmpty)
        visited
      else
        BFS0(newNeighbors, newNeighbors :: visited)
    }

    BFS0(List(start),List(List(start))).reverse
  }

  def DFS(start: Vertex): List[Vertex] = {

    def DFS0(v: Vertex, visited: List[Vertex]): List[Vertex] = {
      if (visited.contains(v))
        visited
      else {
        val neighbours:List[Vertex] = g(v) filterNot visited.contains
        neighbours.foldLeft(v :: visited)((b,a) => DFS0(a,b))

      }
    }
    DFS0(start,List()).reverse
  }
}