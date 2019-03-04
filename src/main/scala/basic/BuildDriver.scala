package basic

import chisel3.experimental.RawModule

trait BuildDriver extends App{
  // Chisel Driver and Verilog Output
  def instantiate(p:Entity): Unit = {
    chisel3.Driver.execute(args,()=>
      Class.forName(p.entity_type+"_Hw")
        .getConstructor(classOf[Entity])
        .newInstance(p).asInstanceOf[RawModule])
  }
}
