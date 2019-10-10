package cgra.fabric

import cgra.IO._
import chisel3.util._
import chisel3._
import dsl.IRPrintable
import scala.collection.mutable
import scala.util.Random

class switch(prop:mutable.Map[String,Any]) extends Module with IRPrintable{
  // Assign initial properties
  apply(prop)

  // ------ Reconfigurable Variable------

  // Initialize the properties of switch (hardware)
  private val id = getValue(getPropByKey("id")).asInstanceOf[Int]
  private val max_id = getPropByKey("max_id").asInstanceOf[Int]
  private val data_width:Int = getPropByKey("data_width").asInstanceOf[Int]
  private val granularity = getPropByKey("granularity").asInstanceOf[Int]
  private val num_input:Int = getPropByKey("num_input").asInstanceOf[Int]
  private val num_output:Int = getPropByKey("num_output").asInstanceOf[Int]
  private val flow_control:Boolean = getPropByKey("flow_control").asInstanceOf[Boolean]
  private val max_util:Int = getPropByKey("max_util").asInstanceOf[Int]
  private val decomposer:Int = data_width / granularity
  private val config_in_port_idx:Int = getPropByKey("config_in_port_idx")
    .asInstanceOf[Int]
  private val config_out_port_idx:List[Int] = try{getPropByKey("config_out_port_idx")
    .asInstanceOf[List[Int]]}catch{case _:Throwable => Nil}
  private val subnet_table:List[List[Boolean]] =
    getPropByKey("subnet_table").asInstanceOf[List[List[Boolean]]]
  private val switch_mode:String = getPropByKey("switch_mode").toString

  // Calculate the number of configuration
  private val output_slot2num_conf : Map[(Int,Int),Int] = {for (
    port_idx <- 0 until num_output;
    slot_idx <- 0 until decomposer)yield{
    val output_slot_idx = port_idx * decomposer + slot_idx
    switch_mode match {
      case "full-control" =>
        (port_idx, slot_idx) -> subnet_table(output_slot_idx).count(c=>c)
      case "group-by-port" =>
        (port_idx, slot_idx) -> subnet_table(output_slot_idx).count(c=>c)
    }
  }}.toMap

  // Calculate the ID field in incoming config bits
  private val id_field_high = data_width - 1
  apply("id_field_high", id_field_high)
  private val id_field_low = id_field_high - log2Ceil(max_id + 1) + 1
  apply("id_field_low", id_field_low)

  // Calculate the bit range of configuration
  // conf_bit_range :
  // (output_port_idx, output_slot_idx) -> (config_high, config_low)
  private var curr_bit = 0
  private val conf_bit_range : Map[(Int,Int),(Int,Int)]={
    switch_mode match {
      case "full-control" => {
        for(output_port_idx <- 0 until num_output;
            output_slot_idx <- 0 until decomposer)yield{
          val num_conf = output_slot2num_conf((output_port_idx, output_slot_idx))
          val num_bits = log2Ceil(num_conf + 1) // 0 leave for default
          val bit_range = (curr_bit + num_bits - 1, curr_bit)
          curr_bit += num_bits
          (output_port_idx, output_slot_idx) -> bit_range
        }
        }.toMap
      case "group-by-port" => {
        for(output_port_idx <- 0 until num_output;
            output_slot_idx <- 0 until decomposer)yield{
          val num_conf = output_slot2num_conf((output_port_idx,0))
          val num_bits = log2Ceil(num_conf + 1)
          val bit_range = (curr_bit + num_bits - 1, curr_bit)
          if(output_slot_idx == decomposer - 1){
            curr_bit += num_bits
          }
          (output_port_idx, output_slot_idx) -> bit_range
        }
        }.toMap
    }
  }

  // Add conf_bit_range to properties
  private val prop_conf_bit_range :Map[String,(Int,Int)] = conf_bit_range.toSeq.map(kv=>{
    (kv._1._1 + "_" + kv._1._2) -> kv._2
  }).toMap
  apply("port_slot_config_bit_range", prop_conf_bit_range)

  private val conf_bit_width : Int = conf_bit_range.map(_._2._1).max + 1
  apply("config_bit_width", conf_bit_width)

  // ------ Create Hardware ------

  // Initialize the I/O port
  val io = IO(new VecDecoupledIO(num_input,num_output,data_width+1))

  // De-compose I/O ports
  // In
  val decomposed_in_ports = Wire(Vec(num_input, Vec(decomposer, ReqAckConf_t(granularity))))
  for (port_idx <- 0 until num_input; slot_idx <- 0 until decomposer){
    decomposed_in_ports(port_idx)(slot_idx).bits :=
      io.input_ports(port_idx).bits((slot_idx+1)*granularity -1 ,slot_idx * granularity)
    decomposed_in_ports(port_idx)(slot_idx).valid := io.input_ports(port_idx).valid
    io.input_ports(port_idx).ready := decomposed_in_ports(port_idx)(slot_idx).ready
    decomposed_in_ports(port_idx)(slot_idx).config := io.input_ports(port_idx).bits(data_width)
  }

  // Out
  val decomposed_out_ports = Reg(Vec(num_output, Vec(decomposer, ReqAckConf_t(granularity))))
  for (port_idx <- 0 until num_output){
    val config_bit_out = VecInit(decomposed_out_ports(port_idx).map(_.config))
      .asUInt().andR()
    io.output_ports(port_idx).bits := Cat(config_bit_out,decomposed_out_ports(port_idx)
      .map(_.bits).reverse.reduce(Cat(_,_)))
    io.output_ports(port_idx).valid :=
      VecInit(decomposed_out_ports(port_idx).map(_.valid)).asUInt().andR()
    decomposed_out_ports(port_idx).foreach(p=>p.ready := io.output_ports(port_idx).ready)
  }

  // Generate the configuration register
  val config_slot_file = RegInit(VecInit(Seq.fill(max_util)(0.U(conf_bit_width.W))))

  // Config Enable
  val config_enable : Bool = io.input_ports(config_in_port_idx).bits(data_width)

  // config wire
  val config_wire :UInt = WireInit(0.U(conf_bit_width.W))

  // extract the incoming config information from config in port
  val config_port_bits : UInt = io.input_ports(config_in_port_idx)
    .bits(data_width-1,0)

  // ------ Hardware Logic ------

  // Multiple configurations
  if(max_util == 1){
    config_wire := config_slot_file(0)
  }else{
    // configuration counter
    val config_pointer = RegInit(0.U(log2Ceil(max_util).W))

    // select which config to enable
    config_pointer := config_pointer + 1.U

    // select it to wire
    config_wire := config_slot_file(config_pointer)
  }

  // Mux (forward)
  val port_slot_sel2_port_slot = mutable.Map[(Int,Int),
    mutable.Map[Int,(Int,Int)]]()
  for(output_port_idx <- 0 until num_output;
      output_slot_idx <- 0 until decomposer){
    val slot_idx = output_port_idx * decomposer + output_slot_idx
    val slot_config_bit_range = conf_bit_range(output_port_idx,output_slot_idx)
    val config_high_bit = slot_config_bit_range._1
    val config_low_bit = slot_config_bit_range._2
    require(config_high_bit >= config_low_bit)
    val config_reg_value = config_wire(config_high_bit, config_low_bit)

    // Mux port mapping: This slot connected (input_port, input_slot)
    val connected_input : List[(Int, Int)] = subnet_table(slot_idx)
      .zipWithIndex.filter(conn_idx => conn_idx._1
    ).map(conn_idx => (conn_idx._2 / decomposer, conn_idx._2 % decomposer))

    // Mux selection
    val sel2port_slot = mutable.Map[Int,(Int,Int)]()
    val portMuxLookup = for (sel <- connected_input.indices) yield {
      val input_port_slot = connected_input(sel)
      sel2port_slot += (sel + 1) -> (input_port_slot._1,input_port_slot._2)
      (sel + 1).U -> // selection value = 0 is left for default
        decomposed_in_ports(input_port_slot._1)(input_port_slot._2)
    }

    // Add Mux selection to properties
    port_slot_sel2_port_slot += (output_port_idx, output_slot_idx) ->
      sel2port_slot

    // bit connection
    decomposed_out_ports(output_port_idx)(output_slot_idx).bits := MuxLookup(
      config_reg_value, 0.U, portMuxLookup.map(x=>(x._1,x._2.bits)))

    // control flow connection
    if(flow_control){
      decomposed_out_ports(output_port_idx)(output_slot_idx).valid := MuxLookup(
        config_reg_value, 0.U, portMuxLookup.map(x=>(x._1,x._2.valid)))
    }else{
      decomposed_out_ports(output_port_idx)(output_slot_idx).valid := DontCare
    }

    // don't care configuration when stream mode
    decomposed_out_ports(output_port_idx)(output_slot_idx).config := DontCare
  }

  // Add this into properties
  val prop_port_slot_sel2_port_slot = port_slot_sel2_port_slot.toSeq
    .map(kv => {
      (kv._1._1 + "_" + kv._1._2) -> kv._2
    }).toMap
  apply("MUX_table",prop_port_slot_sel2_port_slot)

  // Mux (backward)
  for(input_port_idx <- 0 until num_input;
      input_slot_idx <- 0 until decomposer){
    if(flow_control){
      // Find the location of this slot
      val slot_idx = input_port_idx * decomposer + input_slot_idx
      // Which output slots it connected to
      val connected_output_slot_idx = subnet_table.map(o=>o(slot_idx))
        .zipWithIndex.filter(x=>x._1).map(x=>(x._2 / decomposer, x._2 % decomposer))
      // Find what is the select value for each output port to select this input
      val sel_input_value_foreach_output = connected_output_slot_idx
        .map(x=>{
          val sel2this_slot =
            port_slot_sel2_port_slot(x._1,x._2)
              .filter(sel2slot =>
                sel2slot._2 == (input_port_idx, input_slot_idx))
          if(sel2this_slot.size != 1){
            require(sel2this_slot.size == 1, "only one value can select to this slot")
          }
          sel2this_slot.head._1
        }
        )
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
          val output_port_idx = o_slot_idx._1
          val output_slot_idx = o_slot_idx._2
          val is_select = sel_input_value_foreach_output(idx).U ===
            sel_reg_foreach_output(idx)
          Mux(is_select,decomposed_out_ports(output_port_idx)(output_slot_idx).ready,
            true.B)
        }
      // AND all downstream ready, then pass to upstream
      val overall_downstream_ready = downstream_readys.reduce(_ && _)
      decomposed_in_ports(input_port_idx)(input_slot_idx).ready :=
        overall_downstream_ready
    }else{
      decomposed_in_ports(input_port_idx)(input_slot_idx).ready := DontCare
    }
  }// End of backward ready connection

  when(config_enable){// Stream: When switch is not being configured{// When it is during configuration time

    // Get the ID field of the incoming information
    val id_bits = config_port_bits(id_field_high, id_field_low)

    // config this module
    val config_this = id_bits === id.U

    var useful_config_info_high = id_field_low - 1
    val useful_config_info_low = 0
    when(config_this){

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

        config_slot_file(toUpdated_config_ptr) := config_port_bits

        // Add into IR
        apply("useful_config_info_high", useful_config_info_high)
        apply("useful_config_info_low", useful_config_info_low)
        apply("conf_bit_high", conf_bit_width - 1)
        apply("conf_bit_low", useful_config_info_low)
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
        config_slot_file.head := config_port_bits

        // Add into IR
        apply("useful_config_info_high", useful_config_info_high)
        apply("useful_config_info_low", useful_config_info_low)
        apply("conf_bit_high", conf_bit_width - 1)
        apply("conf_bit_low", useful_config_info_low)
      }
    }.otherwise{
      // configuration for other nodes, pass it to them
      // forward connection
      for(output_port_idx <- 0 until num_output;
          output_slot_idx <- 0 until decomposer){
        if(config_out_port_idx.contains(output_port_idx)){
          // match slot connection
          decomposed_out_ports(output_port_idx)(output_slot_idx).bits :=
            decomposed_in_ports(config_in_port_idx)(output_slot_idx).bits
          decomposed_out_ports(output_port_idx)(output_slot_idx).valid :=
            decomposed_in_ports(config_in_port_idx)(output_slot_idx).valid
          decomposed_out_ports(output_port_idx)(output_slot_idx).config :=
            decomposed_in_ports(config_in_port_idx)(output_slot_idx).config
        }
      }
    }
  }

  // Post process
  def postprocess(): Unit = {
    print(this)
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

      chisel3.Driver.execute(args,()=>{
        val module = new switch(node)
        println(module)
        module
      })
    }
  }
}