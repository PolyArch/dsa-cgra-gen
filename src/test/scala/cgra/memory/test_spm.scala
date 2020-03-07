package cgra.memory

import chisel3._
import chisel3.util._
import chisel3.iotesters.{Driver, PeekPokeTester}
import scala.util.Random._
import TestUtil.CgraTestUtil._

object test_spm extends App{

  val memory_size = 64
  val line_size = 4
  val num_line = memory_size / line_size
  val num_line_bit = line_size * 8
  val num_addr_bit = log2Ceil(num_line)

  val testResult : Boolean = Driver.execute(args, () =>
    new scratchpad(memory_size, line_size, true)){
    dut => new PeekPokeTester[scratchpad](dut) {
      val total_cycle = 10000
      val mem_sw : Array[BigInt] = Array.fill(num_line)(BigInt(0))

      move(total_cycle)

      def move(cycle: Int) : Unit ={
        if(cycle >= 0){
          println(s"------ Cycle ${total_cycle - cycle} ------")

          // Read Test
          val doRead = nextBoolean()
          poke(dut.io.read_enable, doRead)
          val read_addr = BigInt(num_addr_bit, scala.util.Random)
          if(doRead){
            poke(dut.io.read_addr, read_addr)
          }

          // Write Test
          val doWrite = nextBoolean()
          poke(dut.io.write_enable, doWrite)
          if(doWrite){
            val write_addr = BigInt(num_addr_bit, scala.util.Random)
            val write_data = Seq.fill(line_size)(BigInt(8, scala.util.Random))
            val write_mask = Seq.fill(line_size)(nextBoolean())
            println(s"write $write_data -> $write_addr with $write_mask")
            // Poke the hardware
            poke(dut.io.write_addr, write_addr)
            (write_mask zip write_data).zipWithIndex.foreach{
              case ((mask, data), idx) =>
                poke(dut.io.write_mask(idx), mask)
                poke(dut.io.write_data(idx), data)
            }
            // Modify the software
            val old_data = fixLength(mem_sw(write_addr.toInt).toString(2), num_line_bit)
              .grouped(8).toArray.reverse
            val new_data = for(idx <- write_mask.indices) yield {
              if(write_mask(idx)){
                fixLength(write_data(idx).toString(2),8)
              }else{
                old_data(idx)
              }
            }
            mem_sw(write_addr.toInt) = BigInt(new_data.reverse.reduce(_ + _),2)
          }

          // Next Cycle
          step(1)
          if(doRead || doWrite) {
            if(doRead){
              val read_data = peek(dut.io.read_data)
              println(s"read $read_data <- $read_addr")
              fixLength(mem_sw(read_addr.toInt).toString(2), num_line_bit)
                .grouped(8).toArray.reverse.zipWithIndex.foreach{
                case (str, idx) =>
                  expect(dut.io.read_data(idx), BigInt(str, 2))
              }
            }
          }
          move(cycle - 1)
        }
      }
    }
  }
  assert(testResult)
}
