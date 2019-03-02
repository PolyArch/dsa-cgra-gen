package basic

import basic.Constant._
import chisel3.util.log2Ceil

object myFirstBuilding extends Build {
  // Create Module
  val switch = Router()
  switch.have("Word_Width",64)


  // Add Ports
  switch.ports +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true)
  switch.ports +=
    Port(OUTPUT_TYPE,true,true) +=
    Port(OUTPUT_TYPE,true,true) +=
    Port(OUTPUT_TYPE,true,true) +=
    Port(OUTPUT_TYPE,true,true) +=
    Port(OUTPUT_TYPE,true,true)
  switch.ports.foreach(x=>x.have("function","data"))

  switch passdown_word_width

  val control_port = Port(MMIO_TYPE,false,false)
  control_port have ("function","control")
  control_port have ("index_width",16)
  control_port have ("Word_Width",32)
  switch.ports += control_port

  // Add Parameters
  switch have("default decomposer",1)
  switch have("input_decomposer",List(1,2,4,1))
  switch have("output_decomposer",List(2,2,1,1,4))

  // Synthesis Start
  switch.forsyn
  scala.xml.XML.save("/home/sihao/ss-stack/ss-cgra-gen/test_new_mux.xml",
    switch toXML,"UTF-8",false,null)
  instantiate(switch)
}

// ------ Switch ------
/*
  val switch = Router()
  switch.have("Word_Width",64)
  switch.input_ports +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true)
  switch.input_ports.foreach(x=>x.have("function","data"))
  switch.output_ports +=
    Port(OUTPUT_TYPE,true,true) +=
    Port(OUTPUT_TYPE,true,true) +=
    Port(OUTPUT_TYPE,true,true) +=
    Port(OUTPUT_TYPE,true,true)
  switch.input_ports.foreach(x=>x.have("function","data"))
 */


// ------ Mux ------
/*
  val mux = Multiplexer()
  mux.have("Word_Width",64)
  mux.ports +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true) +=
    Port(INPUT_TYPE,true,true)
  mux.ports += Port(OUTPUT_TYPE,true,true)
  mux.ports.foreach(x=>x.have("function","data"))

  mux passdown_word_width

  val config_port = Port(INPUT_TYPE,false,false)
  config_port have ("function","control")
  config_port have("Word_Width",log2Ceil(4 + 1))
  mux have config_port

  mux.forsyn

  scala.xml.XML.save("/home/sihao/ss-stack/ss-cgra-gen/test_new_mux.xml",
    mux toXML,"UTF-8",false,null)

  instantiate(mux)
 */