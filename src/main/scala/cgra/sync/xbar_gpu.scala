package cgra.sync

import chisel3._
import chisel3.util._

class xbar_gpu(num_bank : Int,
               vec_size : Int,
               data_width : Int)
  extends Module{

  // Derived Parameter
  val input_width : Int = data_width * vec_size
  val num_bits_bank_idx : Int = log2Ceil(num_bank)

  // Define IO
  val io = IO(new Bundle{
    val vector_input_port = Flipped(DecoupledIO(UInt(input_width.W)))
    val spad_output_ports = Vec(num_bank, DecoupledIO(UInt(data_width.W)))
  })

  // vector of addresses
  val vec_reqs_bits : Vec[UInt] = VecInit(for(idx <- 0 until num_bank) yield {
    val high_idx = (1+idx) * data_width - 1
    val low_idx = idx * data_width
    io.vector_input_port.bits(high_idx, low_idx)
  })

  // Bank index of each address
  val vec_bank_idx : Vec[UInt] = VecInit(vec_reqs_bits.map(_.apply(num_bits_bank_idx - 1, 0)))

  // req accepted
  val vec_req_acc : Vec[Bool] = RegInit(VecInit(Seq.fill(vec_size)(false.B)))
  val all_vec_req_acc : Bool = vec_req_acc.reduce(_ && _)

  // Ready for new vector request
  io.vector_input_port.ready := all_vec_req_acc

  //default output
  io.spad_output_ports.foreach(op=>{
    op.bits := 0.U
    op.valid := false.B
  })

  // Time sequence - FSM
  // loop for all request
  for(vec_idx <- 0 until vec_size){
    // current bank idx
    val curr_bank_idx : UInt = vec_bank_idx(vec_idx)
    // check for conflict
    val prev_nonconflict_finished =
      if(vec_idx == 0){
        true.B
      }else{
        (for(prev_vec_idx <- 0 until vec_idx) yield {
          val prev_bank_idx : UInt = vec_bank_idx(prev_vec_idx)
          vec_req_acc(prev_vec_idx) || (prev_bank_idx =/= curr_bank_idx)
        }).reduce(_ && _)
      }
    // send to scratchpad
    when(prev_nonconflict_finished){
      // assign bits
      io.spad_output_ports(curr_bank_idx).bits := vec_reqs_bits(vec_idx)
      // assign valid
      io.spad_output_ports(curr_bank_idx).valid := true.B
      // assign accepted when spad received the address
      vec_req_acc(vec_idx) := io.spad_output_ports(curr_bank_idx).ready
    }.otherwise{
      vec_req_acc(vec_idx) := false.B
    }
  }
}
object gen_xbar_gpu extends App{
  chisel3.Driver.execute(args,()=>{
    val module = new xbar_gpu(4,4,64)
    module
  })
}