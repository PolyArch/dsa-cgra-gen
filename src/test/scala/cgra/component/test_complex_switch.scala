package cgra.component

import scala.math._
import chisel3.util._
import TestUtil.CgraTestUtil._
import chisel3.iotesters.{PeekPokeTester, Driver}
import scala.collection.mutable
import scala.util.Random._

object test_complex_switch extends App{

  // Config switch
  val node = mutable.Map[String, Any]()
  val id : Int = nextInt(100)
  val max_id : Int = 100
  val data_width : Int = 64
  val granularity : Int = 16
  val decomposer = data_width / granularity
  val num_input : Int = nextInt(10) + 2
  val num_output : Int = nextInt(10) + 3
  val flow_control : Boolean = true//nextBoolean()
  val max_util : Int = nextInt(16) + 1
  val max_delay : Int = 5 // nextInt(10)
  val config_input_port = nextInt(num_input)

  node("id") = id
  node("max_id") = max_id
  node("data_width") = data_width
  node("granularity") = granularity
  node("num_input") = num_input
  node("num_output") = num_output
  node("flow_control") = flow_control
  node("max_util") = max_util
  node("max_delay") = max_delay
  node("config_in_port_idx") = config_input_port
  node("config_out_port_idx") =
    List(nextInt(num_output/2), nextInt(num_output/2) + num_output/2)

  println(node)

  // Calculate the internal parameter
  private val num_bits = data_width + 1
  private val num_config_bit = log2Ceil(max_util)
  private val num_id_bit = log2Ceil(max_id)
  private val num_source_sel_bit = log2Ceil(num_input + 1)
  private val num_offset_bit = log2Ceil(decomposer)
  private val num_tail_zero = num_bits - 1 -
    2 * num_config_bit - num_id_bit -
    num_output * (num_source_sel_bit + num_offset_bit)

  val testResult : Boolean = Driver.execute(args, () => new complex_switch(prop = node)){
    dut => new PeekPokeTester[complex_switch](dut) {
      var cycle : Int = 0;
      // Enable this module
      poke(dut.io.en, true)

      // Construct config message
      val init_config_message =
        BigInt(1) |||
          (0,num_config_bit) ||| (1,num_config_bit) ||| (id, num_id_bit) |||
          ("1111111111111111111111111111111111111111",
            data_width - 1 - 2*num_config_bit - num_id_bit)

      println("config message = " + init_config_message + ", b\'" +
        fixLength(init_config_message.toString(2), num_bits))

      // Test config switch
      poke(dut.io.input_ports(0).valid, true)
      poke(dut.io.input_ports(0).bits, init_config_message)

      move(10000)

      def generate_random_config_message = {
        // Construct config message
        val config_message = {
          // config_type(config location), curr_util, id
          val config_idx = nextInt(max_util)
          val curr_util = nextInt(max_util)
          val curr_id = nextInt(max_id)
          BigInt(1) |||
            (config_idx, num_config_bit) ||| (curr_util,num_config_bit) |||
            (id, num_id_bit) |*|
            (num_input, num_output, num_source_sel_bit, true) |*|
            (decomposer, num_output, num_offset_bit, true) |||
            ("1111111111111111111111111111111111111111", num_tail_zero)
        }
        println("config message = " + config_message + ", b\'" +
          fixLength(config_message.toString(2), num_bits))
        config_message
      }

      def feed_random_values : Boolean = {
        val input_values = for(input_idx <- 0 until num_input) yield {
          if(cycle % (2*max_delay) == 0 && input_idx == config_input_port){
            generate_random_config_message
          }else{
            BigInt(0) ||| (BigInt(data_width, scala.util.Random),data_width)
          }
        }
        val input_valids = for(input_idx <- 0 until num_input) yield {
          if(cycle % (2*max_delay) == 0 && input_idx == config_input_port){
            true
          }else{
            scala.util.Random.nextBoolean()
          }
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
        step(1); cycle = cycle + 1
        // something that did every cycle
        // assert(print_switch_io)
        assert(feed_random_values)
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
