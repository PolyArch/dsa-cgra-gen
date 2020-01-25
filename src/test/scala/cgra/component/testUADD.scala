package cgra.component

import scala.math._

import chisel3.util._
import TestUtil.CgraTestUtil._
import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}

object testUADD extends App{

  val data_widths = List(64)
  val granularities = List(8)

  for(dw<- data_widths; gr <- granularities if gr <= dw){

    val data_width = dw
    val finest_width = gr

    println(s"data_width = $dw, granularity = $gr")

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

    val testResult = Driver.execute(args,
      () => new UADD_composed(data_width,finest_width)){
      dut => new PeekPokeTester[UADD_composed](dut) {
        for(repeat_idx <- 0 until 20){
          // Create Test Input
          val testA = BigInt(data_width, scala.util.Random)
          val testB = BigInt(data_width, scala.util.Random)
          print(testA + "\n")
          print(testB + "\n")
          testA.bitLength

          // Test Every Ctrl Mode
          for(ctrl <- 0 until ctrl_num){
            // Feed Data into Port
            if(ctrl_num > 1)
              poke(dut.io.ctrl, BigInt(ctrl))
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

            val binaryA = fixLength(peekA.toString(2),data_width)
            println("A = b'" + binaryA + ", " + peekA)
            val binaryB = fixLength(peekB.toString(2),data_width)
            println("B = b'" + binaryB + ", " + peekB)
            val binaryS = fixLength(peekS.toString(2),data_width)
            println("S = b'" + binaryS + ", " + peekS)

            val subnet_results = for (subnet_idx <- 0 until curr_num_subnet)
              yield {

                val subBinaryA = binaryA.reverse.substring(
                  subnet_idx * curr_decomp_width,
                  (subnet_idx + 1) * curr_decomp_width).reverse
                val subBinaryB = binaryB.reverse.substring(
                  subnet_idx * curr_decomp_width,
                  (subnet_idx + 1) * curr_decomp_width).reverse
                val subBinaryS = binaryS.reverse.substring(
                  subnet_idx * curr_decomp_width,
                  (subnet_idx + 1) * curr_decomp_width).reverse

                val subA = BigInt(subBinaryA,2)
                val subB = BigInt(subBinaryB,2)
                val subS = BigInt(subBinaryS,2)

                println("A = b'" + subBinaryA + ", d'" + subA)
                println("B = b'" + subBinaryB + ", d'" + subB)
                println("S = b'" + subBinaryS + ", d'" + subS)

                println("decomposed by " + pow(2,ctrl).toInt
                  + ", subnet " + subnet_idx + ", "
                  + subA + " + " + subB + " = " + subS)

                // Verify the result
                var realS = subA + subB
                val real_result_width = realS.bitLength
                val isOverflow = real_result_width > curr_decomp_width
                // Decomposable Function Unit cannot deal with overflow
                if(isOverflow){
                  println("Before Clear Sign Bit " + realS.toString(2))
                  realS = realS.clearBit(real_result_width - 1)
                  println("After Clear Sign Bit " + realS.toString(2))
                }
                // Print the result
                println("Real Result is " + realS + ", Got " + subS)
                expect(realS == subS, "subnet " + subnet_idx +" failed")
                realS
              }
            val real_result = BigInt(subnet_results.reverse.
              flatMap(x=>fixLength(x.toString(2),curr_decomp_width)) mkString,2)
            expect(dut.io.result,real_result,"Failed")
          }
        }
      }
    }

  }


}