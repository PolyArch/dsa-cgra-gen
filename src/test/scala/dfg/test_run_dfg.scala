package dfg

import scala.math._
import chisel3._
import chisel3.util._
import TestUtil.CgraTestUtil._
import cgra.config.fullinst.insts_prop
import chisel3.iotesters.{Driver, PeekPokeTester}
import TestUtil.config_file._
import scala.util.Random._
import scala.collection.mutable
import cgra.IR.IRinstantiator.instantiateCgra
import cgra.IR.IRmerger.mergeIRwithCgra
import cgra.IR.IRreader.readIR
import cgra.IR.IRconfigpather
import cgra.fabric.cgra_fabric

object test_run_dfg extends App {
  // Read IR file
  val ir_file : String = args(0)
  val cgra : mutable.Map[String,Any] = readIR(ir_file)
  // Build config path
  (new IRconfigpather).build_config_path(cgra)
  // Read Config File
  val config_file : String = args(1)
  val config_bits : Seq[BigInt] = get_config_bits(config_file);

  println("START TESTING")
  val testResult : Boolean = Driver.execute(args, () =>
    new cgra_fabric(cgra)){
    dut => new PeekPokeTester[cgra_fabric](dut) {
      var cycle : Int = 0
      val total_cycle = 50000
      val data_width : Int = dut.data_width

      // Start configuration
      for(config_bit <- config_bits){
        for(input_port <- dut.io.input_ports){
          val config_bit_valid = BigInt(1) ||| (config_bit, data_width - 1)
          val vport_width : Int = input_port.bits.getWidth / data_width
          val wide_config_bits : BigInt =
            config_bit_valid |*| (vport_width, data_width)
          poke(input_port.bits, wide_config_bits)
          poke(input_port.valid, true)
        }
        for(output_port <- dut.io.output_ports){
          poke(output_port.ready, true)
        }
        step(1)
      }

      // Start to feed random value
      while(cycle < total_cycle){
        if(cycle % (total_cycle / 50) == 0)
          println(s"Simulation Progress = ${100 * cycle / total_cycle.toDouble}%")
        move
      }

      // TODO: expect result needed from gem5
      def move:Unit = {
        for(input_port <- dut.io.input_ports){
          val random_value = BigInt(data_width, scala.util.Random)
          val vport_width : Int = input_port.bits.getWidth / data_width
          val wide_random_value : BigInt =
            random_value |*| (vport_width, data_width)
          poke(input_port.bits, wide_random_value)
          poke(input_port.valid, true)
        }
        for(output_port <- dut.io.output_ports){
          poke(output_port.ready, true)
        }
        cycle = cycle + 1
        step(1)
      }
      def move(time: Int):Unit = {
        for(_ <- 0 until time){
          move
        }
      }
    }
  }
}
