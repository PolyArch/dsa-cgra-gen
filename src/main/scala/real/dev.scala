package real

import dsl._

object dev extends App{

  // Keys that differ nodes
  identifier("row_idx","col_idx")

  // Define Default Switch
  val sw_default = new ssnode("switch")
  sw_default(
    "max_util",1)(
    "granularity",16)(
    "subnet_offset", List(0, 1))(
    "switch_mode", "pell-control"
  )

  // Define Shared Decomposable Dynamic Switch
  val my_switch = new ssnode("switch")
  my_switch(
    "data_width", 64)(
    "granularity",16)(
    "subnet_offset", Seq(0, 1, 2))(
    "flow_control", true)(
    "max_util", 4)(
    "max_delay_fifo_depth", 4
  )

  // Define Your own Data-dependent Controlled
  // Processing Elements with GE / LE and Add
  val my_pe = new ssnode("processing element")
  my_pe(
    "instructions",Seq("SelfCtrlGE", "SelfCtrlLE", "InputCtrlAdd"))(
    "data_width", 64)(
    "granularity", 64)(
    "num_register", 8)(
    "max_util", 2)(
    "flow_control", 4)(
    "max_delay_fifo_depth", 4)

  // Define a Adding processing element
  val pe_add = new ssnode("processing element")
  pe_add(
    "instructions",Seq("Add", "Sub", "Mul"))(
    "granularity", 32)(
    "num_register", 1)(
    "max_delay_fifo_depth", 4)

  val pe_spc = new ssnode("processing element")
  pe_spc(
    "instructions",Seq("FAdd64", "FMul64"))(
    "num_register", 16)(
    "max_delay_fifo_depth", 2)(
    "flow_control", false)(
    "control_flow", "self-control"
  )

  val another_pe = pe_spc.clone()
  another_pe("instructions","Mul")(
    "num_register", 4)(
    "max_delay_fifo_depth", 4)

  // Create a Computing Fabric
  val dev = new ssfabric
  dev(
    "default_data_width", 64)(
    "default_granularity", 32)(
    "default_max_util", 1)(
    "default_flow_control", true)

  // Build Mesh Topology
  val switchMesh = dev.buildMesh(sw_default, row = 5, col = 5)

  // Heterogeneous datawidth
  for(row_idx <- 1 until 5; col_idx <- 0 until 5){
    if(row_idx + col_idx == 3){
      switchMesh(row_idx)(col_idx).apply("data_width",128)
    }
  }

  // Adding processing elements
  val peArray = Array(
    Array(pe_spc,pe_add,pe_add,pe_add),
    Array(pe_spc,pe_add,pe_add,pe_add),
    Array(pe_add,pe_add,pe_add,another_pe),
    Array(pe_add,pe_add,another_pe,pe_add)
  )
  for(row_idx <- 0 until 4;col_idx <- 0 until 4){
    val temp_node = peArray(row_idx)(col_idx).clone
    temp_node("row_idx",row_idx)("col_idx",col_idx)
    dev(
      dev(row_idx)(col_idx)("switch") -->  temp_node
    )(
      dev(row_idx+1)(col_idx)("switch") --> temp_node
    )(
      dev(row_idx)(col_idx+1)("switch") --> temp_node
    )(
      dev(row_idx+1)(col_idx+1)("switch") <-> temp_node
    )
  }

  // Specify the Input Node and Output Node (in Grid)
  val first_row_switch = dev.filter("row_idx","nodeType")(0,"switch")
  val last_row_switch = dev.filter("row_idx","nodeType")(4,"switch")
  val left_column_switch = dev.filter("col_idx","nodeType")(0,"switch")
  val right_column_switch = dev.filter("col_idx","nodeType")(4,"switch")

  // Make switches have different flow control
  right_column_switch.foreach(s=>s("flow_control", false)("switch_mode","group-by-port"))

  val third_row_switch = dev.filter("row_idx","nodeType")(2,"switch")
  third_row_switch.foreach(s=>s("max_util", 5)("switch_mode","group-by-port"))

  // Connect the Vector Port
  val in_vport = new ssnode("vector port")
  val second_in_vport = new ssnode ("vector port")
  val out_vport = new ssnode("vector port")


  in_vport --> first_row_switch.head
  in_vport --> first_row_switch(1)
  in_vport --> first_row_switch(2)
  in_vport --> first_row_switch(3)


  dev(
    in_vport)(in_vport |=> (first_row_switch union left_column_switch).distinct)(
    out_vport)(out_vport <=| (last_row_switch union right_column_switch).distinct)(
    second_in_vport)(second_in_vport |=> left_column_switch)

  // Change Properties of One Switch
  dev(1)(1)("switch")(
    "subnet_offset",List(0, 1, -2)
    )("granularity",8)

  // Add a extra link
  dev(
    dev(2)(3)("processing element") <->
      dev(1)(0)("switch")
  )(
    dev(2)(3)("processing element") <->
      dev(1)(0)("switch")
  )

  // Print JSON
  dev.printIR(filename = "IR/dev")
}