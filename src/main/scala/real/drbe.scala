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
    "max_util", 1
  )(
    "granularity",64
  )(
    "switch_mode", "full-control"
  )

  // Define a Adding Function Unit
  val ppu = new ssnode("function unit")
  ppu(
    "instructions", List("Object", "Body")
  )(
    "fu count", List(80, 20)
  )(
    "granularity", 64
  )(
    "num_register", 1
  )(
    "max_delay_fifo_depth", 128
  )

  val pe_mesh = Array.ofDim[ssnode](nrc, ntx)
  for (i <- 0 until nrc; j <- 0 until ntx) {
    pe_mesh(i)(j) = ppu.clone()
  }

  val iports = Array.ofDim[ssnode](ntx)
  for (i <- 0 until ntx) {
    iports(i) = new ssnode("vector port")
  }

  val oports = Array.ofDim[ssnode](nrc)
  for (i <- 0 until nrc) {
    oports(i) = new ssnode("vector port")
  }

  val agg = new ssnode("function unit")
  agg(
    "instructions", List("Aggregate")
  )(
    "fu count", List(1)
  )(
    "granularity", 64
  )(
    "num_register", 1
  )(
    "max_delay_fifo_depth", 16
  )

  val dev = new ssfabric
  dev(
    "default_data_width", 64
  )(
    "default_flow_control", false
  )(
    "default_granularity", 64
  )(
    "default_max_util", 1
  )
  val sw_mesh = dev.buildMesh(sw, ntx, nrc)

  for (i <- 0 until ntx) {
    for (j <- 0 until nrc) {
      val tmp = agg.clone
      for (k <- 0 until 32) {
        dev(dev(i)(j)("switch") <-> tmp)
        dev(pe_mesh(j)(i) <-> dev(i)(j)("switch"))
      }
      dev(iports(i) |=> Seq(pe_mesh(j)(i)))
      dev(oports(j) <=| Seq(pe_mesh(j)(i)))
    }
    println(i)
  }

  dev.printIR(s"IR/drbe-${ntx}-${nrc}", "json")
}
