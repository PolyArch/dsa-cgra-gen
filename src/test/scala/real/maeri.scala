package real

import dsl._

object maeri extends App{
  identifier("depth")

  val start_sw = new ssnode("switch")
  val end_add = new ssnode("function unit")
  end_add("Insts","Add")

  // Create MAERI
  val MAERI = new ssfabric()

  // Create distribute and reduce Network
  val distribute_network = MAERI.buildTree(start_sw,4,true)
  val reduce_network = MAERI.buildTree(end_add,4,false)

  // Create MAERI
  MAERI(distribute_network)(reduce_network)

  // Change the last row function of reduce graph to Multiplication
  val last_row_fu = MAERI("nodeType","depth")("function unit",0)
  val last_row_switch = MAERI("nodeType","depth")("switch",0)
  last_row_fu.foreach(fu=>fu("Insts","Mul"))

  // Connect the distribute and reduce Network
  for (i <- last_row_fu.indices){
    MAERI(last_row_switch(i) --> last_row_fu(i))
  }

  // horizontal connection of the Last Row FU
  for (i <- 0 until last_row_fu.length -1){
    MAERI(last_row_fu(i) --> last_row_fu(i+1))
  }

  // Four intra-tree connection


  // Print MAERI
  MAERI.printfile("IR/maeri")
}
