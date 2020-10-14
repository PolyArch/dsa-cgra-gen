package cgra.IR

import chisel3.RawModule
import dsl.IRPrintable

import scala.collection.mutable

object IRinstantiator {
  def instantiateCgra (args:Array[String],cgra:mutable.Map[String,Any])={
    val module_type = cgra("module_type").toString
    chisel3.Driver.execute(args,()=>{
      val dut = Class.forName(module_type)
        .getConstructor(classOf[mutable.Map[String,Any]])
        .newInstance(cgra).asInstanceOf[RawModule]
      dut.asInstanceOf[IRPrintable].printIR
      dut
    }
    )
  }
}
