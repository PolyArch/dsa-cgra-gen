package cgra.fabric

import cgra.entity._
import chisel3._
import chisel3.util._
import cgra.IO.IO_Interface._
import cgra.IO.mmio_if
import cgra.fabric.common._
import cgra.config.Constant._
import cgra.fabric.common.Instructions._

case class Dedicated_PE() extends Entity
  with WithControlRegisterFile
  with SolveMultiInputOneOutput
  with HasDecomposedPorts
  with WithWordWidth
  with HasDirection{
  entity_type = this.getClass.getName

  def forsyn :Unit = {
    // Add control port
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

    // Get IO decomposer
    val input_decomposer = get("input_decomposer").asInstanceOf[List[Int]]
    val output_decomposer = get("output_decomposer").asInstanceOf[List[Int]]
    require(input_decomposer.distinct.toSet == output_decomposer.distinct.toSet)

    // Get Subnet Specfic Instructions
    val subnet_specfic_inst = get("subnet-specific-inst").asInstanceOf[Map[Int,List[Int]]]

    // Build Datapath
    for (s_num <- input_decomposer.distinct){
      // Extract Number of Subnet
      val word_width = get("Word_Width").asInstanceOf[Int]/s_num
      for (s <- 0 until s_num){
        // Create ALU
        val alu = Arithmetic_Logic_Unit()
        have (alu);alu have("Word_Width",word_width)
        alu have("Instruction-Set",subnet_specfic_inst(s_num));alu forsyn
        val alu_in_ports = alu.Ports.zipWithIndex
          .filter(p=>p._1.io == INPUT_TYPE && p._1.get("function") == "data")
        val alu_out_port = alu.Ports.zipWithIndex
          .find(p=>p._1.io == OUTPUT_TYPE).get

        // Get connectted port
        val source_ports = Ports.zipWithIndex
          .filter(p=>p._1.get("Sub_Net_Index") == s && p._1.get("Num_Sub_Net") == s_num && p._1.io == INPUT_TYPE)
        val sink_port = Ports.zipWithIndex
          .find(p=>p._1.get("Sub_Net_Index") == s && p._1.get("Num_Sub_Net") == s_num && p._1.io == OUTPUT_TYPE).get
        var num_operand = 2
        val insts : List[Int]= subnet_specfic_inst(s_num)
        if (contain_three_operands_inst(insts)) num_operand = 3
        require(num_operand == alu_in_ports.length)

        // Get delay pipe
        val delay_pipes = List.fill[Delay_Pipe](num_operand)(Delay_Pipe())
        delay_pipes.foreach(have(_))
        delay_pipes.foreach(x=>x.have("Word_Width",word_width))
        delay_pipes.foreach(x=>x.have("Max_Delay",6,1,32,1))
        delay_pipes.foreach(_.forsyn)

        // Connect delay pipe with input port
        for (delay_pipe_i <- delay_pipes.zipWithIndex){
          val delay_pipe = delay_pipe_i._1
          val index = delay_pipe_i._2
          val dp_in_port = delay_pipe.Ports.zipWithIndex
            .find(p=>p._1.io == INPUT_TYPE && p._1.get("function")=="data").get
          val dp_out_port = delay_pipe.Ports.zipWithIndex
            .find(p=>p._1.io == OUTPUT_TYPE && p._1.get("function")=="data").get
          for (sp <- source_ports){
            have(sp._1 --> dp_in_port._1,sp._2 -> dp_in_port._2)
          }
          // delaypipe --> alu
          have(dp_out_port._1 --> alu_in_ports(index)._1.asInstanceOf[Entity],dp_out_port._2 -> alu_in_ports(index)._2)
        }
        // alu --> output port
        have(alu_out_port._1 --> sink_port._1.asInstanceOf[Entity],alu_out_port._2 -> sink_port._2)
      }
    }

    // Solve Multi Input Conflict
    solveMultiInputConflictwithMUX

    // Arrange the Register
    arrange_register_config_bit
  }
}

class Dedicated_PE_Hw(p:Entity) extends typical_module(p)

// Add mux based on the same sink ports
/*
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
}
*/

// Find all delay pipe
/*
val delay_pipes = Entities.filter(p=>p.entity_type == Delay_Pipe().entity_type)
for (delayP <- delay_pipes){
  val dp_in_port = delayP.Ports.find(p=>p.io == INPUT_TYPE && p.get("function") == "data").get
  val dp_out_port = delayP.Ports.zipWithIndex.find(p=>p._1.io == OUTPUT_TYPE && p._1.get("function") == "data").get
  val source_ports_id = Relationships.filter(_._2 == dp_in_port.entity_id).map(_._1)
  val source_ports = source_ports_id.map(i=>Ports.zipWithIndex.find(p=>p._1.entity_id == i).get)
  val mux = Multiplexer()
  this have mux
  for (s <- source_ports){
    val temp_port:Port = Port(INPUT_TYPE,false,false)
    temp_port.have("Word_Width",s._1.get("Word_Width").asInstanceOf[Int])
    mux.have(temp_port)
    mux.have(s._1 --> temp_port,s._2 -> mux.Ports.indexOf(temp_port))
  }
  val temp_port = Port(OUTPUT_TYPE,false,false)
  temp_port.have("Word_Width",dp_out_port._1.get("Word_Width").asInstanceOf[Int])
  mux have temp_port
  mux have (temp_port --> dp_out_port._1,mux.Ports.indexOf(temp_port) -> dp_out_port._2)
  mux.forsyn
  val mux_input_data_port = mux.Ports.zipWithIndex.filter(p=>p._1.io == INPUT_TYPE && p._1.get("function") == "data")
  val mux_output_data_port = mux.Ports.zipWithIndex.filter(p=>p._1.io == OUTPUT_TYPE && p._1.get("function") == "data")
  for (s <- 0 until source_ports.length){
    mux.Sources(source_ports_id(s)) = mux_input_data_port(s)._2
    Relationships -= source_ports_id(s)->dp_in_port.entity_id
    Relationships += source_ports_id(s)->mux_input_data_port(s)._1.entity_id
  }
  Relationships += mux_output_data_port.head._1.entity_id -> dp_in_port.entity_id
}
*/
