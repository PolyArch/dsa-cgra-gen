package cgra.component

import scala.math._
import chisel3.util._
import TestUtil.CgraTestUtil._
import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}

import scala.collection.mutable

object test_complex_switch extends App{

  // Config switch
  val node = mutable.Map[String, Any]()
  val id : Int = 13
  val max_id : Int = 59
  val data_width : Int = 64
  val granularity : Int = 16
  val decomposer = data_width / granularity
  val num_input : Int = 3
  val num_output : Int = 2
  val flow_control : Boolean = true
  val max_util : Int = 3
  val max_delay : Int = 4

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

  // Calculate the internal parameter
  private val num_config_bit = log2Ceil(max_util + 1)
  private val num_bits = data_width + num_config_bit
  private val num_id_bit = log2Ceil(max_id)
  private val num_source_sel_bit = log2Ceil(num_input + 1)
  private val num_offset_bit = log2Ceil(decomposer)
  private val num_tail_zero = num_bits -
    2 * num_config_bit - num_id_bit -
    num_output * (num_source_sel_bit + num_offset_bit)


  val testResult : Boolean= Driver(() =>
  new complex_switch(prop = node)){
    dut => new PeekPokeTester[complex_switch](dut) {
      var cycle : Int = 0;
      var config_message : BigInt = 0;
      // Enable this module
      poke(dut.io.en, true)

      // Construct config message
      config_message =
        BigInt(2) ||| (1,num_config_bit) ||| (id, num_id_bit) |||
          (2,num_source_sel_bit) ||| (2,num_source_sel_bit) |||
          (0,num_offset_bit) ||| (0, num_offset_bit) |||
          (982318734, num_tail_zero)

      // Test config switch
      poke(dut.io.input_ports(0).valid, true)
      poke(dut.io.input_ports(0).bits, config_message)

      move

      // Construct config message
      config_message =
        BigInt(1) ||| (1,num_config_bit) ||| (id, num_id_bit) |||
          (1,num_source_sel_bit) ||| (3,num_source_sel_bit) |||
          (0,num_offset_bit) ||| (0, num_offset_bit) |||
          (124124, num_tail_zero)

      // Test config switch
      poke(dut.io.input_ports(0).valid, true)
      poke(dut.io.input_ports(0).bits, config_message)

      move

      // ----- dataflow mode -----
      move(10)

      def feed_random_values : Boolean = {
        val input_values = for(_ <- 0 until num_input) yield {
          BigInt(0) ||| (BigInt(data_width, scala.util.Random),data_width)
        }
        val input_valids = for(_ <- 0 until num_input) yield {
          scala.util.Random.nextBoolean()
        }
        val output_readys = for(_ <- 0 until num_output) yield {
          scala.util.Random.nextBoolean()
        }
        for (input_idx <- 0 until num_input){
          poke(dut.io.input_ports(input_idx).valid,input_valids(input_idx))
          poke(dut.io.input_ports(input_idx).bits,input_values(input_idx))
        }
        for (output_idx <- 0 until num_output){
          poke(dut.io.output_ports(output_idx).ready,output_readys(output_idx))
        }
        true
      }

      def print_switch_io : Boolean = {
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
        println(s" ------------------------ Cycle $cycle" +
          s" ------------------------ ")
        step(1); cycle = cycle + 1
        // something that did every cycle
        print_switch_io
        feed_random_values
      }
      def move(step: Int) :Unit = {
        for(_ <- 0 until step){
          move
        }
      }
    }
  }
  assert(testResult)


}
