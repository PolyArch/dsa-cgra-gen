package cgra.IR

import chisel3.experimental.RawModule

import scala.collection.mutable

object IRinstantiator {
  def instantiateCgra (outputDir:String,cgra:mutable.Map[String,Any])={
    val args = Array("--target-dir",outputDir)
    val module_type = cgra("module_type").toString
    chisel3.Driver.execute(args,()=>{
      val c = Class.forName(module_type)
        .getConstructor(classOf[(String,mutable.Map[String,Any])])
        .newInstance((module_type,cgra)).asInstanceOf[RawModule]
      c
    }
    )
  }
}
