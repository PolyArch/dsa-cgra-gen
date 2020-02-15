package real

import dsl._
import cgra.config.fullinst._

object dse_init extends App{

  val switch = new ssnode("switch")

  val fu = new ssnode("function unit")
  fu("max_delay", 15)

  val vp = new ssnode("vector port")

  val dse_init = new ssfabric
  dse_init.apply("name", "dse_init")

  dse_init(
    "default_data_width", 64)(
    "default_flow_control", false)(
    "default_granularity", 64)(
    "default_max_util", 1)

  var is_input = 0
  for(ssinst <- ssinst_conf){
    val temp_fu = fu.clone()
    val temp_vp = vp.clone()
    temp_fu("instructions", ssinst.head)
    dse_init(temp_fu <-> switch)
    if(is_input % 2 == 0){
      dse_init(temp_vp --> switch)
    }else{
      dse_init(temp_vp <-- switch)
    }
    is_input = is_input + 1
  }

  dse_init.printfile("IR/dse_init")

}
