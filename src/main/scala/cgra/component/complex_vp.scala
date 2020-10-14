package cgra.component

import cgra.IO.EnabledVecDecoupledIO
import chisel3.util._
import chisel3._
import dsl.IRPrintable
import common.wrapper._
import cgra.config.fullinst._
import cgra.fabric.delay
import scala.collection.mutable

class complex_vp(prop:mutable.Map[String,Any]) extends Module with IRPrintable{
  // Assign initial properties
  apply(prop)

  // Initialize the I/O port
  val io = IO(new EnabledVecDecoupledIO(4, 4,
    1 + 64))

  // Post process
  def postprocess(): Unit = {
    print(this)
  }
}
