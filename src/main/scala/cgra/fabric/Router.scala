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
  with WithControlRegisterFile
  with SolveMultiInputOneOutput
  with HasDecomposedPorts
  with WithWordWidth
  with HasDirection {
  entity_type = this.getClass.getName

  def forsyn:Unit = {
    // Add Control Port
    val control_port = Port(MMIO_TYPE,false,false)
    control_port have ("function","control")
    control_port have ("Index_Width",get("config_index_width"))
    control_port have ("Word_Width",get("config_word_width"))
    have(control_port)

    // Get num of input and output
    val num_input = get("num_input").asInstanceOf[Int]
    val num_output = get("num_output").asInstanceOf[Int]
    val default_decomposer = get("default_decomposer").asInstanceOf[Int]

    // If decomposer is not defined
    if(get("input_decomposer") == None) have("input_decomposer",List.fill[Int](num_input)(default_decomposer))
    if(get("output_decomposer") == None) have("output_decomposer",List.fill[Int](num_output)(default_decomposer))

    // Decomposer Ports
    if(!directionAssigned) assign_direction(Ports.filter(p=>p.io == OUTPUT_TYPE))
    if(!directionAssigned) assign_direction(Ports.filter(p=>p.io == INPUT_TYPE))
    if(!hasDecomposed) decompose_all_Ports

    // default connection is subnet match connect
    val input_decomposer = get("input_decomposer").asInstanceOf[List[Int]]
    val output_decomposer = get("output_decomposer").asInstanceOf[List[Int]]
    for(i <- 0 until num_input){
      val num_input_subnet = input_decomposer(i)
      for (o <- 0 until num_output){
        val num_output_subnet = output_decomposer(o)
        if(num_input_subnet == num_output_subnet){
          for(s <- 0 until num_output_subnet){
            val source_port = get_subnet_port(INPUT_TYPE,i,s)
            val sink_port = get_subnet_port(OUTPUT_TYPE,o,s)
            have(source_port --> sink_port,Ports.indexOf(source_port)->Ports.indexOf(sink_port))
          }
        }
      }
    }

    // Solve Multi Input Conflict
    solveMultiInputConflictwithMUX

    // Arrange the Register
    arrange_register_config_bit
  }
}

class Router_Hw(p:Entity) extends typical_module(p)


// Change Input Output Capability to Mux
/*
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
    val mux_input_data_port = mux.Ports.zipWithIndex.filter(p=>p._1.io == INPUT_TYPE && p._1.get("function") == "data")
    val mux_output_data_port = mux.Ports.zipWithIndex.filter(p=>p._1.io == OUTPUT_TYPE && p._1.get("function") == "data")
    for (s <- 0 until num_source_port){
      mux.Sources(sources_port_id(s)) = mux_input_data_port(s)._2
      Relationships -= sources_port_id(s)->sink_port_id
      Relationships += sources_port_id(s)->mux_input_data_port(s)._1.entity_id
    }
    Relationships += mux_output_data_port.head._1.entity_id -> sink_port_id
  }
}
*/