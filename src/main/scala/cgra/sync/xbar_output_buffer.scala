package cgra.sync

import chisel3._
import chisel3.util._

class xbar_output_buffer(num_bank : Int,
                         vec_size : Int,
                         data_width : Int,
                         fifo_depth : Int)
  extends Module{

  // Derived Parameter
  val input_width : Int = data_width * vec_size
  val num_bits_bank_idx : Int = log2Ceil(num_bank)
  val num_bits_vec_idx : Int = log2Ceil(vec_size)
  val num_bits_fifo_idx : Int = log2Ceil(fifo_depth)

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

  // Output Buffer
  val output_buffer_bits = RegInit(
    VecInit(Seq.fill(num_bank)(
      VecInit(Seq.fill(fifo_depth)(0.U(data_width.W))))
    )
  )

  // Output Buffer Valid
  val output_buffer_valid = RegInit(
    VecInit(Seq.fill(num_bank)(
      VecInit(Seq.fill(fifo_depth)(false.B)))
    )
  )

  // Output Buffer Pointer
  val output_buffer_pointers = RegInit(
    VecInit(Seq.fill(num_bank)(
      // size 2 is because we have head and tail pointer
      VecInit(Seq.fill(2)(0.U(num_bits_fifo_idx.W))))
    )
  )

  // default output
  io.spad_output_ports.foreach(op=>{
    op.bits := 0.U
    op.valid := false.B
  })
  vec_reqs.foreach(_.ready := true.B)

  // loop for each bank
  for(bank_idx <- 0 until num_bank){
    val head = output_buffer_pointers(bank_idx).head
    val tail = output_buffer_pointers(bank_idx).last
    val isempty : Bool = head === tail
    val isfull : Bool = (tail + 1.U) === head
    val num_conflict : UInt = PopCount(vec_bank_idx.map(_ === bank_idx.U(num_bits_bank_idx.W)))

    // update the tail pointer
    when(tail + num_conflict + 1.U === head){
      tail := head - 1.U
    }.otherwise{
      tail := tail + num_conflict
    }

    // loop for each vector req, write to output buffer even when conflict
    for (vec_idx <- 0 until vec_size){
      when(vec_reqs(vec_idx).valid &&
        vec_bank_idx(vec_idx) === bank_idx.U){
        if(vec_idx == 0){
          when(!isfull){
            vec_reqs(vec_idx).ready := true.B
            output_buffer_bits(bank_idx)(tail) := vec_reqs(vec_idx).bits
            output_buffer_valid(bank_idx)(tail) := vec_reqs(vec_idx).valid
          }.otherwise{
            vec_reqs(vec_idx).ready := false.B
          }
        }else{
          val prev_num_conflict =
            PopCount(vec_bank_idx.zipWithIndex.filter(_._2 < vec_idx).map(_._1 === bank_idx.U(num_bits_bank_idx.W)))
          when(
            (tail + 1.U + prev_num_conflict) < head //is not full when having previous conflict
          ){
            vec_reqs(vec_idx).ready := true.B
            output_buffer_bits(bank_idx)(tail + prev_num_conflict) := vec_reqs(vec_idx).bits
            output_buffer_valid(bank_idx)(tail + prev_num_conflict) := vec_reqs(vec_idx).valid
          }.otherwise{
            vec_reqs(vec_idx).ready := false.B
          }
        }
      }
    }

    // read out from output buffer
    when(!isempty && output_buffer_valid(bank_idx)(head)){
      // read out
      io.spad_output_ports(bank_idx).bits := output_buffer_bits(bank_idx)(head)
      io.spad_output_ports(bank_idx).valid := true.B
      when(io.spad_output_ports(bank_idx).ready){
        head := head + 1.U
      }
    }
  }

}
object gen_xbar_output_buffer extends App{
  chisel3.Driver.execute(args,()=>{
    val module = new xbar_output_buffer(4,4,64, 4)
    module
  })
}