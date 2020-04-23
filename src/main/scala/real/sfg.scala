package real

import dsl._



// SFG has a specific tri-array topology
object sfg extends App{

  identifier("row", "col")

  // Initialize the top node
  val top = new ssnode("fu")
  top("row", 0)("col", 0)

  // New fabric
  val sfg = new ssfabric
  val depth = 2

  // Build tri-array topology
  sfg(top)
  for (row <- 0 until depth){
    val currRowNodes : Seq[ssnode] = sfg.filter("row")(row)
    for (currNode <- currRowNodes){
      val col = currNode("col").asInstanceOf[identifier].id.asInstanceOf[Int]
      // Get bottom node
      val default_below = currNode.clone()
      default_below("row",row+1)("col",col)
      val bottom_node : ssnode =
        sfg.getOrElse("row","col")(row+1,col)(default_below)
      // Get right-bottom node
      val default_bottom_right = currNode.clone()
      default_bottom_right("row",row+1)("col",col+1)
      val right_bottom_node : ssnode =
        sfg.getOrElse("row","col")(row+1,col+1)(default_bottom_right)
      // Connect
      sfg(bottom_node)((bottom_node --> currNode) * 3)
      sfg(right_bottom_node)(bottom_node --> right_bottom_node)
      sfg(right_bottom_node --> currNode)
    }
  }

  // Print
  sfg.printfile("IR/sfg")
}
