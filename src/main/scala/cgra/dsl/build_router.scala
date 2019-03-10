package cgra.dsl

import cgra.config.Constant._
import cgra.build.Build
import cgra.entity.Port
import cgra.fabric._

object build_router extends Build {
  // Create Module
  val switch = Router()
  switch.have("Word_Width",64)
  switch.have("register_file_length",5,1,16,1)
  switch.have("register_file_width",16,List(4,8,16,32,64))
  // Config Port Parameter
  switch have ("config_index_width",4)
  switch have ("config_word_width",16)
  // Add Ports
  val num_input = 9; val num_output = 4;switch have("num_output",num_output);switch have("num_input",num_input)
  switch have Port(INPUT_TYPE,true,true) * num_input
  switch have Port(OUTPUT_TYPE,true,true) * num_output

  // Add Internal Parameters
  val input_decomposer = List(2,2,2,2,2,4,4,1,1);switch have("input_decomposer",input_decomposer)
  val output_decomposer = List(2,2,1,4);switch have("output_decomposer",output_decomposer)
  switch.Ports.foreach(x=>x.have("function","data"))

  // SubNet Interconnection （Optional）
  switch decompose_all_Ports; // If you need to customize subnet connect, please decompose manually
  val decomp_source_port = switch.get_subnet_port(INPUT_TYPE,"East",0)
  val decomp_sink_port = switch.get_subnet_port(OUTPUT_TYPE,"North",1)
  switch have(decomp_source_port --> decomp_sink_port,
    switch.Ports.indexOf(decomp_source_port)->switch.Ports.indexOf(decomp_sink_port))

  // Generate IR
  switch forsyn
  val fileName:String = "./sample-IR/"+ switch.entity_type +".xml"
  saveXMLFile(switch,fileName)

  // Generate Verilog
  val switchEntity = load_Entity_fromXML(loadXMLFile(fileName))
  instantiate(switchEntity)
}
