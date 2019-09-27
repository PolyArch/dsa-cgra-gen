package cgra.fabric

import cgra.IO._
import chisel3.util._
import cgra.config.system_var
import cgra.config.system_util._
import chisel3._
import cgra.IO.port_generator._
import cgra.config.encoding.{config_module_id_high, config_module_id_low}
import cgra.fabric.common.datapath.Multiplexer
import dsl.{IRPrintable, ssnode}

import scala.collection.mutable
import scala.collection.mutable.ArrayBuffer
import scala.util.Random
import scala.xml.Elem

class switch(prop:mutable.Map[String,Any]) extends Module with IRPrintable{
  // Assign initial properties
  apply(prop)

  // ------ Reconfigurable Variable------

  // Initialize the properties of switch (hardware)
  private val id = getValue(getPropByKey("id")).asInstanceOf[Int]
  private val max_id = getPropByKey("max_id").asInstanceOf[Int]
  private val datawidth:Int = getPropByKey("datawidth").asInstanceOf[Int]
  private val granularity = getPropByKey("granularity").asInstanceOf[Int]
  private val num_input:Int = getPropByKey("num_input").asInstanceOf[Int]
  private val num_output:Int = getPropByKey("num_output").asInstanceOf[Int]
  private val flow_control:Boolean = getPropByKey("flow_control").asInstanceOf[Boolean]
  private val max_util:Int = getPropByKey("share_slot_size").asInstanceOf[Int]
  private val decomposer:Int = datawidth / granularity
  private val config_in_port_idx:Int = getPropByKey("config_in_port_idx")
    .asInstanceOf[Int]
  private val config_out_port_idx:List[Int] = getPropByKey("config_out_port_idx")
    .asInstanceOf[List[Int]]
  private val subnet_table:List[List[Boolean]] =
    getPropByKey("subnet_table").asInstanceOf[List[List[Boolean]]]

  // Calculate the number of configuration
  private val num_conf_output_slot : IndexedSeq[Int] = for (
    port_idx <- 0 until num_output;
    slot_idx <- 0 until decomposer)yield{
    val output_slot_idx = port_idx * decomposer + slot_idx
    subnet_table(output_slot_idx).count(c=>c)
  }

  // Calculate the ID field in incoming config bits
  private val id_field_high = datawidth - 1
  apply("id_field_high", id_field_high)
  private val id_field_low = id_field_high - log2Ceil(max_id) + 1
  apply("id_field_low", id_field_low)

  // Calculate the bit range of configuration
  private var curr_bit = 0
  private val conf_bit_range : IndexedSeq[(Int,Int)]=
    (for (num_conf <- num_conf_output_slot) yield{
      val num_bits = log2Ceil(num_conf + 1)
      require(num_bits >= 1, "No input for port")
      val bit_range = (curr_bit + num_bits - 1, curr_bit)
      curr_bit += num_bits
      bit_range
    }).reverse

  private val conf_bit_width = conf_bit_range.head._1 + 1
  apply("config_bit_width", conf_bit_width)

  // ------ Create Hardware ------

  // Initialize the I/O port
  val io = IO(new Bundle{
    val input_ports = Flipped(Vec(num_input,Vec(decomposer,ReqAckConf_if(granularity))))
    val output_ports = Vec(num_output,Vec(decomposer,ReqAckConf_if(granularity)))
  })


  // Generate the configuration register
  val config_slot_files = RegInit(VecInit(Seq.fill(max_util)(0.U(conf_bit_width.W))))

  val config_enable : Bool = io.input_ports(config_in_port_idx).map(_.config)
    .reduce(_ && _)

  // config wire
  val config_wire :UInt = Wire(UInt(conf_bit_width.W))

  // extract the incoming config information from config in port
  val config_port_bits : UInt = io.input_ports(config_in_port_idx).map(_.bits)
    .reverse.reduce(Cat(_,_))

  // ------ Hardware Logic ------

  when(!config_enable){// Stream: When switch is not being configured

    // Multiple configurations
    if(max_util == 1){
      config_wire := config_slot_files(0)
    }else{
      // configuration counter
      val config_pointer = RegInit(0.U(log2Ceil(max_util).W))

      // select which config to enable
      config_pointer := config_pointer + 1.U

      // select it to wire
      config_wire := config_slot_files(config_pointer)
    }

    // Mux (forward)
    for(output_port_idx <- 0 until num_output;
        output_slot_idx <- 0 until decomposer){
      val slot_idx = output_port_idx * decomposer + output_slot_idx
      val slot_config_bit_range = conf_bit_range(slot_idx)
      val config_high_bit = slot_config_bit_range._1
      val config_low_bit = slot_config_bit_range._2
      require(config_high_bit >= config_low_bit)
      val config_reg_value = config_wire(config_high_bit, config_low_bit)

      // Mux port mapping
      val connected_input = subnet_table(slot_idx).zipWithIndex.filter(
        conn_idx => conn_idx._1
      ).map(conn_idx => (conn_idx._2 / decomposer, conn_idx._2 % decomposer))

      // Mux selection
      val portMuxLookup = for (sel <- connected_input.indices) yield {
        val input_port_slot = connected_input(sel)
        (sel + 1).U -> // selection value = 0 is left for default
          io.input_ports(input_port_slot._1)(input_port_slot._2)
      }

      // bit connection
      io.output_ports(output_port_idx)(output_slot_idx).bits := MuxLookup(
        config_reg_value, 0.U, portMuxLookup.map(x=>(x._1,x._2.bits)))

      // control flow connection
      if(flow_control){
        io.output_ports(output_port_idx)(output_slot_idx).valid := MuxLookup(
          config_reg_value, 0.U, portMuxLookup.map(x=>(x._1,x._2.valid)))
      }else{
        io.output_ports(output_port_idx)(output_slot_idx).valid := DontCare
      }

      // don't care configuration when stream mode
      io.output_ports(output_port_idx)(output_slot_idx).config := DontCare
    }

    // Mux (backward)
    for(input_port_idx <- 0 until num_input;
        input_slot_idx <- 0 until decomposer){
      if(flow_control){
        // Find the location of this slot
        val slot_idx = input_port_idx * decomposer + input_slot_idx
        // Which output slots it connected to
        val connected_output_slot_idx = subnet_table.map(o=>o(slot_idx))
          .zipWithIndex.filter(x=>x._1).map(x=>x._2)
        // Find what is the select value for each output port to select this input
        val sel_input_value_foreach_output = connected_output_slot_idx
          .map(x=>{
            var start_sel_value = 1 // 0 is left for nothing
            for (i <- 0 until slot_idx){
              if(subnet_table(x)(i)){
                start_sel_value += 1
              }
            }
            start_sel_value
          })
        // get select register (wire) for each output slot
        val sel_reg_foreach_output = connected_output_slot_idx
          .map(x=>conf_bit_range(x)).map(hl=>config_wire(hl._1,hl._2))
        require(sel_input_value_foreach_output.length ==
          sel_reg_foreach_output.length)
        // Only when output slot register select this input, then pass ready
        // otherwise the downstream is always ready (true)
        val downstream_readys = for (idx <- connected_output_slot_idx.indices)
          yield{
            val o_slot_idx = connected_output_slot_idx(idx)
            val output_port_idx = o_slot_idx / decomposer
            val output_slot_idx = o_slot_idx % decomposer
            val is_select = sel_input_value_foreach_output(idx).U ===
              sel_reg_foreach_output(idx)
            Mux(is_select,io.output_ports(output_port_idx)(output_slot_idx).ready,
              true.B)
          }
        // AND all downstream ready, then pass to upstream
        val overall_downstream_ready = downstream_readys.reduce(_ && _)
        io.input_ports(input_port_idx)(input_slot_idx).ready :=
          overall_downstream_ready
      }else{
        io.input_ports(input_port_idx)(input_slot_idx).ready := DontCare
      }
    }// End of backward ready connection
  }.otherwise{// When it is during configuration time

    // config wire is disable
    config_wire := 0.U

    // Get the ID field of the incoming information
    val id_bits = config_port_bits(id_field_high, id_field_low)

    // config this module
    val config_this = config_enable && id_bits === id.U


    var useful_config_info_high = id_field_low - 1
    val useful_config_info_low = 0
    when(config_this){
      // when connect to this module, disable all output signal
      // disable bits and valid
      for(output_port_idx <- 0 until num_output;
          output_slot_idx <- 0 until decomposer){
        io.output_ports(output_port_idx)(output_slot_idx).bits := DontCare
        io.output_ports(output_port_idx)(output_slot_idx).valid := DontCare
        io.output_ports(output_port_idx)(output_slot_idx).config := DontCare
      }
      for(input_port_idx <- 0 until num_input;
          input_slot_idx <- 0 until decomposer){
        io.input_ports(input_port_idx)(input_slot_idx).ready := DontCare
      }

      // config register file
      if(max_util > 1){
        // Which config to update in the config slots
        val shared_slot_ptr_field_high = id_field_low - 1
        val shared_slot_bit_range = log2Ceil(max_util)
        val shared_slot_ptr_field_low = shared_slot_ptr_field_high - shared_slot_bit_range + 1
        apply("shared_config_ptr_high", shared_slot_ptr_field_high)
        apply("shared_config_ptr_low", shared_slot_ptr_field_low)
        val toUpdated_config_ptr = config_port_bits(
          shared_slot_ptr_field_high, shared_slot_ptr_field_low)

        // determine the useful config bit range
        useful_config_info_high = shared_slot_ptr_field_low - 1
        val useful_config_width = useful_config_info_high - useful_config_info_low + 1

        // Print Warning if available configuration bit is smaller than needed
        if(useful_config_width < conf_bit_width){
          println("WARNING: this configuration require " + conf_bit_width +
            " bit register, but only " + useful_config_width + " bits are" +
            "available")
        }

        config_slot_files(toUpdated_config_ptr) := config_port_bits
      }else{
        // The needed config bit range need to be smaller than useful config
        val useful_config_width = useful_config_info_high - useful_config_info_low + 1
        require(useful_config_width >= conf_bit_width)

        // Print Warning if available configuration bit is smaller than needed
        if(useful_config_width < conf_bit_width){
          println("WARNING: this configuration require " + conf_bit_width +
            " bit register, but only " + useful_config_width + " bits are" +
            "available")
        }

        // write it into the config register
        config_slot_files.head := config_port_bits
      }
    }.otherwise{// configuration for other nodes, pass it to them
      // forward connection
      for(output_port_idx <- 0 until num_output;
          output_slot_idx <- 0 until decomposer){
        if(config_out_port_idx.contains(output_port_idx)){
          // match slot connection
          io.output_ports(output_port_idx)(output_slot_idx).bits :=
            io.input_ports(config_in_port_idx)(output_slot_idx).bits
          io.output_ports(output_port_idx)(output_slot_idx).valid :=
            io.input_ports(config_in_port_idx)(output_slot_idx).valid
          io.output_ports(output_port_idx)(output_slot_idx).config :=
            io.input_ports(config_in_port_idx)(output_slot_idx).config
        }else{
          io.output_ports(output_port_idx)(output_slot_idx).bits := DontCare
          io.output_ports(output_port_idx)(output_slot_idx).valid := DontCare
          io.output_ports(output_port_idx)(output_slot_idx).config := DontCare
        }
      }
      // backward connection
      for(input_port_idx <- 0 until num_input;
          input_slot_idx <- 0 until decomposer){
        io.input_ports(input_port_idx)(input_slot_idx).ready := DontCare
      }
    }
  }

  // Post process
  def postprocess(): Unit = {

  }
}

import cgra.IR.IRreader._

object gen_switch extends App{

  val cgra = readIR(args(0))

  val nodes = cgra("nodes")
    .asInstanceOf[List[mutable.Map[String,Any]]]

  for (node <- nodes){
    if(node("nodeType") == "switch"){
      // Add config input / output port for test
      val num_input = node("num_input").asInstanceOf[Int]
      val num_output = node("num_output").asInstanceOf[Int]

      node += "config_in_port_idx" -> (num_input - 1)

      val rand = new Random()
      if(rand.nextBoolean() && num_output == 1){
        node += "config_out_port_idx" -> List(0)
      }else{
        node += "config_out_port_idx" -> List(0, num_output - 1)
      }
      chisel3.Driver.execute(args,()=>{new switch(node)})
    }
  }

}