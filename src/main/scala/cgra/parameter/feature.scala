package cgra.parameter

import cgra.parameter.Constant._
import chisel3._
import chisel3.util.MixedVec
import scala.collection.mutable.Map

// FILE feature is for those

trait Module_Type_Params extends IsParameters{
  val module_type : String
  def get_module_type = module_type
}

trait DatapathParams extends IsParameters{
  def get_word_width = word_width
  def set_word_width (w:Int) = word_width = w
  var word_width : Int = -1
}

trait IOParams {
  // Basic Information which not really related to synthesize
  var default_decomposer = 1
  private var num_input   : Int = 0
  private var num_output  : Int = 0
  // Have synthesize meaning
  var input_ports_list : List[port_subnet] = Nil
  var output_ports_list : List[port_subnet] = Nil
  var input_word_width_decomposer   : List[Int] = Nil
  var output_word_width_decomposer  : List[Int] = Nil

  // Get information of port
  def get_num_input = num_input
  def get_num_output = num_output
  def select_port_by_port(i:Int)={
    (select_input_port_by_port(i),select_output_port_by_port(i))
  }
  def select_input_port_by_port(i:Int) = {
    input_ports_list.filter(_.port==i)
  }
  def select_output_port_by_port(i:Int) = {
    output_ports_list.filter(_.port==i)
  }

  // Port increment
  def add_output_port: Int = add_output_port(default_decomposer)
  def add_output_port(dd:List[Int]):Unit = for(d <- dd) add_output_port(d)
  def add_output_port(d:Int) :Int ={
    for (dd <- 0 until d)
      output_ports_list = output_ports_list ::: List(new port_subnet(OUTPUT_TYPE,num_output,dd,d))
    add_output_decomposer(d)
    num_output += 1
    num_output - 1
  }// return index

  def add_input_port : Int = add_input_port(default_decomposer)
  def add_input_port(dd:List[Int]):Unit = for (d <- dd) add_input_port(d)
  def add_input_port(d:Int) :Int ={
    for (dd <- 0 until d)
      input_ports_list = input_ports_list ::: List(new port_subnet(INPUT_TYPE,num_input,dd,d))
    add_input_decomposer(d)
    num_input += 1
    num_input - 1
  }// return index

  // decrement operation
  def delete_output_port(port_index:Int) : Int = {
    output_ports_list = output_ports_list.filter(x=>x.io == OUTPUT_TYPE && x.port != port_index)
    num_output -= 1
    num_output
  }// return num_output
  def delete_input_port(port_index:Int) : Int = {
    input_ports_list = input_ports_list.filter(x=>x.io == INPUT_TYPE && x.port != port_index)
    num_input -= 1
    num_input
  }
  def add_input_decomposer(d:Int) =
    input_word_width_decomposer = input_word_width_decomposer ::: List(d)
  def add_output_decomposer(d:Int)=
    output_word_width_decomposer = output_word_width_decomposer ::: List(d)

  // Change the port
  def change_input_decomposer(d:Int,i:Int) =
    input_word_width_decomposer = input_word_width_decomposer.updated(i,d)
  def change_output_decomposer(d:Int,i:Int) =
    output_word_width_decomposer = output_word_width_decomposer.updated(i,d)
  private def change_num_input(x:Int) =num_input = x
  private def change_num_output(x:Int)=num_output = x
  def has_ports(n:Int):Unit = {
    has_ports(n,default_decomposer)
  }
  def has_ports(n:Int,num_subnet:Int):Unit= {
    has_inputs(n,num_subnet)
    has_outputs(n,num_subnet)
  }
  def has_inputs(n:Int):Unit = has_inputs(n,default_decomposer)
  def has_inputs(n:Int, d:Int):Unit = {
    change_num_input(n)
    var temp_list : List[port_subnet] = Nil
    for (i <- 0 until n){
      for (dd <- 0 until d)
        temp_list = temp_list ::: List(new port_subnet(INPUT_TYPE,i,dd,d))
      add_input_decomposer(d)
    }
    input_ports_list = temp_list
  }
  def has_outputs(n:Int) :Unit= has_outputs(n,default_decomposer)
  def has_outputs(n:Int,d:Int):Unit = {
    change_num_output(n)
    var temp_list : List[port_subnet] = Nil
    for (i <- 0 until n){
      for (dd <- 0 until d)
        temp_list = temp_list ::: List(new port_subnet(OUTPUT_TYPE,i,dd,d))
      add_output_decomposer(d)
    }
    output_ports_list = temp_list
  }

  // Port Alias
  var get_Direction_by_Port :Map[Int,String] = Map[Int,String]()
  var get_Port_by_Direction :Map[String,Int] = get_Direction_by_Port.map(x=>x._2->x._1)
  val default_Port_Direction :Map[Int,String] = Map(0 -> "North", 1 -> "East", 2 -> "South", 3 -> "West",
    4 -> "NorthEast",5 -> "SouthEast",6 -> "NorthWest",7->"SouthWest")
  def use_default_direction_alias = {get_Direction_by_Port = default_Port_Direction;update_alias}
  private def update_alias = get_Port_by_Direction = get_Direction_by_Port.map(x=>x._2->x._1)

  // Decomposer subnet calculation
  def subnet_match(more_index:Int,more_num_subnet:Int,
                   less_num_subnet:Int) : Int = {//return less index
    more_index / (more_num_subnet / less_num_subnet)
  }
  def subnet_match (more_index:Int,less_index:Int,more_num_subnet:Int,less_num_subnet:Int):Boolean={
    more_index == less_index * (more_num_subnet/less_num_subnet)
  }
  def subnet_match_less(less_index:Int,less_num_subnet:Int,more_num_subnet:Int):List[Int] = {
    ((less_index * more_num_subnet / less_num_subnet) until ((less_index+1) * more_num_subnet / less_num_subnet)).toList
  }
}