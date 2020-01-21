package cgra.fabric

import cgra.IO._
import cgra.component.{complex_fu, complex_switch}
import dsl.IRPrintable
import chisel3._

import scala.collection.mutable
import cgra.config.encoding._
import chisel3.util._

class cgra_fabric(prop:mutable.Map[String, Any]) extends Module
  with IRPrintable {
  // add the initial property
  apply(prop)

  // Extract External Parameter
  private val data_width = 1 + 64//getPropByKey("data_width").asInstanceOf[Int]
  private val nodes = getPropByKey("nodes").asInstanceOf[List[mutable.Map[String,Any]]]
  private val links = getPropByKey("links").asInstanceOf[List[mutable.Map[String,List[Any]]]]

  // Derived Parameter
  // Calculate config width for Nodes who need config input
  private val allVpNodes = nodes
    .filter(node => node("nodeType") == "vector port")
  private val id2vp_info = for (vp <- allVpNodes) yield {
    val id = vp("id").asInstanceOf[Int]
    val num_inport = vp("num_input").asInstanceOf[Int]
    val num_outport = vp("num_output").asInstanceOf[Int]
    val num_port = num_inport max num_outport
    (id, num_port, num_inport < num_outport, num_port * log2Ceil(num_port))
  }
  // In/Output_vps (id, num_port, is_input)
  private val input_vps = id2vp_info.filter(_._3)
  private val output_vps = id2vp_info.filter(!_._3)
  private val vps_config_width : List[Int] = id2vp_info.map(_._4)

  println("End Parameterize")

  // ------ Pre-process ------
  for (node <- nodes){
    node += "max_id" -> nodes.size
  }

  // ------ Create Hardware ------

  // Create the I/O port
  val io = IO(new Bundle{
    val input_ports = MixedVec(input_vps.map(vp=>{
      Flipped(DecoupledIO(UInt( (vp._2 * data_width).W )))
    }))
    val output_ports = MixedVec(output_vps.map(vp=>{
      DecoupledIO(UInt( (vp._2 * data_width).W ))
    }))
    val config = MixedVec(vps_config_width.map(w=>Flipped(ValidIO(UInt(w.W)))))
  })

  // Create the Module
  val nodes_module : Map[Int,EnabledVecDecoupledIO]= nodes.map(node => {
    val node_id = node("id").asInstanceOf[Int]
    val nodeType = node("nodeType").toString
    node_id -> (nodeType match {
      case "switch" => Module(new complex_switch(node)).io
      case "function unit" => Module(new complex_fu(node)).io
      case "vector port" => Module(new vector_port(node)).io
    })
  }).toMap

  // Connect Everything Up
  var source_port_idx : Int = -1
  var sink_port_idx : Int = -1
  for (link <- links){
    println(link)
    val source_id = link("source").head.asInstanceOf[Int]
    val sink_id = link("sink").head.asInstanceOf[Int]
    var source_port_idx_seq : Seq[Seq[Any]] = null
    var sink_port_idx_seq : Seq[Seq[Any]]= null
    // find the source port index
    for (node <- nodes){
      if(node("id") == source_id){
        for(node_sink <- nodes){
          if(node_sink("id") == sink_id){
            val source_output_nodes = node("output_nodes").asInstanceOf[Seq[Seq[Any]]]
            val sink_input_nodes = node_sink("input_nodes").asInstanceOf[Seq[Seq[Any]]]

            source_port_idx_seq = source_output_nodes.filter(x=>{x.head.toString.toInt == sink_id})
            sink_port_idx_seq = sink_input_nodes.filter(y=>{y.head.toString.toInt == source_id})
            source_port_idx = source_output_nodes.indexWhere(x=>{x.head.toString.toInt == sink_id})
            sink_port_idx = sink_input_nodes.indexWhere(y=>{y.head.toString.toInt == source_id})
            if(source_port_idx_seq.length > 1){
              println(source_port_idx_seq)
              require(false)
              println("same nodes double link here")
            }
            if(sink_port_idx_seq.length > 1){
              println(sink_port_idx_seq)
              require(false)
              println("same nodes double link here")
            }
            println("source port index = " + source_port_idx)
            println("sink port index = " + sink_port_idx)
          }
        }
      }
    }

    require(source_port_idx_seq.length == sink_port_idx_seq.length)

    for ( idx <- 0 until source_port_idx_seq.length){
      val source_port_idx = source_port_idx_seq(idx).head.toString.toInt
      val sink_port_idx = sink_port_idx_seq(idx).head.toString.toInt
      val sink_bw = nodes_module(sink_id).input_ports(sink_port_idx).bits.getWidth
      val source_bw = nodes_module(source_id).output_ports(source_port_idx).bits.getWidth

      if(source_bw <= sink_bw){
        nodes_module(sink_id).input_ports(sink_port_idx) <>
          nodes_module(source_id).output_ports(source_port_idx)
      }else {
        // Valid & Ready
        nodes_module(sink_id).input_ports(sink_port_idx).valid :=
          nodes_module(source_id).output_ports(source_port_idx).valid
        nodes_module(source_id).output_ports(source_port_idx).ready :=
          nodes_module(sink_id).input_ports(sink_port_idx).ready
        // Bits
        val source_bits = nodes_module(source_id).output_ports(source_port_idx).bits
        val source_config_bits = source_bits(source_bw - 1)
        val source_info_bits = source_bits(sink_bw - 2, 0)
        nodes_module(sink_id).input_ports(sink_port_idx).bits :=
          Cat(source_config_bits, source_info_bits)
      }
    }
  }

  // Connect the Config Port
  for(id2conf <- id2vp_info){
    val id = id2conf._1
    val vp_idx = id2vp_info.indexOf(id2conf)
    val vector_port = nodes_module(id).asInstanceOf[VecDecoupledIO_conf]
    vector_port.config <> io.config(vp_idx)
  }

  // Connect the IO
  // Input
  for (vp <- input_vps){
    val id = vp._1
    val vec_idx = input_vps.indexOf(vp)
    val num_port = vp._2
    val vp_module = nodes_module(id)
    // Bits & Valid
    for(port_idx <- 0 until num_port){
      vp_module.input_ports(port_idx).bits :=
        io.input_ports(vec_idx)
          .bits((port_idx+1)*data_width-1, port_idx * data_width)
      vp_module.input_ports(port_idx).valid :=
        DontCare//io.input_ports(vec_idx).valid
    }
    // Ready
    io.input_ports(vec_idx).ready :=
      VecInit(vp_module.input_ports.map(_.ready)).asUInt().orR()
  }
  // Output
  for (vp <- output_vps){
    val id = vp._1
    val vec_idx = output_vps.indexOf(vp)
    val num_port = vp._2
    val vp_module = nodes_module(id)
    // Ready
    for(port_idx <- 0 until num_port){
      vp_module.output_ports(port_idx).ready :=
        io.output_ports(vec_idx).ready
    }
    // Bits & Valid
    io.output_ports(vec_idx).bits :=
      vp_module.output_ports.map(_.bits).reverse.reduce(Cat(_,_))
    io.output_ports(vec_idx).valid :=
      VecInit(vp_module.output_ports.map(_.valid)).asUInt().orR()
  }


  override def postprocess(): Unit = print(this)
}

import cgra.IR.IRreader.readIR

object gen_cgra extends App{

  val cgra = readIR(args(0))

  chisel3.Driver.execute(args,()=>{
    val module = new cgra_fabric(cgra)
    println(module)
    module
  })

}