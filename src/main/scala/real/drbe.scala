package real

import dsl._

object drbe extends App {
  // Keys that differ nodes
  identifier("row_idx","col_idx")

  val ntx = drbe.args(0).toInt
  val nrc = drbe.args(1).toInt

  // Define Default Switch
  val sw = new ssnode("switch")
  sw(
    "max_util", 32
  )(
    "granularity",64
  )(
    "switch_mode", "full-control"
  )

  // Define a Adding Function Unit
  val ppu = new ssnode("function unit")
  ppu(
    "instructions", List("Object", "Body", "Aggregate")
  )(
    "fu count", List(660, 220, 40)
  )(
    "granularity", 64
  )(
    "num_register", 1
  )(
    "max_delay_fifo_depth", 65536
  )

  val ppu_agg_mesh = Array.ofDim[ssnode](nrc, ntx)
  for (i <- 0 until nrc; j <- 0 until ntx) {
    val temp_ppu = ppu.clone()
    temp_ppu("row_idx",i)("col_idx",j)
    ppu_agg_mesh(i)(j) = temp_ppu
  }

  val iports = Array.ofDim[ssnode](ntx)
  for (i <- 0 until ntx) {
    iports(i) = new ssnode("vector port")
  }

  val oports = Array.ofDim[ssnode](nrc)
  for (i <- 0 until nrc) {
    oports(i) = new ssnode("vector port")
  }

  val dev = new ssfabric
  dev(
    "default_data_width", 64
  )(
    "default_flow_control", false
  )(
    "default_granularity", 64
  )(
    "default_max_util", 32
  )
  val sw_mesh = dev.buildMesh(sw, nrc, ntx)

  for (i <- 0 until ntx) {
    for (j <- 0 until nrc) {
      dev(ppu_agg_mesh(j)(i) <-> dev(i)(j)("switch"))
    }
    println(i)
  }

  // Connect Inport[col] to this column PE
  for(i <- 0 until ntx){
    val iport : ssnode = iports(i)
    val this_col_pe : Seq[ssnode] = dev.filter("col_idx","nodeType")(i,"function unit")
    dev(iport)(iport |=> this_col_pe)
  }

  // Connect the left most switch to output port
  for(j <- 0 until nrc){
    val oport : ssnode = oports(j)
    val left_most_sw : ssnode = dev(0)(j)("switch")
    dev(oport)(left_most_sw --> oport)
  }


  dev.printIR(s"IR/drbe-${ntx}-${nrc}", "json")
}
