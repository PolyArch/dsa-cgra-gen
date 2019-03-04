package basic.dsl

import basic.Constant._
import basic.{Build,Port, Router}

object build_router extends Build {
  // Create Module
  val switch = Router()
  switch.have("Word_Width",64)

  // Add Internal Parameters
  val input_decompoer = List(1,2,4,1)
  val num_input = input_decompoer.length
  val output_decomposer = List(2,2,1,1,4)
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
    Port(INPUT_TYPE,true,true)
  switch.Ports +=
    Port(OUTPUT_TYPE,true,true) +=
    Port(OUTPUT_TYPE,true,true) +=
    Port(OUTPUT_TYPE,true,true) +=
    Port(OUTPUT_TYPE,true,true) +=
    Port(OUTPUT_TYPE,true,true)
  switch.Ports.foreach(x=>x.have("function","data"))

  switch.passdown_word_width
  switch assign_direction switch.Ports.filter(_.io == INPUT_TYPE)
  switch assign_direction switch.Ports.filter(_.io == OUTPUT_TYPE)
  switch decompose_all_Ports

  assign_entity_id(switch.Ports.toList)

  // Add Control Port
  val control_port = Port(MMIO_TYPE,false,false)
  control_port have ("function","control")
  control_port have ("index_width",16)
  control_port have ("Word_Width",32)
  switch.Ports += control_port

  // Router Connection (Input/Output Capability)
  for(i <- 0 until num_input){
    for (o <- 0 until num_output){
      val input_num_subnet = input_decompoer(i)
      val output_num_subnet = output_decomposer(o)
      for (is <- 0 until input_num_subnet){
        val source_port = switch.Ports
          .find(p=>p.io == INPUT_TYPE &&
            p.get("Port_Index").asInstanceOf[Int] == i &&
          p.get("Sub_Net_Index").asInstanceOf[Int] == is).get
        for (os <- 0 until output_num_subnet){
          val sink_port = switch.Ports
            .find(p=>p.io == OUTPUT_TYPE &&
              p.get("Port_Index").asInstanceOf[Int] == o &&
              p.get("Sub_Net_Index").asInstanceOf[Int] == os).get
          if(switch.port_subnet_match(is,os,input_num_subnet,output_num_subnet)){
            switch have(source_port --> sink_port)
          }
        }
      }
    }
  }

  // Generate IR
  switch.forsyn
  val fileName:String = "/home/sihao/ss-stack/ss-cgra-gen/"+ switch.entity_type +".xml"
  saveXMLFile(switch,fileName)

  // Generate Verilog
  val switchEntity = load_Entity_fromXML(loadXMLFile(fileName))
  instantiate(switchEntity)
}
