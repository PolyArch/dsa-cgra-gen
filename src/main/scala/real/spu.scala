package real

import dsl._

object spu extends App{
  // Keys that differ nodes
  identifier("row_idx","col_idx")

  // Define Default Switch
  val sw_default = new ssnode("switch")
  sw_default(
    "subnet_offset", List(0, 1))(
    "switch_mode", "group-by-port")

  // Define General Function Unit
  val fu_general = new ssnode("function unit")
  fu_general(
    "instructions", List("Add", "Sub", "Mul", "Div", "FAdd64", "FMul64"))(
    "max_delay_fifo_depth", 4)

  // Define SPU
  val spu = new ssfabric
  spu("default_data_width", 64)(
    "default_flow_control", true)(
    "default_granularity", 8)(
    "default_max_util", 1)

  // Build Topology
  val switchMesh = spu.buildMesh(sw_default, 6,5)

  // Add the function unit
  for(row_idx <- 0 until 5;col_idx <- 0 until 4){
    val temp_node = fu_general.clone
    temp_node("row_idx",row_idx)("col_idx",col_idx)
    spu(
      spu(row_idx)(col_idx)("switch") --> temp_node
    )(
      spu(row_idx+1)(col_idx)("switch") --> temp_node
    )(
      spu(row_idx)(col_idx+1)("switch") --> temp_node
    )(
      spu(row_idx+1)(col_idx+1)("switch") <-> temp_node
    )
  }

  // Connect the Vector port
  val in_vport = new ssnode("vector port")
  val out_vport = new ssnode("vector port")

  // Connect IO
  spu(in_vport |=> spu.filter("row_idx","nodeType")(0,"switch"))
  spu(out_vport <=| spu.filter("row_idx","nodeType")(5,"switch"))

  // Print
  spu.printfile("IR/spu")

}
