package cgra.fabric

import cgra.IO._
import chisel3.util._
import chisel3._
import dsl.IRPrintable
import scala.collection.mutable
import scala.util.Random
import cgra.config.fullinst._
import cgra.fabric.common.datapath.general_alu


class function_unit(prop:mutable.Map[String,Any])
  extends Module
    with IRPrintable{
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
  private val instructions : List[String] = getPropByKey("instructions")
    .asInstanceOf[List[String]]
  private val num_inst : Int = instructions.length
  private val num_register : Int =
    if(getPropByKey("num_register") != None)
    {getPropByKey("num_register").asInstanceOf[Int]}
    else {1}
  private val max_delay_fifo_depth : Int = getPropByKey("max_delay_fifo_depth")
    .asInstanceOf[Int]
  private val is_clt_control : Boolean = try{getPropByKey("clt_control")
    .asInstanceOf[Boolean]}catch{case _ : Throwable => false}

  // ------ Intermediate Variable ------
  // Calculate the ID field in incoming config bits
  private val id_field_high = data_width - 1
  apply("id_field_high", id_field_high)
  private val id_field_low = id_field_high - log2Ceil(max_id + 1) + 1
  apply("id_field_low", id_field_low)
  // the max number of operand for all instruction
  private val max_num_operand : Int =
    instructions.map(i=>insts_prop(i).numOperands).max
  apply("max_num_operand", max_num_operand)
  private val max_inst_latency : Int =
    instructions.map(i=>insts_prop(i).latency).max
  apply("max_inst_latency", max_inst_latency)

  // the total config bit width
  private val conf_bit_width : Int = log2Ceil(num_inst) + max_num_operand *
    (log2Ceil(max_delay_fifo_depth + 1) + log2Ceil(num_register + num_input))
  // config width for opcode, (delay fifo + source select) for each operand
  apply("conf_bit_width", conf_bit_width)

  // generate the config bit range
  // three things need to be controlled: alu (opcode), delay fifo, operand mux
  private var curr_low_bit : Int = 0
  private var curr_high_bit : Int = curr_low_bit
  if(num_inst > 1){
    val opcode_bit_width : Int = log2Ceil(num_inst)
    curr_high_bit = curr_low_bit + opcode_bit_width - 1
    apply("opcode_bit_range", (curr_high_bit, curr_low_bit))
    curr_low_bit = curr_high_bit + 1
  }
  // for each operand
  for (op_idx <- 0 until max_num_operand){
    // delay fifo
    val delay_fifo_width = log2Ceil(max_delay_fifo_depth + 1)
    curr_high_bit = curr_low_bit + delay_fifo_width - 1
    apply("delay_" + op_idx, (curr_high_bit, curr_low_bit))
    curr_low_bit = curr_high_bit + 1
    // source select
    val source_select_width = log2Ceil(num_register + num_input)
    curr_high_bit = curr_low_bit + source_select_width - 1
    apply("source_" + op_idx, (curr_high_bit, curr_low_bit))
    curr_low_bit = curr_high_bit + 1
  }

  private val operand_select_map : mutable.Map[Int, String] =
    mutable.Map[Int,String]()
  for (in_idx <- 0 until num_input){
    operand_select_map += in_idx -> ("in-port_" + in_idx)
  }
  for (reg_idx <- 0 until num_register){
    operand_select_map += (reg_idx + num_input) -> ("reg_" + reg_idx)
  }
  apply("operand_sel2source", operand_select_map)

  // instruction encoding (get opcode)
  private val inst2enc = mutable.Map[String,Int]()
  private val enc2inst = mutable.Map[Int,String]()
  for(inst <- instructions) {
    inst2enc += inst -> instructions.indexOf(inst)
    enc2inst += instructions.indexOf(inst) -> inst
  }
  apply("inst2enc", inst2enc)
  apply("enc2inst", enc2inst)

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
  val decomposed_out_ports = Wire(Vec(num_output, Vec(decomposer, ReqAckConf_t(granularity))))
  for (port_idx <- 0 until num_output){
    val config_bit_out = VecInit(decomposed_out_ports(port_idx).map(_.config))
      .asUInt().andR()
    io.output_ports(port_idx).bits := Cat(config_bit_out,decomposed_out_ports(port_idx)
      .map(_.bits).reverse.reduce(Cat(_,_)))
    io.output_ports(port_idx).valid :=
      VecInit(decomposed_out_ports(port_idx).map(_.valid)).asUInt().andR()
    decomposed_out_ports(port_idx).foreach(p=>p.ready := io.output_ports(port_idx).ready)
  }

  // Create register file, each fu will have at least one register (acc)
  val register_file : Vec[UInt] =
    RegInit(VecInit(Seq.fill(num_register)(0.U(data_width.W))))

  // Create shared configuration slot
  val config_slot_file : Vec[UInt] =
    RegInit(VecInit(Seq.fill(max_util)(0.U(conf_bit_width.W))))

  // Create configuration wire
  val config_wire : UInt =
    WireInit(0.U(conf_bit_width.W))

  // Create config select pointer
  val config_select_pointer : UInt = if(max_util > 1){
    RegInit(0.U(log2Ceil(max_util).W))
  }else{
    0.U
  }

  // extract the incoming config information from config in port
  val config_port_bits : UInt = decomposed_in_ports(config_in_port_idx).map(_.bits)
    .reverse.reduce(Cat(_,_))

  // Create opcode select wire
  val opcode_select : UInt = Wire(UInt(log2Ceil(max_num_operand).W))
  opcode_select := 0.U

  // Create operands wire, and its control protocol
  val operands : Vec[UInt] =
    WireInit(VecInit(Seq.fill(max_num_operand)(0.U(data_width.W))))
  val operands_valid : Vec[Bool] =
    WireInit(VecInit(Seq.fill(max_num_operand)(true.B)))
  val operands_ready : Vec[Bool] =
    WireInit(VecInit(Seq.fill(max_num_operand)(true.B)))

  // Create output result
  val output_result : UInt = WireInit(0.U(data_width.W))
  val output_valid : Bool = WireInit(false.B)
  val output_ready : Bool = WireInit(true.B)

  // Create config enable
  val config_enable : Bool = VecInit(decomposed_in_ports(config_in_port_idx)
    .map(_.config)).asUInt().andR()

  // Create delay pipe/fifo
  val delays_module = Array.fill(max_num_operand)(
    Module(new delay(data_width, max_delay_fifo_depth, flow_control)).io
  )

  // Create ALU module
  val alu_module = Module(new general_alu(prop)).io
  // extract all needed bits, valid, ready
  val alu_operands : Seq[UInt] = delays_module.map(_.out.bits)
  val alu_operands_valid = delays_module.map(_.out.valid)
  val alu_operands_ready = delays_module.map(_.out.ready)

  // Create operands select
  val operands_sel : IndexedSeq[UInt] = for(op_idx <- 0 until max_num_operand)
    yield{
      val source_bit_range = getPropByKey("source_" + op_idx)
        .asInstanceOf[(Int,Int)]
      config_wire(source_bit_range._1, source_bit_range._2)
    }

  // data stream
  // Config selection
  config_wire := config_slot_file(config_select_pointer)

  // update the pointer
  if(max_util > 1){
    config_select_pointer := config_select_pointer + 1.U
  }

  // operands selection, forward connect (bits and valid)
  for(op_idx <- 0 until max_num_operand){
    val source_bit_range = getPropByKey("source_" + op_idx)
      .asInstanceOf[(Int,Int)]
    val sel = operands_sel(op_idx)
    // select value to data bits
    val sel2value : Seq[(UInt,UInt)] =
      for(sel_value <- 0 until num_input + num_register)yield{
        val source : Array[String] = operand_select_map(sel_value).split("_")
        val source_type : String = source(0)
        val source_idx : Int = source(1).toInt
        val bits = source_type match {
          case "in-port" =>
            decomposed_in_ports(source_idx).map(_.bits).reverse.reduce(Cat(_,_))
          case "reg" =>
            register_file(source_idx)
        }
        (sel_value.U,bits)
      }
    // mux incoming data bits
    operands(op_idx) := MuxLookup(sel, 0.U, sel2value)
    // if flow control, add valid

    // mux incoming data valid
    val sel2valid : Seq[(UInt,Bool)] =
      for(sel_value <- 0 until num_input + num_register)yield{
        val source : Array[String] = operand_select_map(sel_value).split("_")
        val source_type : String = source(0)
        val source_idx : Int = source(1).toInt
        val valid = source_type match {
          case "in-port" =>
            VecInit(decomposed_in_ports(source_idx).map(_.valid)).asUInt().andR()
          case "reg" =>
            true.B
        }
        (sel_value.U,valid)
      }
    operands_valid(op_idx) := MuxLookup(sel,false.B,sel2valid)

  }

  // back-pressure, connect ready bit
  for(i <- 0 until num_input;j <- 0 until decomposer) {
    if(flow_control){
      decomposed_in_ports(i)(j).ready := VecInit({
        for (op_idx <- 0 until max_num_operand) yield {
          Mux(operands_sel(op_idx) === i.U,operands_ready(op_idx),true.B)
        }
      }).asUInt().andR()
    }else{
      decomposed_in_ports(i)(j).ready := true.B
    }
  }

  private val clt_enable = WireInit(false.B)
  // Adding CLT to complete merge and join
  if(flow_control && is_clt_control){
    if(instructions.exists(is_clt_stream_instruction)){
      // Determine whether the current is a stream-merge / Join command
      clt_enable := VecInit(instructions.filter(is_clt_stream_instruction).map(
        inst => {opcode_select === instructions.indexOf(inst).U}
      )).asUInt().orR()
    }
  }else{
    clt_enable := DontCare
  }


  // get opcode
  if(num_inst > 1){
    val opcode_bit_range = getPropByKey("opcode_bit_range")
      .asInstanceOf[(Int,Int)]
    opcode_select := config_wire(opcode_bit_range._1,opcode_bit_range._2)
  }

  // connect delay all the time
  // delay configure
  for (op_idx <- 0 until max_num_operand){
    // Extract the control bit range for delay
    val delay_bit_range = getPropByKey("delay_" + op_idx)
      .asInstanceOf[(Int,Int)]
    // connect config bit
    delays_module(op_idx).delay := config_wire(delay_bit_range._1,delay_bit_range._2)
    // connect bits
    delays_module(op_idx).in.bits := operands(op_idx)
    // connect flow control logic
    delays_module(op_idx).in.valid := operands_valid(op_idx)
    operands_ready(op_idx) := delays_module(op_idx).in.ready
  }

  // Arithmetic Connection
  alu_module.opcode := opcode_select
  for (idx <- 0 until max_num_operand) {
    alu_module.operands(idx).bits := alu_operands(idx)
    alu_module.operands(idx).valid := alu_operands_valid(idx)
    alu_operands_ready(idx) := Mux(clt_enable,
      if(idx == 0){
        alu_operands(0) <= alu_operands(1)
      }else{
        alu_operands(1) <= alu_operands(0)
      },
      alu_module.operands(idx).ready)
  }
  output_result := alu_module.result.bits
  output_valid := alu_module.result.valid
  alu_module.result.ready := output_ready

  // Output
  for(out_port <- 0 until num_output;
      out_slot <- 0 until decomposer){
    decomposed_out_ports(out_port)(out_slot).bits := output_result(
      (out_slot + 1) * granularity - 1, out_slot * granularity
    )
    decomposed_out_ports(out_port)(out_slot).valid := output_valid
    decomposed_out_ports(out_port)(out_slot).config := config_enable
  }
  output_ready := decomposed_out_ports
    .map(s=>s.map(_.ready).reduce(_ && _)).reduce(_ && _)

  // When not Configured
  when(config_enable){
    // fu is being reset (reconfigured)
    // Get the ID field of the incoming information
    val id_bits = config_port_bits(id_field_high, id_field_low)

    // config this module
    val config_this = id_bits === id.U
    var useful_config_info_high = id_field_low - 1
    val useful_config_info_low = 0

    // When actually config this module
    when(config_this){

      // config the slot file
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

        // write it into the config slot files
        config_slot_file(toUpdated_config_ptr) := config_port_bits

        // Add into IR
        apply("useful_config_info_high", useful_config_info_high)
        apply("useful_config_info_low", useful_config_info_low)
        apply("conf_bit_high", conf_bit_width - 1)
        apply("conf_bit_low", useful_config_info_low)

      }else{
        // The needed config bit range need to be smaller than useful config
        val useful_config_width = useful_config_info_high - useful_config_info_low + 1
        // require(useful_config_width >= conf_bit_width)

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

    }otherwise{
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

  print(this)
  // ------ Post process ------
  override def postprocess(): Unit = {
    print(this)
  }

  // ------ Util ------
  private def is_clt_stream_instruction(i:String): Boolean = {
    // Determine whether instruction is need by
    // Stream-Merge and Join
    i.contains("Eq") | i.contains("EQ") | i.contains("eq") |
      i.contains("NE") | i.contains("Ne") | i.contains("ne") |
      i.contains("Ge") | i.contains("GE") | i.contains("ge") |
      i.contains("Le") | i.contains("LE") | i.contains("le") |
      i.contains("Cmp")
  }
}

import cgra.IR.IRreader._

object gen_fu extends App{

  val cgra = readIR(args(0))

  val nodes = cgra("nodes")
    .asInstanceOf[List[mutable.Map[String,Any]]]

  for (node <- nodes){
    if(node("nodeType") == "function unit"){

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

      // Add random instructions for test
      /*
      val all_insts :List[String] = inst_operation.keys.toList
      val random_insts : List[String] = Random.shuffle(all_insts)
      node += "instructions" -> random_insts.slice(0,1 + Random.nextInt(all_insts.length))
      */

      // Test for CLT
      node += "clt_control" -> true
      node += "flow_control" -> true
      node += "instructions" -> List("ICmp32" ,"GE")

      // Initialize the Function Unit
      chisel3.Driver.execute(args,()=>{
        val module = new function_unit(node)
        println(module)
        module
      })
    }
  }
}