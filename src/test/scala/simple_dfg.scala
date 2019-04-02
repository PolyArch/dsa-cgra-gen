import chisel3._
import chisel3.iotesters.PeekPokeTester
import chisel3.util._
import cgra.IR.IRreader._
import cgra.fabric.Cgra_Hw
import scala.xml.XML

class simple_dfg_tester(cgra_Hw: Cgra_Hw) extends PeekPokeTester(cgra_Hw){
  poke(cgra_Hw.io.in(0).bits,11)
  poke(cgra_Hw.io.in(0).valid,true.B)
  step(1)
  println(" --------------- Cycle 1 ----------------")
  poke(cgra_Hw.io.in(0).bits,12)
  poke(cgra_Hw.io.in(0).valid,true.B)
  step(1)
  println(" --------------- Cycle 2 ----------------")
  poke(cgra_Hw.io.in(0).bits,13)
  poke(cgra_Hw.io.in(0).valid,true.B)
  step(1)
  println(" --------------- Cycle 3 ----------------")
  poke(cgra_Hw.io.in(0).bits,15)
  poke(cgra_Hw.io.in(0).valid,true.B)
  step(1)
  println(" --------------- Cycle 4 ----------------")
  poke(cgra_Hw.io.in(0).bits,17)
  poke(cgra_Hw.io.in(0).valid,true.B)
  step(1)
  println(" --------------- Cycle 5 ----------------")
}

object simple_dfg extends App{
  val cgra_hw = readIR(args(0))
  iotesters.Driver.execute(args, () =>
    new Cgra_Hw("simple_cgra",cgra_hw)
  ){
    c => new simple_dfg_tester(c)
  }
}
