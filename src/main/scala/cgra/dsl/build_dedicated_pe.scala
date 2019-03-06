package cgra.dsl

import cgra.build.Build
import cgra.entity.Port
import cgra.fabric.Dedicated_PE
import cgra.config.Constant._
import cgra.fabric.common.Instructions._
import cgra.fabric.common.{Arithmetic_Logic_Unit, Delay_Pipe}

object build_dedicated_pe extends Build {

  // Create Module
  val dedi_pe = Dedicated_PE()
  dedi_pe.have("Word_Width",64)
  dedi_pe.entity_id = 9527
  dedi_pe have("register_file_length",8,1,16,1)
  dedi_pe have("register_file_width",16,List(8,16,32,64))
  dedi_pe have("signed_inst_list",signed_insts_list)
  dedi_pe have("unsigned_inst_list",unsigned_insts_list)

  // Add Ports and assign decomposer
  dedi_pe.Ports ++= Port(INPUT_TYPE,false,false) * 6
  dedi_pe.Ports ++= Port(OUTPUT_TYPE,false,false) * 2
  val input_decomposer = List(2,2,2,4,4,4);dedi_pe have("input_decomposer",input_decomposer)
  val output_decomposer = List(2,4);dedi_pe have("output_decomposer",output_decomposer)
  val num_input = input_decomposer.length;dedi_pe have("num_input",num_input)
  val num_output = output_decomposer.length;dedi_pe have("num_output",num_output)
  dedi_pe passdown_word_width
  val control_port = Port(MMIO_TYPE,false,false)
  control_port have ("function","control")
  control_port have ("Index_Width",4)
  control_port have ("Word_Width",16)
  dedi_pe.Ports += control_port
  dedi_pe decompose_all_Ports;dedi_pe assign_index dedi_pe.Ports
  dedi_pe.internal_entity_id_counter = assign_entity_id(dedi_pe.Ports.toList)

  // Build Datapath
  for (s_num <- input_decomposer.distinct){
    for (s <- 0 until s_num){
      val source_ports = dedi_pe.Ports
        .filter(p=>p.get("Sub_Net_Index") == s && p.get("Num_Sub_Net") == s_num && p.io == INPUT_TYPE)
      val sink_port = dedi_pe.Ports
        .find(p=>p.get("Sub_Net_Index") == s && p.get("Num_Sub_Net") == s_num && p.io == OUTPUT_TYPE).get

      val word_width = source_ports.map(p=>p.get("Word_Width")).distinct
      require(word_width.length == 1)
      val dp1 = Delay_Pipe();dedi_pe have dp1;val dp2 = Delay_Pipe();dedi_pe have dp2;
      val dp3 = Delay_Pipe();dedi_pe have dp3;
      dp1 have("Word_Width",word_width.head);dp1 have("Max_Delay",6,1,18,2);dp1 forsyn;
      dp2 have("Word_Width",word_width.head);dp2 have("Max_Delay",3,1,32,1);dp2 forsyn;
      dp3 have("Word_Width",word_width.head);dp3 have("Max_Delay",3,1,32,1);dp3 forsyn;
      dedi_pe.internal_entity_id_counter = assign_entity_id(dp1.Ports.toList)
      dedi_pe.internal_entity_id_counter = assign_entity_id(dp2.Ports.toList)
      dedi_pe.internal_entity_id_counter = assign_entity_id(dp3.Ports.toList)
      val dp1_in_port = dp1.Ports.find(p=>p.io == INPUT_TYPE && p.get("function")=="data").get
      val dp2_in_port = dp2.Ports.find(p=>p.io == INPUT_TYPE && p.get("function")=="data").get
      val dp3_in_port = dp3.Ports.find(p=>p.io == INPUT_TYPE && p.get("function")=="data").get
      val dp1_out_port = dp1.Ports.find(p=>p.io == OUTPUT_TYPE && p.get("function")=="data").get
      val dp2_out_port = dp2.Ports.find(p=>p.io == OUTPUT_TYPE && p.get("function")=="data").get
      val dp3_out_port = dp3.Ports.find(p=>p.io == OUTPUT_TYPE && p.get("function")=="data").get
      for (sp <- source_ports){
        dedi_pe have(sp --> dp1_in_port)
        dedi_pe have(sp --> dp2_in_port)
        dedi_pe have(sp --> dp3_in_port)
      }
      val alu = Arithmetic_Logic_Unit();dedi_pe have alu
      alu have("Word_Width",word_width.head);alu have("Instruction-Set",unsigned_insts_list);alu forsyn;
      dedi_pe.internal_entity_id_counter = assign_entity_id(alu.Ports.toList)
      val alu_in_ports = alu.Ports.filter(p=>p.io == INPUT_TYPE && p.get("function") == "data")
      val alu_out_port = alu.Ports.find(p=>p.io == OUTPUT_TYPE).get
      dedi_pe have(dp1_out_port --> alu_in_ports.head)
      dedi_pe have(dp2_out_port --> alu_in_ports(1))
      dedi_pe have(dp3_out_port --> alu_in_ports(2))
      dedi_pe have(alu_out_port --> sink_port)
    }
  }

  // Generate IR
  dedi_pe assign_parent;
  dedi_pe forsyn;
  val fileName:String = "/home/sihao/ss-stack/ss-cgra-gen/sample-IR/"+ dedi_pe.entity_type +".xml"
  saveXMLFile(dedi_pe,fileName)

  // Generate Verilog
  val dedi_peEntity = load_Entity_fromXML(loadXMLFile(fileName))
  instantiate(dedi_peEntity)
}
