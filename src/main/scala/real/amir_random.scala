package real

import dsl._
import scala.util.Random._
import scala.io.Source

object amir_random extends App{

  // Define the instruction list
  val fullinst = get_inst_list("b64.ssinst")
  val max_num_inst : Int = 16
  val max_num_node : Int = 128
  val lowest_fu_ratio : Int = 20
  val highest_fu_ratio : Int = 49

  // Define Default Switch
  val sw_default = new ssnode("switch")
  sw_default(
    "max_util",1)(
    "granularity",64)(
    "switch_mode", "full-control"
  )

  // Create a ssfabric
  val dev = new ssfabric
  dev("default_data_width", 64)(
    "default_granularity", 64)(
    "Default_max_util", 1)(
    "Defaultflow_control", false)

  val num_node  = 32 + nextInt(max_num_node - 32)
  var curr_num_node = 0
  while(curr_num_node <= num_node){
    // do we need a new fu?
    if(nextBoolean()){
      curr_num_node += 1
      // need at least two input one output

    }
    // do we need a new switch?
    if(nextBoolean()){
      curr_num_node += 1
      // need at least two input one output
    }
    // random connectivity

  }

  // Connect the Vector Port
  val in_vport = new ssnode("vector port")
  val out_vport = new ssnode("vector port")

  /*
  dev(in_vport)(in_vport |=> (first_row_switch union left_column_switch).distinct)(
    out_vport)(out_vport <=| (last_row_switch union right_column_switch).distinct)
  */

  // Print
  dev.printIR("IR/amir")

  def get_random_fu() : (ssnode, Seq[String]) = {
    val fu = new ssnode("function unit")
    val fu_insts = get_random_inst(fullinst, 1+scala.util.Random.nextInt(max_num_inst))
    fu("granularity", 64)(
      "num_register", 1)(
      "max_delay_fifo_depth", 8)(
      "instructions", fu_insts)
    (fu, fu_insts)
  }

  def get_inst_list(path:String) : Seq[String] = {
    val all_inst = Source.fromResource(path).getLines
      .map(_.trim).filter(line => {!line.startsWith("#") && line != ""}).toList
    all_inst.map(_.split("\\s+").head)
  }

  def get_random_inst(fullinst:Seq[String], num_inst: Int) : Seq[String] = {
    scala.util.Random.shuffle(fullinst.distinct).take(num_inst)
  }
}