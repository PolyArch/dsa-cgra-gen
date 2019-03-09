package cgra.entity

import cgra.IO.IO_Interface.get_io
import cgra.IO.mmio_if
import cgra.config.Constant._
import cgra.fabric.common._
import chisel3.util.MixedVec
import chisel3._

import scala.collection.mutable.ListBuffer
import scala.math.log

// --------------   Hardware Design  --------------

trait RegisterControlled extends Entity {
  Parameters += "RegisterControlled" -> PValue(true)
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
trait WithControlRegisterFile extends Entity {
  Parameters += "register_file_length" -> PValue(-1)
  Parameters += "register_file_width" -> PValue(-1)
  // Calculate old.config sec, basc and bound
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
      throw new Exception("Range cover two old.config registers")
    }
    (try_config_sec,try_bound,try_base)
  }

  def arrange_register_config_bit = {
    // Arrange Register Control, Arrange the Register
    val All_Register_Controlled_Entities = Entities.filter(e=>e.get("RegisterControlled").asInstanceOf[Boolean])
    var pre_bound = -1;var pre_sec = 0
    val config_width = get("register_file_width").asInstanceOf[Int]
    val max_config_index = get("register_file_length").asInstanceOf[Int] - 1
    for (reg_con_module <- All_Register_Controlled_Entities){
      val range = reg_con_module.Ports.find(p=>p.get("function") == "control").getOrElse(
        throw new Exception("Forget to add old.config port in Mux")
      ).get("Word_Width").asInstanceOf[Int]
      val current_config_encode = calaulate_config_location(config_width,range,pre_sec,pre_bound)
      val curr_sec = current_config_encode._1;pre_sec = curr_sec
      val curr_bound = current_config_encode._2;pre_bound = curr_bound
      val curr_base = current_config_encode._3
      reg_con_module.Parameters("index_config_register").value = curr_sec
      reg_con_module.Parameters("config_base").value = curr_base
      reg_con_module.Parameters("config_bound").value = curr_bound
      pre_sec = curr_sec;pre_bound = curr_bound
      require(pre_sec <= max_config_index)
    }
  }

}
trait HasDecomposedPorts extends Entity {
  Parameters += "default_decomposer" -> PValue(1)
  Parameters += "input_decomposer" -> PValue(List())
  Parameters += "output_decomposer" -> PValue(List())
  var hasDecomposed : Boolean = false

  def get_subnet_port(io:String,port_index:Int,subnet:Int):Port={
    Ports.find(p=>p.io == io && p.get("Port_Index").asInstanceOf[Int] == port_index &&
        p.get("Sub_Net_Index").asInstanceOf[Int] == subnet).get
  }
  def get_subnet_port(io:String,port_dir:String,subnet:Int):Port={
    val port_index = Index_Direction_Map(port_dir).asInstanceOf[Int]
    Ports.find(p=>p.io == io && p.get("Port_Index").asInstanceOf[Int] == port_index &&
      p.get("Sub_Net_Index").asInstanceOf[Int] == subnet).get
  }

  // Generate Decomposable Port
  def decompose_all_Ports:Unit={
    var temp_port: ListBuffer[Port] = new ListBuffer[Port]()
    val ori_input_ports:ListBuffer[Port] = Ports.filter(p=>p.io == INPUT_TYPE)
    val ori_output_ports:ListBuffer[Port] = Ports.filter(p=>p.io == OUTPUT_TYPE)
    val input_decomposer = get("input_decomposer").asInstanceOf[List[Int]]
    val output_decomposer = get("output_decomposer").asInstanceOf[List[Int]]
    val decompoed_input_ports = decompose_ports(ori_input_ports,input_decomposer)
    val decompoed_output_ports = decompose_ports(ori_output_ports,output_decomposer)
    decompoed_input_ports.foreach(temp_port += _)
    decompoed_output_ports.foreach(temp_port += _)
    Ports --= ori_input_ports;Ports --= ori_output_ports
    Ports ++= decompoed_input_ports;Ports ++= decompoed_output_ports
    hasDecomposed = true
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
      temp_port.parent_type = p.parent_type
      temp_port.parent_id = p.parent_id
      temp_port.have("function",p.get("function"))
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
trait HasDirection extends Entity {
  val directionAssigned : Boolean = false
}
trait SolveMultiInputOneOutput extends Entity {
  // Add mux based on the same sink ports
  def solveMultiInputConflictwithMUX = {
    val all_ports = Ports.toList ::: Entities.flatMap(_.Ports).toList
    val multi_sources_sink_port_entity_id : List[Int]= {
      val sink_ports_id_unique = Relationships.map(_._2).distinct
      val sinks_port_id = Relationships.map(_._2)
      sink_ports_id_unique.filter(spi=>sinks_port_id.count(_==spi) > 1).toList
    }
    for (source_id <- multi_sources_sink_port_entity_id){
      val sink_port = all_ports.find(_.entity_id == source_id).get
      val all_entities_ports = Entities.map(_.Ports) :+ Ports
      val sink_port_index = all_entities_ports.find(P=>P.contains(sink_port)).get.indexOf(sink_port)
      val source_ports_id = Relationships.filter(_._2 == source_id).map(_._1)
      val source_ports = source_ports_id.map(i=>all_ports.zipWithIndex.find(p=>p._1.entity_id == i).get)
      val mux = Multiplexer();this have mux
      for (s <- source_ports){
        val temp_port:Port = Port(INPUT_TYPE,s._1.hasValid,s._1.hasReady)
        mux have temp_port
        have(s._1 --> temp_port,s._2 -> mux.Ports.indexOf(temp_port))
      }
      val temp_port = Port(OUTPUT_TYPE,sink_port.hasValid,sink_port.hasReady)
      mux have temp_port
      have (temp_port --> sink_port,mux.Ports.indexOf(temp_port) -> sink_port_index)
      mux forsyn
    }
  }

}

// --------------   Hardware Generation  --------------

class typical_module(p:Entity) extends Module {
  val io = IO(get_io(p.Ports))
  val register_file_width = p.get("register_file_width").asInstanceOf[Int]
  val register_file_length = p.get("register_file_length").asInstanceOf[Int]

  // --- Hardware ---
  val config_registers = Reg(Vec(register_file_length, UInt(register_file_width.W)))
  val ports = p.Ports

  // Internal Module
  val mux_type : String= Multiplexer().entity_type;val alu_type: String = Arithmetic_Logic_Unit().entity_type
  val delay_pipe_type : String= Delay_Pipe().entity_type
  val internal_modules :List[MixedVec[Data]]= p.Entities.map(e=>{
    e.entity_type match {
      case `mux_type` => Module(new Multiplexer_Hw(e)).io
      case `alu_type` => Module(new Arithmetic_Logic_Unit_Hw(e)).io
      case `delay_pipe_type` => Module(new Delay_Pipe_Hw(e)).io
    }
  }).toList

  // Connection
  for (r <- p.Relationships){
    val source_id = r._1
    val sink_id = r._2

    val source_port = p.Ports.find(p=>p.entity_id == source_id)
    val source_entity_index = p.Entities.zipWithIndex.find(e=>e._1.Ports.map(p=>p.entity_id).contains(source_id))
    val sink_port = p.Ports.find(p=>p.entity_id == sink_id)
    val sink_entity_index = p.Entities.zipWithIndex.find(e=>e._1.Ports.map(p=>p.entity_id).contains(sink_id))

    val source_io:Data = {
      if (source_port isEmpty){
        val source_entity = source_entity_index.get._1
        val source_module_index = source_entity_index.get._2
        val source_port_index = source_entity.Ports.zipWithIndex.find(p=>p._1.entity_id == source_id).get._2
        internal_modules(source_module_index)(source_port_index)
      }else{
        io(p.Ports.zipWithIndex.find(p=>p._1.entity_id == source_id).get._2)
      }
    }

    val sink_io:Data = {
      if (sink_port isEmpty){
        val sink_entity = sink_entity_index.get._1
        val sink_module_index = sink_entity_index.get._2
        val sink_port_index = sink_entity.Ports.zipWithIndex.find(p=>p._1.entity_id == sink_id).get._2
        internal_modules(sink_module_index)(sink_port_index)
      }else{
        io(p.Ports.zipWithIndex.find(p=>p._1.entity_id == sink_id).get._2)
      }
    }
    source_io <> sink_io
  }

  // Control
  for (ei <- p.Entities.indices){
    val config_port_index = p.Entities(ei).Ports.zipWithIndex.find(p=>p._1.get("function") == "control").get._2
    val config_sec = p.Entities(ei).get("index_config_register").asInstanceOf[Int]
    val config_base = p.Entities(ei).get("config_base").asInstanceOf[Int]
    val config_bound = p.Entities(ei).get("config_bound").asInstanceOf[Int]
    internal_modules(ei)(config_port_index) := config_registers(config_sec)(config_bound,config_base)
  }

  // Update Control Register
  val config_port_index = ports.zipWithIndex.find(p=>p._1.get("function") == "control").get._2
  val config_port = io(config_port_index).asInstanceOf[mmio_if]
  when(config_port.write_req){
    config_registers(config_port.write_index) := config_port.write_data
  }
  config_port.write_ack := true.B
  config_port.read_ack := false.B
  config_port.read_data := 0.U
}