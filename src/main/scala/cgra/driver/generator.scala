package cgra.driver

import cgra.IR.IRinstantiator.instantiateCgra
import cgra.IR.IRmerger.mergeIRwithCgra
import cgra.IR.IRreader.readIR
import cgra.IR.IRconfigpather

import scala.collection.mutable

object generator extends App{
  require(args.length >= 1)
  val readFile : String = args(0) // "/home/sihao/ss-cgra-gen/IR/cgra_5x5_revel.yaml"

  val is_build_configpath : Boolean =
    if(args.length <= 1) true
    else args(1).toBoolean // true
  val is_gen : Boolean =
    if(args.length <= 2) true
    else args(2).toBoolean // false
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
