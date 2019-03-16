package cgra.fabric

import cgra.IR._
import chisel3._
import chisel3.util._

import scala.collection.mutable._

class Cgra_Hw(cgra:Cgra) extends Module{
  // ------ System ------
  val word_width = cgra.system.word_width

  // ------ Input Output ------
  val vector_ports : Map[String,vector_port]= cgra.vector_ports
  val num_input : Int =
  val io = IO(new Bundle{

  })
}
