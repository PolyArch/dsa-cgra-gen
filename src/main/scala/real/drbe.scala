package real

import dsl._

object drbe extends App {
  // Keys that differ nodes
  identifier("row_idx","col_idx")

  // Define Default Switch
  val sw_default = new ssnode("switch")
  sw_default("max_util",1)("granularity",64)("switch_mode", "full-control")

  // Define a Adding Function Unit
  val fu_full = new ssnode("function unit")
  fu_full("instructions","PPU")("granularity", 64)("num_register", 1)("max_delay_fifo_depth", 16)


  // Build Mesh Topology
  for(num_row <- 4 to 32 by 2; num_col <- 4 to num_row by 2){
    // Create a ssfabric
    val dev = new ssfabric
    dev("default_data_width", 64)(
      "default_granularity", 64)(
      "Default_max_util", 1)(
      "Defaultflow_control", false)
    // Build switch mesh
    val switchMesh = dev.buildMesh(sw_default, num_row,num_col)
    // connect fu
    for(row_idx <- 0 until num_row - 1;col_idx <- 0 until num_col - 1){
      val curr_fu = fu_full.clone
      curr_fu("row_idx",row_idx)("col_idx",col_idx)
      dev(
        dev(row_idx)(col_idx)("switch") <-> curr_fu
      )(
        dev(row_idx+1)(col_idx)("switch") <-> curr_fu
      )(
        dev(row_idx)(col_idx+1)("switch") <-> curr_fu
      )(
        dev(row_idx+1)(col_idx+1)("switch") <-> curr_fu
      )
    }
    // pick switch at edge
    val first_row_switch = switchMesh.head
    val first_col_switch = switchMesh.map(_.head)
    val last_row_switch = switchMesh.last
    val last_col_switch = switchMesh.map(_.last)

    // Connect the Vector Port at the edge
    for(idx <- 0 until 4){
      val in_vport = new ssnode("vector port")
      val out_vport = new ssnode("vector port")
      val edge_switches = idx match{
        case 0 => first_row_switch
        case 1 => first_col_switch
        case 2 => last_row_switch
        case 3 => last_col_switch
      }
      dev(in_vport)(in_vport |=> edge_switches.distinct)(
        out_vport)(out_vport <=| edge_switches.distinct)
    }

    // Print
    dev.printIR(s"IR/drbe/drbe_row${num_row}_col$num_col","json")
  }
}
