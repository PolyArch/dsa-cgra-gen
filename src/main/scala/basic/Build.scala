package basic

import chisel3.experimental.RawModule

class Build extends App{

  def instantiate(p:Entity): Unit = {
    chisel3.Driver.execute(args,()=>
      Class.forName(p.getClass.getName+"_Hw")
        .getConstructor(p.getClass)
        .newInstance(p).asInstanceOf[RawModule])
  }

}
