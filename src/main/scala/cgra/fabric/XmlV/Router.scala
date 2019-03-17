package cgra.fabric.XmlV

import chisel3._
import chisel3.util._
import cgra.IO.IO_Interface._
import cgra.IO.mmio_if
import cgra.fabric.XmlV.common._
import cgra.config.Constant._
import cgra.entity._

import scala.collection.mutable._

case class Router() extends Entity
  with WithControlRegisterFile
  with SolveMultiInputOneOutput
  with HasDecomposedPorts
  with WithWordWidth
  with HasDirection {
  entity_type = this.getClass.getName

  def forsyn:Unit = {
    // Add control port
    add_mmio_control

    // Check decomposer
    get_decomposer

    // Decomposer Ports
    if(!hasDecomposed) decompose_all_Ports
    if(!directionAssigned) assign_port_direction

    // Get IO decomposer
    val num_input = get("num_input").asInstanceOf[Int]
    val num_output = get("num_output").asInstanceOf[Int]
    val input_decomposer = get("input_decomposer").asInstanceOf[List[Int]]
    val output_decomposer = get("output_decomposer").asInstanceOf[List[Int]]

    // Input/Output Capability
    for(i <- 0 until num_input){
      val num_input_subnet = input_decomposer(i)
      for (o <- 0 until num_output){
        val num_output_subnet = output_decomposer(o)
        if(num_input_subnet == num_output_subnet){
          for(s <- 0 until num_output_subnet){
            val source_port = get_subnet_port(INPUT_TYPE,i,s)
            val sink_port = get_subnet_port(OUTPUT_TYPE,o,s)
            have(source_port --> sink_port,Ports.indexOf(source_port)->Ports.indexOf(sink_port))
          }
        }
      }
    }

    // Solve Multi Input Conflict
    solveMultiInputConflictwithMUX

    // Arrange the Register
    arrange_register_config_bit
  }
}

class Router_Hw(p:Entity) extends typical_module(p)