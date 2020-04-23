package cgra.memory

import chisel3._
import chisel3.util._
import common.data_type.data_type
import common.mem_operation.mem_operation
import common.wrapper._

class ind_str_table(data_width : Int, // general data width (64 bit)
                    num_str : Int, // number of stream support
                    memory_size : Int, // Memory size in Byte
                    max_num_access : Int, // Maximum number of access for one stream
                    data_types : Set[Int], // Set of data type supported
                    idx_types : Set[Int], // Set of index type supported
                    oper_types : Set[mem_operation] // Set of operation supported.
                    // e.g. subset of Write/Read/Update(add, sub, min, max)
                   )
  extends Module{
  // Parameter Requirement
  require(isPow2(data_width))
  require(isPow2(memory_size))
  require(data_types.forall(isPow2(_)))
  require(idx_types.forall(isPow2(_)))

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

  // Calculate how many access is consumed for index type
  val idx_typ2num_consume : Seq[(UInt, UInt)] = for(enc <- 0 until num_idx_type) yield {
    val idx_enc : UInt = enc.U(num_idx_type_bit.W)
    val idx_type : Int = idx_types.toList.apply(enc)
    val num_consumed_value : UInt = (data_width / idx_type).U(num_access_bit.W)
    (idx_enc, num_consumed_value)
  }

  // ------ Hardware ------

  // IO
  val io = IO(new Bundle{
    // Input Control
    val create_new : Bool = Input(Bool())

    // New Entry of Stream Table
    val new_entry : UInt = Input(UInt((num_max_stream_bit + total_str_entry_bit + num_access_bit).W))

    // Selected Entry of Stream Table
    val select_entry : UInt = Output(UInt((num_max_stream_bit + total_str_entry_bit + num_access_bit).W))

    // Output Control
    val isAct : Bool = Output(Bool())
    val isFull : Bool = Output(Bool())
  })

  // Create the actual table as Sync Memory
  val str_table = SyncReadMem(num_str, UInt(total_str_entry_bit.W))
  val str_count_table = SyncReadMem(num_str, UInt(num_access_bit.W))

  // Pointer that select the next target stream
  val str_ptr = RegInit(0.U(num_max_stream_bit.W))

  // Decode the new entry
  val new_port_num :: new_start_addr :: new_data_typ :: new_idx_typ :: new_oper_typ :: new_num_access :: Nil = bit_decode(io.new_entry,
    num_max_stream_bit,
    num_addr_bit, num_data_type_bit, num_idx_type_bit, num_oper_bit,
    num_access_bit)

  // Read the target entry
  val nxt_start_addr :: nxt_data_typ :: nxt_idx_typ :: nxt_oper_typ :: Nil = bit_decode(str_table.read(str_ptr),
    num_addr_bit, num_data_type_bit, num_idx_type_bit, num_oper_bit)

  // Read the target remaining number of access
  val nxt_num_access : UInt = str_count_table.read(str_ptr)

  // Check whether this stream is active
  io.isAct := nxt_num_access =/= 0.U

  // Output the target entry
  io.select_entry := Cat(str_ptr,
    nxt_start_addr, nxt_data_typ, nxt_idx_typ, nxt_oper_typ,
    nxt_num_access)

  // Select the Stream
  // TODO: current is round-robin
  str_ptr := str_ptr + 1.U

  // FSM
  when(io.create_new){
    // Write the new entry into stream table
    str_table.write(new_port_num, Cat(new_start_addr, new_data_typ, new_idx_typ, new_oper_typ))
    str_count_table.write(new_port_num, new_num_access)
  }.otherwise{
    // Calculate the amount of access that this stream will consume
    val num_consumed_access : UInt = MuxLookup(nxt_idx_typ, 0.U, idx_typ2num_consume)
    // get the new remaining number of access
    val new_remaining_access : UInt =
      Mux(nxt_num_access > num_consumed_access, nxt_num_access - num_consumed_access, 0.U)
    str_count_table.write(str_ptr, new_remaining_access)
  }
}
