package fabric

import chisel3._
import cgra.fabric.delay
import chisel3.iotesters.PeekPokeTester

class delay_pipe_tester(pipe:delay)
  extends PeekPokeTester(pipe){

}

object delay_pipe_test extends App{
  iotesters.Driver.execute(args, () =>
    new delay(64, 5, true)
  ){
    c => new delay_pipe_tester(c)
  }
}