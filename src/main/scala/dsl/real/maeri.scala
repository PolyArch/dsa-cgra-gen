package dsl.real

import dsl._

object maeri extends App{
  val start_sw = new ssnode("switch")
  val end_add = new ssnode("function unit")
  end_add("Insts","Add")

  def buildTree(parent:ssnode, depth:Int, is_distribute:Boolean):(Seq[ssnode],Seq[sslink])={
    val childs = parent * 2
    parent("depth",depth)
    val links = if(is_distribute){
      parent |=> childs
    }else{
      parent <=| childs
    }

    /*
    println(" ---- ")
    println("depth = " + depth)
    println("parent " + parent.getPropByKey("id") + "->" + parent.getPropByKey("output_nodes"))
    for(idx <- childs.indices)
      println("child "+ childs(idx).getPropByKey("id") + " " + idx +  " ->" + childs(idx).getPropByKey("output_nodes"))
    println(" ---- ")
    */
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

  // Create MAERI
  val MAERI = new ssfabric()

  // Create distribute and reduce Network
  val distribute_network = buildTree(start_sw,3,true)
  val reduce_network = buildTree(end_add,3,false)

  // Create MAERI
  MAERI(distribute_network)(reduce_network)

  // Reverse the link direction of reduce network
  reduce_network._2.foreach(l=>l.reverse())

  // Change the last row function of reduce network to Multiplication
  val last_row_fu = MAERI("nodeType","depth")("function unit",0)
  val last_row_switch = MAERI("nodeType","depth")("switch",0)
  last_row_fu.foreach(fu=>fu("Insts","Mul"))

  // Connect the distribute and reduce Network
  for (i <- last_row_fu.indices){
    MAERI(last_row_switch(i) --> last_row_fu(i))
  }

  // Print MAERI
  MAERI.printfile("IR/MAERI")
}
