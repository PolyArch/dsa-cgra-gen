package cgra.sync

import chisel3._
import chisel3.util._

class xbar_link_buffer(num_bank : Int,
                        vec_size : Int,
                        data_width : Int)
  extends Module{

  // Derived Parameter
  val input_width : Int = data_width * vec_size
  val num_bits_bank_idx : Int = log2Ceil(num_bank)
  val num_bits_vec_idx : Int = log2Ceil(vec_size)

  // Define IO
  val io = IO(new Bundle{
    val vector_input_port = Flipped(Vec(vec_size, DecoupledIO(UInt(data_width.W))))
    val spad_output_ports = Vec(num_bank, DecoupledIO(UInt(data_width.W)))
  })

  // vector of addresses
  val vec_reqs = for(vec_idx <- 0 until vec_size) yield {
    io.vector_input_port(vec_idx)
  }

  // Bank index of each address
  val vec_bank_idx = vec_reqs.map(_.bits.apply(num_bits_bank_idx - 1, 0))

  // Link Buffer
  val link_buffer_bits = RegInit(
    VecInit(Seq.fill(num_bank)(
      VecInit(Seq.fill(vec_size)(0.U(data_width.W))))
    )
  )

  // Link Buffer Valid
  val link_buffer_valid = RegInit(
    VecInit(Seq.fill(num_bank)(
      VecInit(Seq.fill(vec_size)(false.B)))
    )
  )

  // Link Buffer Ready
  val link_buffer_ready = RegInit(
    VecInit(Seq.fill(num_bank)(
      VecInit(Seq.fill(vec_size)(true.B)))
    )
  )

  // default output
  io.spad_output_ports.foreach(op=>{
    op.bits := 0.U
    op.valid := false.B
  })

  // write to link buffer when link is ready
  for(vec_idx <- 0 until vec_size){
    // target bank
    val curr_bank_idx = vec_bank_idx(vec_idx)
    // vec bits
    val vec_bits = vec_reqs(vec_idx).bits
    val vec_valid = vec_reqs(vec_idx).valid
    // link ready
    val link_ready = link_buffer_ready(curr_bank_idx)(vec_idx)
    // forward the ready signal
    vec_reqs(vec_idx).ready := link_ready
    // write to link when link is ready
    when(link_ready){
      link_buffer_bits(curr_bank_idx)(vec_idx) := vec_bits
      link_buffer_valid(curr_bank_idx)(vec_idx) := vec_valid
    }
  }

  // Round-Robin Output the link buffer
  val counters = RegInit(VecInit(Seq.fill(num_bank)(0.U(num_bits_vec_idx.W))))
  for(bank_idx <- 0 until num_bank){
    val counter = counters(bank_idx)
    val link_bits = link_buffer_bits(bank_idx)
    val link_valid = link_buffer_valid(bank_idx)
    val link_ready = link_buffer_ready(bank_idx)
    // output the value and valid when pointed value is valid
    when(link_valid(counter)){
      // output the bits
      io.spad_output_ports(bank_idx).bits := link_bits(counter)
      io.spad_output_ports(bank_idx).valid := link_valid(counter)
      // update the counter when pointed is ready
      when(io.spad_output_ports(bank_idx).ready){
        // unset the valid (because value has been used)
        link_valid(counter) := false.B
        // set the ready
        link_ready(counter) := true.B
      }.otherwise{
        link_ready(counter) := false.B
      }
    }.otherwise{
      // if the current link is not valid, next one (round robin)
      counter := counter + 1.U
    }
  }

}
object gen_xbar_link_buffer extends App{
  chisel3.Driver.execute(args,()=>{
    val module = new xbar_link_buffer(4,4,64)
    module
  })
}