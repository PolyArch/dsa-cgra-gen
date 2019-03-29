import cgra.IR.IRinstantiator._
import cgra.IR.IRpreprocessor._
import cgra.IR.IRreader._
import cgra.IR.IRmerger._

import scala.collection.mutable

object CgraGen extends App{
  val readFile    : String = args(0) // "/home/sihao/ss-cgra-gen/IR/cgra_3x3_new.yaml"
  val output_dir  : String = args(1) // "verilog-output"
  val cgra : mutable.Map[String,Any] = readCgra(readFile)
  preprocess(cgra)
  instantiateCgra(output_dir,cgra)
  mergeIRwithCgra(readFile,output_dir + "/Cgra_Hw.v")
}