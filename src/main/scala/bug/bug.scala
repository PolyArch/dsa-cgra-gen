package bug
import chisel3._
import chisel3.iotesters.PeekPokeTester
import chisel3.util._

class bug_hw(p1:Int,p2:Int) extends Module{
  val io = IO(new Bundle{
    val vec_in = Input(MixedVec((p1 to p2) map { i => UInt(i.W) }))
    val vec_out = Output(UInt(5.W))
  })
  io.vec_out := io.vec_in(0)
}

// --------------- Tester ------------------

class BugUnitTester(b:bug_hw) extends PeekPokeTester(b) {
  private val bug = b
  val io = bug.io
  poke(io.vec_in(0),5)
  step(2)
}
object BugMain extends App {
  iotesters.Driver.execute(args, () =>
    new bug_hw(5,10)
  ){
    c => new BugUnitTester(c)
  }
}