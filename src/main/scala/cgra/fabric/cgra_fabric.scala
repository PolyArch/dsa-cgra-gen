package cgra.fabric

import cgra.IO._
import chisel3.util._
import chisel3._
import dsl.IRPrintable
import scala.collection.mutable
import scala.util.Random
import cgra.config.fullinst._

class cgra_fabric(prop:mutable.Map[String, Any]) extends Module
  with IRPrintable {
  // add the initial property
  apply(prop)

  val num_input =

}
