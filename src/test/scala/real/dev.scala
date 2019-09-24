package real

import dsl._

object dev extends App{

  // Keys that differ nodes
  identifier.key = List("nodeType", "row_idx", "col_idx")

  // Define Default Switch
  val sw_default = new ssnode("switch")
  sw_default("share_slot_size",2)(
              "decompoer",2)

  // Define a Adding Function Unit
  val fu_add = new ssnode("function unit")
  fu_add("Insts","Add64")("decompoer", 2)

  val fu_spc = new ssnode("function unit")
  fu_spc("Insts",Set("Div16", "RShf4_16x4", "Abs16x4"))

  val another_fu = fu_spc.clone()
  another_fu("Insts",Set("Acc16", "Or16"))

  // Create a ssfabric
  val dev = new ssfabric

  // Build Mesh Topology
  val switchMesh = dev.buildMesh(sw_default, 5,5)

  // Build Grid from Text
  val fuMesh = dev.connectMesh(
    Array(
      Array(fu_add,fu_add,fu_spc,fu_add),
      Array(fu_spc,fu_add,fu_add,fu_add),
      Array(fu_add,fu_add,fu_add,another_fu),
      Array(fu_add,fu_add,another_fu,fu_add)
    )
  )

  // Specify the Input Node and Output Node (in Grid)
  val first_row_switch = dev("row_idx","nodeType")(0,"switch")
  val last_row_switch = dev("row_idx","nodeType")(3,"switch")
  val left_column_switch = dev("col_idx","nodeType")(0,"switch")
  val right_column_switch = dev("col_idx","nodeType")(3,"switch")

  // Connect the Vector Port
  val in_vport = new ssnode("vector port")
  val second_in_vport = new ssnode ("vector port")
  val out_vport = new ssnode("vector port")

  dev(
    in_vport)(in_vport |=> (first_row_switch union left_column_switch))(
    out_vport)(out_vport <=| (last_row_switch union right_column_switch))(
    second_in_vport)(second_in_vport |=> left_column_switch)

  // Change Properties of One Switch
  dev(1)(1)("switch")(
    "subnet_offset",List(0, -1, 2)
    )("decomposer",4)

  // Add a extra link
  dev(
    dev(2)(3)("function unit") <->
      dev(1)(0)("switch")
  )(
    dev(2)(3)("function unit") <->
      dev(1)(0)("switch")
  )

  // Print
  dev.printfile("IR/dev")
}