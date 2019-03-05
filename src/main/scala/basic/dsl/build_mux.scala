package basic.dsl

import basic.Constant._
import basic.{Build, Multiplexer, Port}
import chisel3.util.log2Ceil

object build_mux extends Build {

  // Create Module
  val mux = Multiplexer()

  // Add Internal Parameter
  mux.have("Word_Width",64,8,64,8)

  // Add Data Ports
  mux.Ports +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true)
  mux.Ports += Port(OUTPUT_TYPE,true,true)

  mux passdown_word_width

  // Generate IR
  mux.forsyn
  val fileName:String = "/home/sihao/ss-stack/ss-cgra-gen/sample-IR/"+ mux.entity_type +".xml"
  saveXMLFile(mux,fileName)

  // Generate Verilog
  val muxEntity = load_Entity_fromXML(loadXMLFile(fileName))
  instantiate(muxEntity)
}
