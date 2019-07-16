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
  val ssnodeConfigPathMap : mutable.Map[ssnode_t,List[List[ssnode_t]]] = mutable.Map[ssnode_t,List[List[ssnode_t]]]()
  val ssnodeList : ListBuffer[ssnode_t] = new ListBuffer[ssnode_t]()
  var ssnodeMap = ssnodeList.toMap
  var ssnodeTopology : List[String] = Nil
  var ssnodeConnection : List[connection] = Nil
  var input_ssnodes_list : List[ssnode_t] = Nil
  var visited : Array[Boolean] = Array.fill[Boolean](1)(false)

  // Statistic
  var aver_num_config_out : Double = 0.0
  var max_num_config_out : Double = 0.0
  var vari_num_config_out : Double= 0.0

  var aver_config_cycle : Double= 0.0
  var max_config_cycle : Double= 0.0
  var vari_config_cycle : Double= 0.0

  def getGraph(ir:mutable.Map[String,Any]) = {
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
    ssnodeConfigPathMatrix = emptyConfigMatrix()

    var allvisited = false
    while(!allvisited){
      ssnodeConfigPathMatrix = emptyConfigMatrix()
      allvisited = getRandomConfigMatrix()
    }
    printConfigPath()
    getConfigPathPerf()
    optimizeConfigMatrix()
  }

  def emptyConfigMatrix() = {
    val temp = Array.ofDim[Boolean](num_ssnode,num_ssnode)
    for (i <- 0 until num_ssnode; j <- 0 until num_ssnode){
      temp(i)(j) = false
    }
    temp
  }

  def getRandomConfigMatrix() = {
    // Assign Random Input Config Port
    for (col_idx <- 0 until num_ssnode){
      val curr_node_name = ssnodeList(col_idx)._1
      val conn_idxs : Array[Int] = ssnodeGraphMatrix.map(_(col_idx)).zipWithIndex.filter(_._1).map(_._2)
      val rand_conn_idx : Int = conn_idxs(rand.nextInt(conn_idxs.length))
      ssnodeConfigPathMatrix(rand_conn_idx)(col_idx) = true
      for (next <- col_idx + 1 until num_ssnode){
        val nextIn = ssnodeConfigPathMatrix.map(_(next))
        assert(!(nextIn.count(n=>n) >= 1))
      }
    }
    // Delete Input Config Port in Input node
    for (startNode <- input_ssnodes_list){
      val start_col_idx = ssnodeList.indexOf(startNode)
      for (row_idx <- 0 until num_ssnode)
        ssnodeConfigPathMatrix(row_idx)(start_col_idx) = false
    }
    tranverseConfigPathMap()
  }

  def tranverseConfigPathMap() = {
    // Build Map
    visited = Array.fill[Boolean](num_ssnode)(false)
    for (startNode <- input_ssnodes_list){
      var currNodeList : List[ssnode_t] = List(startNode)
      val currConfigPath : ListBuffer[List[ssnode_t]] = new ListBuffer[List[ssnode_t]]()
      while(currNodeList != Nil){
        currConfigPath += currNodeList
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
      ssnodeConfigPathMap(startNode) = currConfigPath.toList
    }
    val all_visited = visited.forall(x=>x)
    //println("All nodes visited ? " + all_visited)
    all_visited
  }

  def getConfigPathPerf() = {
    // Per path statistic
    val stat_num_config_outport_per_path = ssnodeConfigPathMap.map(n_p=>{
      val startNode = n_p._1
      val paths = n_p._2
      val allnodes_num_outport_per_path : List[Double] = paths.flatten.map(ssnodeList.indexOf(_)).map(ssnodeConfigPathMatrix).map(_.count(n=>n).toDouble)

      val num_config_cycle_per_path : Double = paths.flatten.length.toDouble
      val cycleDepthRatio_per_path : Double = num_config_cycle_per_path / paths.length.toDouble
      val aver_num_config_out : Double = mean(allnodes_num_outport_per_path).getOrElse(0)
      val max_num_config_out : Double = allnodes_num_outport_per_path.max
      val vari_num_config_out : Double = variance(allnodes_num_outport_per_path).getOrElse(0)

      val values : Map[String, Double]= Map(
        "num_config_cycle" -> num_config_cycle_per_path,
        "cycle_depth_ratio" -> cycleDepthRatio_per_path,
        "aver_num_config_out" -> aver_num_config_out,
        "max_num_config_out" -> max_num_config_out,
        "vari_num_config_out" -> vari_num_config_out
      )
      (startNode,values)
    })

    // Per Node Statistic
    val allnodes_num_outport = ssnodeConfigPathMatrix.map(_.count(n=>n).toDouble)
    val config_cycle_per_path = stat_num_config_outport_per_path.map(n_v=>{
      (n_v._1,n_v._2("num_config_cycle"))})

    aver_num_config_out = mean(allnodes_num_outport).get
    max_num_config_out = allnodes_num_outport.max
    vari_num_config_out = variance(allnodes_num_outport).get

    aver_config_cycle = mean(config_cycle_per_path.values.toSeq).get
    max_config_cycle = config_cycle_per_path.values.max
    vari_config_cycle = variance(config_cycle_per_path.values.toSeq).get
    (stat_num_config_outport_per_path,
      Map(
      "aver_num_config_out" -> aver_num_config_out,
      "max_num_config_out" -> max_num_config_out,
      "vari_num_config_out" -> vari_num_config_out,
      "aver_config_cycle" -> aver_config_cycle,
      "max_config_cycle" -> max_config_cycle,
      "vari_config_cycle" -> vari_config_cycle
    ))
  }

  def calculate_cost() = {
    10 * aver_num_config_out + 10 * max_num_config_out + 100 * vari_num_config_out +
      aver_config_cycle + max_config_cycle + vari_config_cycle
  }

  def printConfigPath() = {
    for (startNode_path <- ssnodeConfigPathMap){
      val paths = startNode_path._2
      println("----------" + startNode_path._1._1 + " Start ----------")
      for (path <- paths){
        println(path.map(_._1))
      }
      println("----------" + startNode_path._1._1 + "  End ----------")
    }
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

  def optimizeConfigMatrix() = {
    var bestTotalStat = getConfigPathPerf()
    var bestPerPathStat = bestTotalStat._1
    var bestCostVar = bestTotalStat._2
    var bestScore = calculate_cost()
    var bestConfigPathMatrix = ssnodeConfigPathMatrix
    val bestConfigPathMatRecord = emptyConfigMatrix()

    val maxIteration = 5000
    val scoreRecord = new Array[Double](maxIteration)
    for (i <- 0 until maxIteration){
      /*
       Strategy 1 : Move the node of most-node path to other path
       */
      // Use the Best Design for Current Iteration
      ssnodeConfigPathMatrix = bestConfigPathMatrix
      tranverseConfigPathMap()
      var currTotalStat = getConfigPathPerf()
      var currPerPathStat = currTotalStat._1
      var currCostVar = currTotalStat._2

      // Find the most-node path
      val node_num_config_cycle : Map[ssnode_t,Double] = currPerPathStat.map(n=>(n._1,n._2("num_config_cycle"))).toMap
      val most_node_path_startNode = node_num_config_cycle.toSeq.sortWith(_._2 >_._2).head._1
      val most_node_path_numNode = node_num_config_cycle.toSeq.sortWith(_._2 >_._2).head._2
      val most_node_path : List[List[ssnode_t]] = ssnodeConfigPathMap(most_node_path_startNode)
      val allnodes_onPath : List[ssnode_t] = most_node_path.flatten

      // We should only move limited time, the amount should be equal to the difference with average number of nodes
      val aver_numNode_perPath = currCostVar("aver_config_cycle")
      val max_moveoutTime = ((most_node_path_numNode - aver_numNode_perPath) / 3).toInt
      var moved_time = 0

      // Start movement
      for (currNode <- allnodes_onPath){
        // Don't care the input node
        if(!input_ssnodes_list.contains(currNode)){
          val currNode_idx = ssnodeList.indexOf(currNode)
          val possibleSourceNodes_idx : Array[Int] = ssnodeGraphMatrix.map(_(currNode_idx)).zipWithIndex.filter(_._1).map(_._2)
          val possibleSourceNodes : List[ssnode_t] = possibleSourceNodes_idx.map(ssnodeList).toList
          val nodesOnOtherPath : List[ssnode_t] = possibleSourceNodes diff allnodes_onPath
          // If this node do have other source node which is on other path
          if (nodesOnOtherPath != Nil && moved_time < max_moveoutTime){
            // Random select one
            val randIdx = rand.nextInt(nodesOnOtherPath.length)
            val next_sourceNode = nodesOnOtherPath(randIdx)
            val col_idx : Int = ssnodeList.indexOf(currNode)
            val row_idx : Int = ssnodeList.indexOf(next_sourceNode)
            val old_row_idx : Int = ssnodeConfigPathMatrix.map(_(col_idx)).indexWhere(n=>n)
            ssnodeConfigPathMatrix(old_row_idx)(col_idx) = false
            ssnodeConfigPathMatrix(row_idx)(col_idx) = true

            val success : Boolean = tranverseConfigPathMap()
            if(success){
              moved_time += 1
            }else{
              // Movement is not successful
              ssnodeConfigPathMatrix(old_row_idx)(col_idx) = true
              ssnodeConfigPathMatrix(row_idx)(col_idx) = false
              tranverseConfigPathMap()
            }
          }
        }
      }
      /*
       Strategy 1 End
       */

      // Calaulate Score and Update
      val success : Boolean = tranverseConfigPathMap()
      currTotalStat = getConfigPathPerf()
      var currScore = calculate_cost()
      if(success){
        if(currScore < bestScore){
          bestTotalStat = currTotalStat
          bestPerPathStat = bestTotalStat._1
          bestCostVar = bestTotalStat._2
          bestScore = currScore
          bestConfigPathMatrix = ssnodeConfigPathMatrix
          for(i <- 0 until num_ssnode;j <- 0 until num_ssnode)
            bestConfigPathMatRecord(i)(j) = bestConfigPathMatrix(i)(j)
          tranverseConfigPathMap()
          printConfigPath()
        }
      }else{
        currScore = 10000
      }
      scoreRecord(i) = currScore
      //printConfigPath()
      println("------------------ iter: " + i +
        " , curr : " + currScore.formatted("%3.2f") +
        " , best : " + bestScore.formatted("%3.2f") +
        " , succ : " + success +
        " -------------")
    }// End Iteration

    // Assign Optimized Result
    ssnodeConfigPathMatrix = bestConfigPathMatRecord
    tranverseConfigPathMap()
    getConfigPathPerf()
    println("Score = " + calculate_cost())

    // Show Optimization Procedure
    printConfigPath()
    println("------------------ score : " + bestScore + "  -------------")
    println("Optimized")
  }

  // Utility
  def variance(xs: Seq[Double]): Option[Double] = {
    mean(xs).flatMap(m => mean(xs.map(x => Math.pow(x-m, 2))))
  }
  def mean(xs: Seq[Double]): Option[Double] =
    if (xs.isEmpty) None
    else Some(xs.sum / xs.length)
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