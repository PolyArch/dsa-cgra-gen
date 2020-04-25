package real

import scala.util.Random._
import java.io._
import amir_random._
import scala.collection.mutable.ListBuffer

object dfg_gen extends App{
  val num_dfg = 1000
  val max_num_dfgnode = 10
  val inst_list = get_inst_list("b64.ssinst")
  val dfg_start_index = 2000

  for(idx <- dfg_start_index until dfg_start_index+num_dfg){
    val num_input = 2 + nextInt(3)
    val num_output = 1 + nextInt(4)
    val pw = new PrintWriter(new File(s"./DFG/dfg$idx.dfg"))

    // Buffer of node
    var app_nodes = new ListBuffer[String]()

    // Write the input
    for(input_idx <- 0 until num_input){
      pw.write(s"Input: In$input_idx\n")
      app_nodes += s"In$input_idx"
    }
    pw.write("\n")

    // Add random operation node
    var used_app_nodes = new ListBuffer[String]
    val num_node = 5 + nextInt(max_num_dfgnode)
    for(an_idx <- 0 until num_node){
      val operand_node = shuffle(app_nodes).take(2)
      val operation = shuffle(inst_list).head
      val name_app_node = s"AN$an_idx"
      used_app_nodes ++= operand_node
      app_nodes += name_app_node
      pw.write(s"$name_app_node = $operation(${operand_node.head},${operand_node(1)})\n")
    }
    pw.write("\n")

    // Write the Output
    val unused_nodes = app_nodes.distinct diff used_app_nodes.distinct
    var unused_node_idx = num_node
    while(unused_nodes.length > num_output){
      val first = unused_nodes.head
      unused_nodes -= first
      val second = unused_nodes.head
      unused_nodes -= second
      val operation = shuffle(inst_list).head
      val name_app_node = s"AN$unused_node_idx"
      pw.write(s"$name_app_node = $operation($first,$second)\n")
      unused_nodes += name_app_node
      app_nodes += name_app_node
      unused_node_idx += 1
    }

    for(out_idx <- 0 until num_output) {
      if(unused_nodes.nonEmpty){
        val out_node = unused_nodes.head
        pw.write(s"Output: $out_node\n")
        unused_nodes -= out_node
      }else{
        val out_node = shuffle(app_nodes).head
        pw.write(s"Output: $out_node\n")
      }
    }
    pw.write("\n")
    require(unused_nodes.isEmpty)

    pw.close
  }
}
