package real

import dsl._

object config_path extends App{
  val num_row = args(0).toInt
  val num_col = args(1).toInt


  // Identifier
  identifier("row_idx", "col_idx")

  // Define Default Switch
  val sw_default = new ssnode("switch")
  sw_default("granularity",64)("switch_mode", "full-control")

  // Define a Add Sub Function Unit
  val fu_default = new ssnode("function unit")
  fu_default("instructions",List("Add64", "Sub64"))(
    "granularity", 64)("max_delay_fifo_depth", 2)

  // Define Fabric
  val config_path_network = new ssfabric
  config_path_network("default_data_width", 64)(
    "default_flow_control", false)(
    "default_granularity", 64)(
    "default_max_util", 1)

  // Build Topology
  val switchMesh = config_path_network.buildMesh(sw_default, num_row,num_col)

  // Add the function unit
  for(row_idx <- 0 until num_row-1;col_idx <- 0 until num_col-1){
    val temp_node = fu_default.clone
    temp_node("row_idx",row_idx)("col_idx",col_idx)
    config_path_network(
      config_path_network(row_idx)(col_idx)("switch") --> temp_node
    )(
      config_path_network(row_idx+1)(col_idx)("switch") --> temp_node
    )(
      config_path_network(row_idx)(col_idx+1)("switch") --> temp_node
    )(
      config_path_network(row_idx+1)(col_idx+1)("switch") <-- temp_node
    )
  }

  // Connect the Vector port
  val in_vport = new ssnode("vector port")
  val out_vport = new ssnode("vector port")

  // Connect IO
  val fisrt_row_sw = config_path_network.filter("row_idx","nodeType")(0,"switch")
  config_path_network(in_vport |=> fisrt_row_sw)
  val last_row_sw = config_path_network.filter("row_idx","nodeType")(num_row - 1,"switch")
  config_path_network(out_vport <=| last_row_sw)

  // Print
  config_path_network.printfile("IR/config_net" +
    "_row_" + num_row + "_col_" + num_col)
}

class config_path(num_row:Int, num_col: Int){
  // Identifier
  identifier("row_idx", "col_idx")

  // Define Default Switch
  val sw_default = new ssnode("switch")
  sw_default("granularity",64)("switch_mode", "full-control")

  // Define a Add Sub Function Unit
  val fu_default = new ssnode("function unit")
  fu_default("instructions",List("Add64", "Sub64"))(
    "granularity", 64)("max_delay_fifo_depth", 2)

  // Define Fabric
  val config_path_network = new ssfabric
  config_path_network("default_data_width", 64)(
    "default_flow_control", false)(
    "default_granularity", 64)(
    "default_max_util", 1)

  // Build Topology
  val switchMesh = config_path_network.buildMesh(sw_default, num_row,num_col)

  // Add the function unit
  for(row_idx <- 0 until num_row-1;col_idx <- 0 until num_col-1){
    val temp_node = fu_default.clone
    temp_node("row_idx",row_idx)("col_idx",col_idx)
    config_path_network(
      config_path_network(row_idx)(col_idx)("switch") --> temp_node
    )(
      config_path_network(row_idx+1)(col_idx)("switch") --> temp_node
    )(
      config_path_network(row_idx)(col_idx+1)("switch") --> temp_node
    )(
      config_path_network(row_idx+1)(col_idx+1)("switch") <-- temp_node
    )
  }

  // Connect the Vector port
  val in_vport = new ssnode("vector port")
  val out_vport = new ssnode("vector port")

  // Connect IO
  val fisrt_row_sw = config_path_network.filter("row_idx","nodeType")(0,"switch")
  config_path_network(in_vport |=> fisrt_row_sw)
  val last_row_sw = config_path_network.filter("row_idx","nodeType")(num_row - 1,"switch")
  config_path_network(out_vport <=| last_row_sw)

  // Print
  val filename = "IR/config_net" +
    "_row_" + num_row + "_col_" + num_col
  config_path_network.printfile(filename)


}