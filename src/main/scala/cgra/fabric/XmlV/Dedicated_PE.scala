package cgra.fabric.XmlV

import cgra.entity._
import chisel3._
import chisel3.util._
import cgra.IO.IO_Interface._
import cgra.IO.mmio_if
import cgra.fabric.XmlV.common._
import cgra.config.Constant._
import cgra.fabric.XmlV.common.Instructions._

case class Dedicated_PE() extends Entity
  with WithControlRegisterFile
  with SolveMultiInputOneOutput
  with HasDecomposedPorts
  with WithWordWidth
  with HasDirection{
  entity_type = this.getClass.getName

  def forsyn :Unit = {
    // Add control port
    add_mmio_control

    // Check decomposer
    get_decomposer

    // Decomposer Ports
    if(!hasDecomposed) decompose_all_Ports
    if(!directionAssigned) assign_port_direction

    // Get IO decomposer
    val input_decomposer = get("input_decomposer").asInstanceOf[List[Int]]
    val output_decomposer = get("output_decomposer").asInstanceOf[List[Int]]

    // Pre-Check
    require(input_decomposer.distinct.toSet == output_decomposer.distinct.toSet)

    // Build Datapath
    for (s_num <- input_decomposer.distinct){
      // Extract Number of Subnet
      val word_width = get("Word_Width").asInstanceOf[Int]/s_num
      for (s <- 0 until s_num){
        // Create ALU
        val alu = Arithmetic_Logic_Unit()
        have (alu);alu have("Word_Width",word_width)
        alu have("Instruction-Set",get("subnet-"+s_num+"-insts"));alu forsyn
        val alu_in_ports = alu.Ports.zipWithIndex
          .filter(p=>p._1.io == INPUT_TYPE && p._1.get("function") == "data")
        val alu_out_port = alu.Ports.zipWithIndex
          .find(p=>p._1.io == OUTPUT_TYPE).get

        // Get connectted port
        val source_ports = Ports.zipWithIndex
          .filter(p=>p._1.get("Sub_Net_Index") == s && p._1.get("Num_Sub_Net") == s_num && p._1.io == INPUT_TYPE)
        val sink_port = Ports.zipWithIndex
          .find(p=>p._1.get("Sub_Net_Index") == s && p._1.get("Num_Sub_Net") == s_num && p._1.io == OUTPUT_TYPE).get
        var num_operand = 2
        val insts : List[Int]= get("subnet-"+s_num+"-insts").asInstanceOf[List[Int]]
        if (contain_three_operands_inst(insts)) num_operand = 3
        require(num_operand == alu_in_ports.length)

        // Get delay pipe
        val delay_pipes = List.fill[Delay_Pipe](num_operand)(Delay_Pipe())
        delay_pipes.foreach(have(_))
        delay_pipes.foreach(x=>x.have("Word_Width",word_width))
        delay_pipes.foreach(x=>x.have("Max_Delay",get("Max_Delay")))
        delay_pipes.foreach(_.forsyn)

        // Connect delay pipe with input port
        for (delay_pipe_i <- delay_pipes.zipWithIndex){
          val delay_pipe = delay_pipe_i._1
          val index = delay_pipe_i._2
          val dp_in_port = delay_pipe.Ports.zipWithIndex
            .find(p=>p._1.io == INPUT_TYPE && p._1.get("function")=="data").get
          val dp_out_port = delay_pipe.Ports.zipWithIndex
            .find(p=>p._1.io == OUTPUT_TYPE && p._1.get("function")=="data").get
          for (sp <- source_ports){
            have(sp._1 --> dp_in_port._1,sp._2 -> dp_in_port._2)
          }
          // delaypipe --> Alu
          have(dp_out_port._1 --> alu_in_ports(index)._1.asInstanceOf[Entity],dp_out_port._2 -> alu_in_ports(index)._2)
        }
        // Alu --> output port
        have(alu_out_port._1 --> sink_port._1.asInstanceOf[Entity],alu_out_port._2 -> sink_port._2)
      }
    }

    // Solve Multi Input Conflict
    solveMultiInputConflictwithMUX

    // Arrange the Register
    arrange_register_config_bit
  }
}

class Dedicated_PE_Hw(p:Entity) extends typical_module(p)