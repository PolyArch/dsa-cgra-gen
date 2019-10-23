package real

import dsl._

object maeri extends App{
  identifier("depth")

  val root_sw = new ssnode("switch")
  root_sw("max_util",1)("subnet_offset", List(0,1))("granularity",8)
  val root_fu = new ssnode("function unit")
  root_fu("max_util",1)(
    "instructions","Add")(
    "num_register", 1)(
    "max_delay_fifo_depth", 2)

  // Create MAERI
  val MAERI = new ssfabric()
  MAERI("default_data_width", 64)(
    "default_flow_control", true
  )

  // Create distribute and reduce Network
  val distribute_network = MAERI.buildTree(root_sw,4,true)
  val reduce_network = MAERI.buildTree(root_fu,4,false)

  // Create MAERI
  MAERI(distribute_network)(reduce_network)

  // TODO: Assign Different Data Width
  /*
  for (depth <- 0 until 5){
    val nodes = MAERI("depth")(depth)
    nodes.foreach(node => node("data_width", (8 * Math.pow(2,depth)).toInt))
  }
   */

  // Change the last row function of reduce graph to Multiplication
  val last_row_fu = MAERI("nodeType","depth")("function unit",0)
  val last_row_switch = MAERI("nodeType","depth")("switch",0)
  last_row_fu.foreach(fu=>fu("instructions","Mul"))

  // Connect the distribute and reduce Network
  for (i <- last_row_fu.indices){
    MAERI(last_row_switch(i) --> last_row_fu(i))
  }

  // Connect to the Vector port
  val input_port = new ssnode("vector port")
  val output_port = new ssnode("vector port")
  MAERI(
    input_port --> root_sw)(
    root_fu --> output_port
  )

  // horizontal connection of the Last Row FU
  for (i <- 0 until last_row_fu.length -1){
    MAERI(last_row_fu(i) --> last_row_fu(i+1))
  }

  // TODO: Four intra-tree connection


  // Print MAERI
  MAERI.printfile("IR/maeri")
}
