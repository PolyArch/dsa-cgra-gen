import cgra.IR.IRinstantiator._
import cgra.IR.IRpreprocessor._
import cgra.IR.IRreader._

object CgraGen extends App{
  val readFile : String = System.getProperty("user.dir") + "/IR/" + args(0)   // "/home/sihao/ss-cgra-gen/sample-IR/cgra_3x3_new.yaml"
  val output_dir : String = args(1) // "verilog-output"

  val cgra = readCgra(readFile)
  preprocess(cgra)
  instantiateCgra(output_dir,cgra)
}
