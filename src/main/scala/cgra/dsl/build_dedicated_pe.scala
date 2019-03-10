package cgra.dsl

import cgra.build.Build
import cgra.entity.Port
import cgra.fabric.Dedicated_PE
import cgra.config.Constant._
import cgra.fabric.common.Instructions._

object build_dedicated_pe extends Build {

  // Create Module
  val dedi_pe = Dedicated_PE()
  dedi_pe.have("Word_Width",64)
  dedi_pe.entity_id = 9527
  dedi_pe have("register_file_length",8,1,16,1)
  dedi_pe have("register_file_width",16,List(8,16,32,64))
  dedi_pe have ("subnet-2-insts",signed_insts_list)
  dedi_pe have ("subnet-4-insts",unsigned_insts_list)
  dedi_pe have ("Max_Delay",6,1,32,1)

  // Add Ports and assign decomposer
  val num_input = 6; val num_output = 2
  dedi_pe have("num_output",num_output);dedi_pe have("num_input",num_input)
  dedi_pe have Port(INPUT_TYPE,false,false) * num_input
  dedi_pe have Port(OUTPUT_TYPE,false,false) * num_output
  val input_decomposer = List(2,2,2,4,4,4);dedi_pe have("input_decomposer",input_decomposer)
  val output_decomposer = List(2,4);dedi_pe have("output_decomposer",output_decomposer)

  // Config Port Parameter
  dedi_pe have ("config_index_width",4)
  dedi_pe have ("config_word_width",16)

  // Generate IR
  dedi_pe forsyn
  val fileName:String = "/home/sihao/ss-cgra-gen/sample-IR/"+ dedi_pe.entity_type +".xml"
  saveXMLFile(dedi_pe,fileName)

  // Generate Verilog
  val dedi_peEntity = load_Entity_fromXML(loadXMLFile(fileName))
  instantiate(dedi_peEntity)
}
