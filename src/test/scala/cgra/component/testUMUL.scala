package cgra.component

import scala.math._

import chisel3.util._
import TestUtil.Random._
import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}

object testUMUL extends App{

  val data_width = args(0).toInt
  val finest_width = args(1).toInt

  // Meaningful
  require(data_width >= finest_width)
  require(isPow2(data_width))
  require(isPow2(finest_width))
  // Byte computable
  require(data_width % 8 == 0 && finest_width % 8 == 0)
  // Decomposable
  require(data_width % finest_width == 0)

  val decomposer = data_width / finest_width
  val ctrl_num = 1 + log2Ceil(decomposer)

  val testResult = Driver(() =>
    new UMUL_composed(data_width,finest_width)){
    dut => new PeekPokeTester[UMUL_composed](dut) {
      for(repeat_idx <- 0 until 10){
        // Create Test Input
        val testA = BigInt(data_width, scala.util.Random)
        val testB = BigInt(data_width, scala.util.Random)

        // Test Every Ctrl Mode
        for(ctrl <- 0 until ctrl_num){
          // Feed Data into Port
          poke(dut.io.ctrl, ctrl)
          poke(dut.io.a, testA)
          poke(dut.io.b, testB)
          step(1) // This is not necessary, just used for print the internal stuff
          // of module

          val curr_decomp_width = data_width / pow(2,ctrl).toInt
          val curr_num_subnet = data_width / curr_decomp_width

          // Peek the result
          val peekA = peek(dut.io.a)
          val peekB = peek(dut.io.b)
          val peekS = peek(dut.io.result)

          val binaryA = LeadZeros(peekA.toString(2),data_width)
          println("A = b'" + binaryA + ", " + peekA)
          val binaryB = LeadZeros(peekB.toString(2),data_width)
          println("B = b'" + binaryB + ", " + peekB)
          val binaryS = LeadZeros(peekS.toString(2),data_width * 2)
          println("S = b'" + binaryS + ", " + peekS)

          val subnet_results = for (subnet_idx <- 0 until curr_num_subnet)
            yield {
              println(" ------ subnet " + subnet_idx + "------")
              val subBinaryA = binaryA.reverse.substring(
                subnet_idx * curr_decomp_width,
                (subnet_idx + 1) * curr_decomp_width).reverse
              val subBinaryB = binaryB.reverse.substring(
                subnet_idx * curr_decomp_width,
                (subnet_idx + 1) * curr_decomp_width).reverse
              val subBinaryS = binaryS.reverse.substring(
                subnet_idx * 2 * curr_decomp_width,
                (subnet_idx + 1) * 2 * curr_decomp_width).reverse

              val subA = BigInt(subBinaryA,2)
              val subB = BigInt(subBinaryB,2)
              val subS = BigInt(subBinaryS,2)

              println("A = b'" + subBinaryA + ", d'" + subA)
              println("B = b'" + subBinaryB + ", d'" + subB)
              println("S = b'" + subBinaryS + ", d'" + subS)

              println("decomposed by " + pow(2,ctrl).toInt
                + ", subnet " + subnet_idx + ", "
                + subA + " * " + subB + " = " + subS)

              // Verify the result
              var realS = subA * subB
              val real_result_width = realS.bitLength
              val isOverflow = real_result_width > curr_decomp_width * 2
              // Decomposable Function Unit cannot deal with overflow
              if(isOverflow){
                println("Decomposed Width = " + curr_decomp_width * 2
                  + ", but Overflow by "
                  + (real_result_width - curr_decomp_width * 2)
                  + " bits")
                println("Before Clear Sign Bit " + realS.toString(2))
                realS = BigInt(realS.toString(2).reverse.substring(0,2*curr_decomp_width).reverse,2)
                println("After Clear Sign Bit " + realS.toString(2))
              }
              // Print the result
              println("Real Result is " + realS + ", Got " + subS)
              expect(realS == subS, "subnet " + subnet_idx +" failed")
              println(" ------ subnet " + subnet_idx + "------")
              realS
            }
          val real_result = BigInt(subnet_results.reverse.
            flatMap(x=>LeadZeros(x.toString(2),curr_decomp_width * 2)) mkString,2)
          expect(dut.io.result,real_result,"Failed")
        }
      }
    }
  }
}