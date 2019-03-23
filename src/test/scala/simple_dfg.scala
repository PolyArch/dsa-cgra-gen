import cgra.IR.Cgra
import chisel3._
import chisel3.iotesters.PeekPokeTester
import chisel3.util._
import cgra.IR.IRreader._
import cgra.fabric.YamlV.Cgra_Hw

import scala.xml.XML

class simple_dfg_tester(cgra_Hw: Cgra_Hw) extends PeekPokeTester(cgra_Hw){
  val cgra_description = cgra_Hw.hw_desc
  val cgra_configuration = XML.loadFile(cgra_Hw.hw_desc.config_filename)
  poke(cgra_Hw.io.in(0).bits,0)

}

object simple_dfg extends App{
  val cgra_hw = readCgra("/home/sihao/ss-cgra-gen/sample-IR/cgra_3x3_new.yaml")
  iotesters.Driver.execute(args, () =>
    new Cgra_Hw(Cgra(cgra_hw))
  ){
    c => new simple_dfg_tester(c)
  }
}