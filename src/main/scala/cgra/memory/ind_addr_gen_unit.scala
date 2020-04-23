package cgra.memory

import chisel3._
import chisel3.util._
import common.mem_operation.mem_operation
import common.wrapper.bit_decode

class ind_addr_gen_unit(data_width : Int, // general data width (64 bit)
                        num_str : Int, // number of stream support
                        memory_size : Int, // Memory size in Byte
                        num_bank : Int, // # bank of spad mem
                        line_size : Int, // size of line
                        max_num_access : Int, // Maximum number of access for one stream
                        data_types : Set[Int], // Set of data type supported
                        idx_types : Set[Int], // Set of index type supported
                        oper_types : Set[mem_operation] // Set of operation supported.
                        // e.g. subset of Write/Read/Update(add, sub, min, max)
                       ) extends Module {
  // Parameter Requirement
  require(isPow2(data_width))
  require(isPow2(memory_size))
  require(isPow2(line_size))
  require(isPow2(num_bank))
  require(idx_types.forall(_ <= data_width))
  require(memory_size % (line_size * num_bank) == 0)

  // Calculate the internal parameter
  val num_data_type : Int = data_types.size
  val num_idx_type : Int = idx_types.size
  val num_oper : Int = oper_types.size

  // number of bits need to be stored in stream table
  val num_max_stream_bit = log2Ceil(num_str)
  val num_addr_bit : Int = log2Ceil(memory_size)
  val num_access_bit : Int = log2Ceil(max_num_access)
  val num_data_type_bit : Int = log2Ceil(num_data_type)
  val num_idx_type_bit : Int = log2Ceil(num_idx_type)
  val num_oper_bit : Int = log2Ceil(num_oper)
  val total_str_entry_bit : Int =
    num_addr_bit + num_data_type_bit + num_idx_type_bit + num_oper_bit

  // ------ Hardware ------

  // IO
  val io = IO(new Bundle{
      val stream : UInt = Input(UInt((num_max_stream_bit + total_str_entry_bit + num_access_bit).W))
      val vec_port : Vec[UInt] = Vec(num_str, Input(UInt(data_width.W)))
      //val addresses : Vec[UInt] = Vec()
    }
  )

  // Decode the stream
  val curr_port_num :: curr_start_addr :: curr_data_typ :: curr_idx_typ :: curr_oper_typ :: curr_num_access :: Nil = bit_decode(io.stream,
    num_max_stream_bit,
    num_addr_bit, num_data_type_bit, num_idx_type_bit, num_oper_bit,
    num_access_bit)

  // Get the value from port
  val port_value : UInt = io.vec_port(curr_port_num)

  // split the value based on supported index type
  val idx_typ2idx_val : IndexedSeq[(Int, Vec[UInt])] =
    (for(idx_typ <- idx_types) yield {
      val num_splited_value = data_width / idx_typ
      val splited_value: Vec[UInt] =
        VecInit(for (idx <- 0 until num_splited_value) yield {
          port_value((idx + 1) * idx_typ - 1, idx * idx_typ)
        })
      (idx_typ, splited_value)
    }).toIndexedSeq




}
