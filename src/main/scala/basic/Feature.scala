package basic

import scala.collection.mutable.ListBuffer
import basic.Constant._

import scala.math.log

trait RegisterControlled extends Entity {
  Parameters += "index_config_register" -> PValue(-1)
  Parameters += "config_base" -> PValue(-1)
  Parameters += "config_bound" -> PValue(-1)
}

trait IsPort extends Entity {
  Parameters += "IO_Type" -> PValue("")
  Parameters += "hasValid" -> PValue(false)
  Parameters += "hasReady" -> PValue(false)
  Parameters += "function" -> PValue("") // data/control
}
trait WithWordWidth extends Entity {
  Parameters += "Word_Width" -> PValue(-1)
}

trait WithRegisterFile extends Entity {
  Parameters += "register_file_length" -> PValue(-1)
  Parameters += "register_file_width" -> PValue(-1)
  // Calculate config sec, basc and bound
  def calaulate_config_location(config_width:Int, control_width:Int, // range is control width
                                previous_sec:Int, previous_bound:Int) :(Int,Int,Int)= {
    var try_base = previous_bound + 1
    var try_bound = previous_bound + control_width
    var try_config_sec = previous_sec
    if (try_bound/config_width == 1){
      try_base = 0
      try_bound = try_base + control_width - 1
      try_config_sec += 1
    }else if (try_bound/config_width > 1){
      throw new Exception("Range cover two config registers")
    }
    (try_config_sec,try_bound,try_base)
  }
}

trait HasDecomposedPorts extends Entity {
  Parameters += "input_decomposer" -> PValue(List())
  Parameters += "output_decomposer" -> PValue(List())

  val decomposed_ports : ListBuffer[Port] = new ListBuffer[Port]()

  def get_subnet_port(io:String,port_index:Int,subnet:Int):Port={
    decomposed_ports
      .find(p=>p.io == io && p.get("Port_Index").asInstanceOf[Int] == port_index &&
        p.get("Sub_Net_Index").asInstanceOf[Int] == subnet).get
  }

  // Generate Decomposable Port
  def decompose_all_Ports:Unit={
    var temp_port: ListBuffer[Port] = new ListBuffer[Port]()
    val ori_input_ports:ListBuffer[Port] = Ports.filter(p=>p.io == INPUT_TYPE)
    val ori_output_ports:ListBuffer[Port] = Ports.filter(p=>p.io == OUTPUT_TYPE)
    val ori_control_ports:ListBuffer[Port] = Ports.filter(p=>p.io == MMIO_TYPE)
    val input_decomposer = get("input_decomposer").asInstanceOf[List[Int]]
    val output_decomposer = get("output_decomposer").asInstanceOf[List[Int]]
    val decompoed_input_ports = decompose_ports(ori_input_ports,input_decomposer)
    val decompoed_output_ports = decompose_ports(ori_output_ports,output_decomposer)
    decompoed_input_ports.foreach(temp_port += _)
    decompoed_output_ports.foreach(temp_port += _)
    ori_control_ports.foreach(temp_port += _)
    temp_port.foreach(decomposed_ports += _)
  }
  def decompose_ports(ports:ListBuffer[Port],decomp:List[Int]):ListBuffer[Port]={
    require(ports.length == decomp.length)
    val temp_ports: ListBuffer[Port] = new ListBuffer[Port]()
    for(i <- ports.indices){
      val temp_p = decompose_port(ports(i),decomp(i))
      temp_p.foreach(p=>{
        if(p.get("Port_Index") == None)
          p.have("Port_Index",i)
        temp_ports += p
      })
    }
    temp_ports
  }
  def decompose_port(p:Port,de:Int):ListBuffer[Port]={
    val temp_ports: ListBuffer[Port] = new ListBuffer[Port]()
    for (i <- 0 until de){
      val temp_port = p.copy(p.io,p.hasValid,p.hasReady)
      temp_port.copyInternalEntity(p)
      temp_port.have("Word_Width",p.get("Word_Width").asInstanceOf[Int]/de)
      temp_port.have("Sub_Net_Index",i)
      temp_port.have("Num_Sub_Net",de)
      temp_ports += temp_port
    }
    temp_ports
  }
  def port_subnet_match(is:Int,os:Int,nis:Int,nos:Int):Boolean={
    var index_more = is
    var index_less = os
    var num_more = nis
    var num_less = nos
    if (nis<nos){
      index_more = os
      index_less = is
      num_more = nos
      num_less = nis
    }
    index_less == (index_more >> (log(num_more/num_less)/log(2)).toInt)
  }
}