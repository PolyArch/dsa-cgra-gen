package cgra.driver

import cgra.IR.IRinstantiator.instantiateCgra
import cgra.IR.IRmerger.mergeIRwithCgra
import cgra.IR.IRreader.readIR
import cgra.IR.IRconfigpather

import scala.collection.mutable

object CgraGen extends App{
  val readFile    : String = args(0) // "/home/sihao/ss-cgra-gen/IR/cgra_5x5_revel.yaml"
  val is_build_configpath : Boolean = args(1).toBoolean // true
  val is_gen : Boolean = args(2).toBoolean // false
  // read IR
  val cgra : mutable.Map[String,Any] = readIR(readFile)
  // Pre-process
  if(is_build_configpath){
    println((new IRconfigpather).build_config_path(cgra))
  }
  // Generate CGRA
  if(is_gen){
    instantiateCgra(args,cgra)
    val className = cgra("module_type").toString().split("\\.").reverse.head
    //mergeIRwithCgra(readFile,output_dir + "/" + className + ".v")
  }
}
