package cgra.fabric

import chisel3._
import chisel3.util._
import dsl.IRPrintable

import scala.collection.mutable

class two_module_cgra(prop:mutable.Map[String,Any]) extends Module
  with IRPrintable{
  apply(prop)

  val io = IO(new Bundle{
    val in = Input(Bool())
    val out =  Output(Bool())
  })

  def postprocess(): Unit = ???

}
