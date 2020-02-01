package cgra.component

import scala.math._
import chisel3._
import chisel3.util._
import TestUtil.CgraTestUtil._
import cgra.config.fullinst.insts_prop
import chisel3.iotesters.{Driver, PeekPokeTester}
import scala.util.Random._
import scala.collection.mutable

object test_complex_fu extends App{

  // Config fu
  val node = mutable.Map[String, Any]()
  val id : Int = 13
  val max_id : Int = 59
  val data_width : Int = 64
  val granularity : Int = 16
  val decomposer = data_width / granularity
  val num_input : Int = 3
  val num_output : Int = 2
  val flow_control : Boolean = false
  val max_util : Int = 4
  val max_delay : Int = 4
  val instructions : List[String] =
    List("Add", "Sub", "Mul", "Div",
      "BOr", "BAnd", "BXor", "BNot",
      "FMul64", "FAdd64")
  val config_in_port_idx = 0
  val config_out_port_idx = List(0)

  node("id") = id
  node("max_id") = max_id
  node("data_width") = data_width
  node("granularity") = granularity
  node("num_input") = num_input
  node("num_output") = num_output
  node("flow_control") = flow_control
  node("max_util") = max_util
  node("max_delay") = max_delay
  node("config_in_port_idx") = 0
  node("config_out_port_idx") = List(0)
  node("instructions") = instructions

  // Numeric / Config ratio
  val reconfig_every_num_cycle = 20

  // Calculate the internal parameter
  private val num_bits = data_width + 1 // One more for config control bit
  private val num_config_index_bit = log2Ceil(max_util)
  private val num_curr_util_bit = log2Ceil(max_util)
  private val num_id_bit = log2Ceil(max_id)
  private val num_opcode : Int = instructions.distinct.length
  private val max_num_operand : Int =
    instructions.map(insts_prop(_).numOperands) max
  private val num_operand_sel_bit : Int = log2Ceil(num_input + 1) // One more for Zero
  private val num_delay_sel_bit : Int = if(!flow_control){
    log2Ceil(max_delay + 1)
  }else{
    0
  }
  private val num_opcode_bit : Int = log2Ceil(num_opcode + 1) // One more for Pass
  private val num_offset_bit : Int = log2Ceil(decomposer)
  private val num_output_bit : Int = log2Ceil(num_output + 1) // One more for Zero

  private val num_tail_zero = data_width -
    num_config_index_bit - num_curr_util_bit - num_id_bit -
    max_num_operand * (num_operand_sel_bit + num_delay_sel_bit) -
    num_opcode_bit - num_offset_bit - num_output_bit

  val testResult : Boolean= Driver.execute(args, () =>
    new complex_fu(prop = node)){
    dut => new PeekPokeTester[complex_fu](dut) {
      var cycle : Int = 0
      val total_cycle = 500
      var config_message : BigInt = 0;

      move(total_cycle)

      def feed_random_values : Boolean = {
        // Turn off Module
        if(cycle % 100 == 0)
          poke(dut.io.en, false)
        else
          poke(dut.io.en, true)

        // Generate Random Bits
        val input_values = for(input_idx <- 0 until num_input) yield {
          if(cycle % reconfig_every_num_cycle == 0 &&
            input_idx == config_in_port_idx)
            generate_random_config_message
          else
            generate_random_numeric_value
        }
        val input_valids = for(input_idx <- 0 until num_input) yield {
          if(cycle % reconfig_every_num_cycle == 0 &&
            input_idx == config_in_port_idx)
            true
          else
            nextBoolean()
        }
        val output_readys = for(_ <- 0 until num_output) yield {
            nextBoolean()
        }

        // Invoke them @ Input ports
        for (input_idx <- 0 until num_input){
          poke(dut.io.input_ports(input_idx).valid,input_valids(input_idx))
          poke(dut.io.input_ports(input_idx).bits,input_values(input_idx))
        }
        for (output_idx <- 0 until num_output){
          poke(dut.io.output_ports(output_idx).ready,output_readys(output_idx))
        }
        true
      }

      def print_io : Boolean = {
        println("---- Input ----")
        for (idx <- 0 until num_input){
          val port = peek(dut.io.input_ports(idx))
          println(s"input ${idx} - " +
            port.map(c=> c._1 + " : " + c._2).reduceLeft(_ + ", " + _))
        }
        println("---- Output ----")
        for (idx <- 0 until num_output){
          val port = peek(dut.io.output_ports(idx))
          println(s"output ${idx} - " +
            port.map(c=> c._1 + " : " + c._2).reduceLeft(_ + ", " + _))
        }
        true
      }

      def move : Unit = {
        step(1); cycle = cycle + 1
        // something that did every cycle
        // print_io
        feed_random_values

        if(cycle % (total_cycle / 50) == 0)
          println(s"Simulation Progress = ${100 * cycle / total_cycle.toDouble}%")
      }
      def move(step: Int) :Unit = {
        for(_ <- 0 until step){
          move
        }
      }
    }
  }
  assert(testResult)



  def generate_random_numeric_value: BigInt = {
    val nxt_val : BigInt = BigInt(data_width, scala.util.Random)
    BigInt(0) ||| (nxt_val,data_width)
  }
  def generate_random_config_message = {
    // Construct config message
    val config_message = {
      val curr_util = nextInt(max_util)
      val config_index = nextInt(curr_util + 1)
      val random_id_offset = nextInt(5) - 3
      val random_opcode = nextInt(num_opcode + 1)
      val random_decomposer = nextInt(decomposer)
      val random_output = nextInt(num_output + 1)

      BigInt(1) ||| (config_index,num_config_index_bit) |||
        (curr_util,num_curr_util_bit) |||
        (id, num_id_bit) |*|
        (max_num_operand, max_num_operand, num_operand_sel_bit, false) |*| //
        (max_delay + 1, max_num_operand, num_delay_sel_bit, true) |||
        (random_opcode, num_opcode_bit) |||
        (random_decomposer, num_offset_bit) |||
        (random_output, num_output_bit) |||
        ("1111111111111111111111111111111", num_tail_zero)
    }
    config_message
  }
}
