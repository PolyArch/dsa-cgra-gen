package basic.dsl

import basic.Constant._
import basic.{Build, PValue, Port, Router}

object build_router extends Build {
  // Create Module
  val switch = Router()
  switch.have("Word_Width",64)
  switch.entity_id = 123456
  switch.have("register_file_length",5,1,16,1)
  switch.have("register_file_width",16,List(4,8,16,32,64))

  // Add Internal Parameters
  val input_decompoer = List(2,2,2,2,2,4,4,1,1)
  val num_input = input_decompoer.length
  val output_decomposer = List(2,2,1,4)
  val num_output = output_decomposer.length
  switch have("default decomposer",1)
  switch have("num_input",num_input)
  switch have("num_output",num_output)
  switch have("input_decomposer",input_decompoer)
  switch have("output_decomposer",output_decomposer)

  // Add Ports
  switch.Ports +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true)
  switch.Ports +=
    Port(OUTPUT_TYPE,true,true) +=
    Port(OUTPUT_TYPE,true,true) +=
    Port(OUTPUT_TYPE,true,true) +=
    Port(OUTPUT_TYPE,true,true)
  switch.Ports.foreach(x=>x.have("function","data"))

  switch.passdown_word_width
  switch assign_direction switch.Ports.filter(p=>p.io == OUTPUT_TYPE)
  switch assign_direction switch.Ports.filter(p=>p.io == INPUT_TYPE)
  switch.decompose_all_Ports
  switch.Ports --= switch.Ports
  switch.Ports ++= switch.decomposed_ports

  // Add Control Port
  val control_port = Port(MMIO_TYPE,false,false)
  control_port have ("function","control")
  control_port have ("index_width",16)
  control_port have ("Word_Width",32)
  switch.Ports += control_port

  // Assign Parent and Index
  switch assign_index switch.Ports
  switch assign_parent

  // assign entity id to all ports
  switch.internal_entity_id_counter =
    assign_entity_id(switch.Ports.toList ::: switch.decomposed_ports.toList)

  // Router Connection (Input/Output Capability)
  for(i <- 0 until num_input){
    val num_input_subnet = input_decompoer(i)
    for (o <- 0 until num_output){
      val num_output_subnet = output_decomposer(o)
      if(num_input_subnet == num_output_subnet){
        for(s <- 0 until num_output_subnet){
          val source_port = switch.get_subnet_port(INPUT_TYPE,i,s)
          val sink_port = switch.get_subnet_port(OUTPUT_TYPE,o,s)
          switch have(source_port --> sink_port)
        }
      }
    }
  }

  // SubNet Interconnection
  val source_port_index = Index_Direction_Map("East").asInstanceOf[Int]
  val sink_port_index = Index_Direction_Map("North").asInstanceOf[Int]
  val decomp_source_port = switch.get_subnet_port(INPUT_TYPE,source_port_index,0)
  val decomp_sink_port = switch.get_subnet_port(OUTPUT_TYPE,sink_port_index,1)
  switch have(decomp_source_port --> decomp_sink_port)

  // Generate IR
  switch.forsyn
  val fileName:String = "/home/sihao/ss-stack/ss-cgra-gen/sample-IR/"+ switch.entity_type +".xml"
  saveXMLFile(switch,fileName)

  // Generate Verilog
  val switchEntity = load_Entity_fromXML(loadXMLFile(fileName))
  instantiate(switchEntity)
}
