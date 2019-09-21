package dsl.real

import dsl._

object hello extends App{
  // Define Default Switch
  val sw_default = new ssnode("switch")
  sw_default( ("share_slot_size", 2),
    ("decompoer",       4),
    ("TestProp1",       List(1,2,1,3,5)),
    ("TestProp2",       Set("Hello","World", 123)))

  // Define a Adding Function Unit
  val fu_add = new ssnode("function unit")
  fu_add("Insts","Add64")

  val fu_spc = new ssnode("function unit")
  fu_spc("Insts",Set("Div16", "RShf4_16x4", "Abs16x4"))

  val another_fu = fu_spc.clone()
  another_fu("Insts",Set("Acc16", "Or16"))

  // Create a ssfabric
  val cgra = new ssfabric

  // Build Mesh Topology
  cgra.formMesh(fu_add, sw_default, 4,4)

  // Build Grid from Text
  cgra.formMeshfromText(
    Array(
      Array(fu_add,fu_add,fu_spc,fu_add),
      Array(fu_spc,fu_add,fu_add,fu_add),
      Array(fu_add,fu_add,fu_add,another_fu),
      Array(fu_add,fu_add,another_fu,fu_add)
    ), sw_default
  )

  // Specify the Input Node and Output Node (in Grid)
  val first_row_switch = cgra("row_idx","nodeType")(0,"switch")
  val last_row_switch = cgra("row_idx","nodeType")(3,"switch")
  val left_column_switch = cgra("col_idx","nodeType")(0,"switch")
  val right_column_switch = cgra("col_idx","nodeType")(3,"switch")

  // Connect the Vector Port
  val in_vport = new ssnode("vector port")
  val second_in_vport = new ssnode ("vector port")
  val out_vport = new ssnode("vector port")

  cgra(
    in_vport)(in_vport |=> (first_row_switch union left_column_switch))(
    out_vport)(out_vport <=| (last_row_switch union right_column_switch))(
    second_in_vport)(second_in_vport |=> left_column_switch)

  // Change Properties of One Switch
  cgra(1)(1)("switch")(
    "inter_subnet_connection",
      Array(
        Array(true, true, false, false),
        Array(false, false, true, true)
      )
    )

  // Add a extra link
  cgra(
    cgra(2)(3)("function unit") <->
      cgra(1)(0)("switch")
  )(
    cgra(2)(3)("function unit") <->
      cgra(1)(0)("switch")
  )

  // Print
  cgra.printfile("IR/hello")
}