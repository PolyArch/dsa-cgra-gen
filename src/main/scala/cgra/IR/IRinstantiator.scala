package cgra.IR

import chisel3.experimental.RawModule

import scala.collection.mutable

object IRinstantiator {
  def instantiateCgra (outputDir:String,cgra:mutable.Map[String,Any])={
    val args = Array("--target-dir",outputDir)
    val system = cgra("system").asInstanceOf[mutable.Map[String,Any]]
    chisel3.Driver.execute(args,()=>{
      val c = Class.forName("cgra.fabric."+system("module_type")toString)
        .getConstructor(classOf[mutable.Map[String,Any]])
        .newInstance(cgra).asInstanceOf[RawModule]
      c
    }
    )
  }
}
