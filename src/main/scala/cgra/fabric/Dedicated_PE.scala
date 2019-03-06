package cgra.fabric

import cgra.entity._
import chisel3._
import chisel3.util._
import cgra.IO.IO_Interface._
import cgra.IO.mmio_if
import cgra.fabric.common._
import cgra.config.Constant._

case class Dedicated_PE() extends Entity
  with WithRegisterFile
  with HasDecomposedPorts
  with WithWordWidth {
  entity_type = this.getClass.getName

  def forsyn :Unit = {
    // Find all delay pipe
    val delay_pipes = Entities.filter(p=>p.entity_type == Delay_Pipe().entity_type)
    for (delayP <- delay_pipes){
      val dp_in_port = delayP.Ports.find(p=>p.io == INPUT_TYPE && p.get("function") == "data").get
      val source_ports_id = Relationships.filter(_._2 == dp_in_port.entity_id).map(_._1)
      val source_ports = source_ports_id.map(i=>Ports.find(_.entity_id == i).get)
      val mux = Multiplexer()
      this have mux
      for (s <- source_ports){
        val temp_port = Port(INPUT_TYPE,false,false)
        temp_port.have("Word_Width",s.get("Word_Width").asInstanceOf[Int])
        mux.Ports += temp_port
        mux.Sources += s.entity_id -> -1
      }
      val temp_port = Port(OUTPUT_TYPE,false,false)
      temp_port.have("Word_Width",dp_in_port.get("Word_Width").asInstanceOf[Int])
      mux.Ports += temp_port
      mux.Sinks += dp_in_port.entity_id -> 0
      mux.forsyn
      internal_entity_id_counter = mux.assign_entity_id(internal_entity_id_counter)
      val mux_input_data_port = mux.Ports.filter(p=>p.io == INPUT_TYPE && p.get("function") == "data")
      val mux_output_data_port = mux.Ports.filter(p=>p.io == OUTPUT_TYPE && p.get("function") == "data")
      for (s <- 0 until source_ports.length){
        mux.Sources(source_ports_id(s)) = mux_input_data_port(s).get("Index").asInstanceOf[Int]
        Relationships -= source_ports_id(s)->dp_in_port.entity_id
        Relationships += source_ports_id(s)->mux_input_data_port(s).entity_id
      }
      Relationships += mux_output_data_port.head.entity_id -> dp_in_port.entity_id
    }

    // Arrange Register Control
    // Arrange the Register
    val All_Register_Controlled_Entities = Entities.filter(e=>e.get("RegisterControlled").asInstanceOf[Boolean])
    var pre_bound = -1;var pre_sec = 0
    val config_width = get("register_file_width").asInstanceOf[Int]
    val mux_config_sec = get("register_file_length").asInstanceOf[Int] - 1
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
      require(pre_sec <= mux_config_sec)
    }
  }
}

class Dedicated_PE_Hw(p:Entity) extends Module {
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
        val source_port_index = source_entity.Ports.find(p=>p.entity_id == source_id).get.get("Index").asInstanceOf[Int]
        internal_modules(source_module_index)(source_port_index)
      }else{
        io(p.Ports.find(p=>p.entity_id == source_id).get.get("Index").asInstanceOf[Int])
      }
    }

    val sink_io:Data = {
      if (sink_port isEmpty){
        val sink_entity = sink_entity_index.get._1
        val sink_module_index = sink_entity_index.get._2
        val sink_port_index = sink_entity.Ports.find(p=>p.entity_id == sink_id).get.get("Index").asInstanceOf[Int]
        internal_modules(sink_module_index)(sink_port_index)
      }else{
        io(p.Ports.find(p=>p.entity_id == sink_id).get.get("Index").asInstanceOf[Int])
      }
    }
    source_io <> sink_io
  }

  // Control
  for (ei <- p.Entities.indices){
    val config_port_index = p.Entities(ei).Ports.find(p=>p.get("function") == "control").get.get("Index").asInstanceOf[Int]
    val config_sec = p.Entities(ei).get("index_config_register").asInstanceOf[Int]
    val config_base = p.Entities(ei).get("config_base").asInstanceOf[Int]
    val config_bound = p.Entities(ei).get("config_bound").asInstanceOf[Int]
    internal_modules(ei)(config_port_index) := config_registers(config_sec)(config_bound,config_base)
  }

  // Update Control Register
  val config_port_index = ports.find(p=>p.get("function") == "control").get.get("Index").asInstanceOf[Int]
  val config_port = io(config_port_index).asInstanceOf[mmio_if]
  when(config_port.write_req){
    config_registers(config_port.write_index) := config_port.write_data
  }
  config_port.write_ack := true.B
  config_port.read_ack := false.B
  config_port.read_data := 0.U

}