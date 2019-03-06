package cgra.fabric

import chisel3._
import chisel3.util._
import cgra.IO.IO_Interface._
import cgra.IO.mmio_if
import cgra.fabric.common._
import cgra.config.Constant._
import cgra.entity._

import scala.collection.mutable._

case class Router() extends Entity
  with WithRegisterFile
  with HasDecomposedPorts
  with WithWordWidth{
  entity_type = this.getClass.getName

  def forsyn:Unit = {
    val num_input = get("num_input").asInstanceOf[Int]
    val num_output = get("num_output").asInstanceOf[Int]

    // Change Input Output Capability to Mux
    for (o <- 0 until num_output){
      val sink_ports = Ports.filter(p=>p.io == OUTPUT_TYPE &&
        p.get("Port_Index").asInstanceOf[Int] == o)
      for (sink_port <- sink_ports){
        val sink_port_id = sink_port.entity_id
        val sources_port_id = Relationships.filter(r=>r._2 == sink_port_id).map(_._1)
        val source_ports:ListBuffer[Port] = sources_port_id
          .map(i=>Ports.find(p=>p.entity_id == i).get)
        val num_source_port = source_ports.length
        val mux = Multiplexer()
        this have mux
        for (s <- source_ports){
          val temp_port = Port(INPUT_TYPE,true,true)
          temp_port.have("Word_Width",s.get("Word_Width").asInstanceOf[Int])
          mux.Ports += temp_port
          mux.Sources += s.entity_id -> -1
        }
        val temp_port = Port(OUTPUT_TYPE,true,true)
        temp_port.have("Word_Width",sink_port.get("Word_Width").asInstanceOf[Int])
        mux.Ports += temp_port
        //sources_port_id.foreach(s_id=>{mux.Sources += s_id -> -1})
        mux.Sinks += sink_port_id -> 0
        mux.forsyn
        internal_entity_id_counter = mux.assign_entity_id(internal_entity_id_counter)
        val mux_input_data_port = mux.Ports.filter(p=>p.io == INPUT_TYPE && p.get("function") == "data")
        val mux_output_data_port = mux.Ports.filter(p=>p.io == OUTPUT_TYPE && p.get("function") == "data")
        for (s <- 0 until num_source_port){
          mux.Sources(sources_port_id(s)) = mux_input_data_port(s).get("Index").asInstanceOf[Int]
          Relationships -= sources_port_id(s)->sink_port_id
          Relationships += sources_port_id(s)->mux_input_data_port(s).entity_id
        }
        Relationships += mux_output_data_port.head.entity_id -> sink_port_id
      }
    }

    // Arrange the Register
    val muxes = Entities.filter(e=>e.get("RegisterControlled").asInstanceOf[Boolean]);var pre_bound = -1;var pre_sec = 0
    val config_width = get("register_file_width").asInstanceOf[Int]
    val mux_config_sec = get("register_file_length").asInstanceOf[Int] - 1
    for (mux <- muxes){
      val range = mux.Ports.find(p=>p.get("function") == "control").getOrElse(
        throw new Exception("Forget to add old.config port in Mux")
      ).get("Word_Width").asInstanceOf[Int]
      val current_config_encode = calaulate_config_location(config_width,range,pre_sec,pre_bound)
      val curr_sec = current_config_encode._1;pre_sec = curr_sec
      val curr_bound = current_config_encode._2;pre_bound = curr_bound
      val curr_base = current_config_encode._3
      mux.Parameters("index_config_register").value = curr_sec
      mux.Parameters("config_base").value = curr_base
      mux.Parameters("config_bound").value = curr_bound
      pre_sec = curr_sec;pre_bound = curr_bound
      require(pre_sec <= mux_config_sec)
    }
  }
}

class Router_Hw(p:Entity) extends Module {
  val io = IO(get_io(p.Ports))
  val register_file_width = p.get("register_file_width").asInstanceOf[Int]
  val register_file_length = p.get("register_file_length").asInstanceOf[Int]

  // --- Hardware ---
  val config_registers = Reg(Vec(register_file_length, UInt(register_file_width.W)))
  val ports = p.Ports

  // --- Mux ---
  val muxes = p.Entities
  for (mux <- muxes){
    // Connect Mux
    val sources = mux.Sources
    val sinks = mux.Sinks.head
    val mux_hw = Module(new Multiplexer_Hw(mux)).io
    for (s <- sources){
      val source_port_id = s._1
      val mux_port_index = s._2
      val source_port_index = ports.find(p=>p.entity_id == source_port_id).get.get("Index").asInstanceOf[Int]
      io(source_port_index) <> mux_hw(mux_port_index)
    }
    val sink_port_index = ports.find(p=>p.entity_id == sinks._1).get.get("Index").asInstanceOf[Int]
    val mux_sink_index = sinks._2
    io(sink_port_index) <> mux_hw(mux_sink_index)

    // Connect Mux Config Port
    val mux_config_port_index = mux.Ports.find(p=>p.get("function") == "control").get.get("Index").asInstanceOf[Int]
    val mux_config_sec = mux.get("index_config_register").asInstanceOf[Int]
    val mux_base = mux.get("config_base").asInstanceOf[Int]
    val mux_bound = mux.get("config_bound").asInstanceOf[Int]
    mux_hw(mux_config_port_index) := config_registers(mux_config_sec)(mux_bound,mux_base)
  }

  val config_port_index = ports.find(p=>p.get("function") == "control").get.get("Index").asInstanceOf[Int]
  val config_port = io(config_port_index).asInstanceOf[mmio_if]
  when(config_port.write_req){
    config_registers(config_port.write_index) := config_port.write_data
  }
  config_port.write_ack := true.B
  config_port.read_ack := false.B
  config_port.read_data := 0.U
}