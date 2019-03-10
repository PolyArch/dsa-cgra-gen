package cgra.build

import cgra.entity.Entity
import chisel3.experimental.RawModule

trait BuildDriver extends App{
  // Chisel Driver and Verilog Output
  def instantiate(p:Entity): Unit = {

    val test = Class.forName(p.entity_type).newInstance()

    chisel3.Driver.execute(args,()=>
      Class.forName(p.entity_type+"_Hw")
        .getConstructor(classOf[Entity])
        .newInstance(p).asInstanceOf[RawModule])
  }
}
