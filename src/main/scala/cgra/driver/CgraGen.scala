package cgra.driver

import cgra.IR.IRinstantiator.instantiateCgra
import cgra.IR.IRmerger.mergeIRwithCgra
import cgra.IR.IRreader.readIR
import cgra.IR.IRconfigpather.tranverse_config_path

import scala.collection.mutable

object CgraGen extends App{
  val readFile    : String = args(0) // "/home/sihao/ss-cgra-gen/IR/cgra_5x5_revel.yaml"
  val output_dir  : String = args(1) // "verilog-output"
  val cgra : mutable.Map[String,Any] = readIR(readFile)
  instantiateCgra(output_dir,cgra)
  val className = cgra("module_type").toString().split("\\.").reverse.head
  mergeIRwithCgra(readFile,output_dir + "/" + className + ".v")
}
