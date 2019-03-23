package cgra.IR

import _root_.cgra.fabric.YamlV.Cgra_Hw
import chisel3.experimental.RawModule

import scala.collection.mutable

object IRinstantiator {
  def instantiateCgra (outputDir:String,cgra_t:mutable.Map[String,Any])={
    val args = Array("--target-dir",outputDir)
    val cgra = Cgra(cgra_t)
    chisel3.Driver.execute(args,()=>{
      val c = Class.forName("cgra.fabric.YamlV."+cgra.system.module_type)
        .getConstructor(classOf[Cgra])
        .newInstance(cgra).asInstanceOf[RawModule]
      c
    }
    )
  }
}
