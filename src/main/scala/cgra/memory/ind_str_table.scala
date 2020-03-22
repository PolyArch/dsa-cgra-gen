package cgra.memory

import chisel3._
import chisel3.util._
import common.mem_operation
import common.wrapper._

class ind_str_table(data_width : Int, // general data width (64 bit)
                    num_str : Int, // number of stream support
                    memory_size : Int, // Memory size in Byte
                    max_num_access : Int, // Maximum number of access for one stream
                    data_types : Set[Int], // Set of data type supported
                    idx_types : Set[Int], // Set of index type supported
                    oper_types : mem_operation.ValueSet // Set of operation supported.
                    // e.g. subset of Write/Read/Update(add, sub, min, max)
                   )
  extends Module{
  // Parameter Requirement
  require(isPow2(data_width))
  require(isPow2(memory_size))
  require(data_types.forall(isPow2(_)), "data type need to be power of two")
  require(idx_types.forall(isPow2(_)), "data type need to be power of two")

  // Calculate the internal parameter
  val num_data_type : Int = data_types.size
  val num_idx_type : Int = idx_types.size
  val num_oper : Int = oper_types.size

  val num_max_stream_bit = log2Ceil(num_str)
  val num_addr_bit : Int = log2Ceil(memory_size)
  val num_access_bit : Int = log2Ceil(max_num_access)
  val num_data_type_bit : Int = log2Ceil(num_data_type)
  val num_idx_type_bit : Int = log2Ceil(num_idx_type)
  val num_oper_bit : Int = log2Ceil(num_oper)
  val num_total_bit : Int =
    num_addr_bit + num_data_type_bit + num_idx_type_bit + num_oper_bit

  val io = IO(new Bundle{
    // New Entry of Stream Table
    val new_entry : UInt = Input(UInt((num_total_bit + num_access_bit).W))

    // Selected Entry of Stream Table
    val select_entry : UInt = Output(UInt((num_total_bit + num_access_bit).W))

    // Output Control
    val isFull : Bool = Output(Bool())
  })

  // Create the actual table as Sync Memory
  val str_table = SyncReadMem(num_str, UInt(num_total_bit.W))
  val str_count_table = SyncReadMem(num_str, UInt(num_access_bit.W))

  // Pointer that select the next target stream
  val str_ptr = RegInit(0.U(num_max_stream_bit.W))



  // Decode the new entry
  val new_start_addr :: new_data_typ :: new_idx_typ :: new_oper_typ ::
    new_num_access :: Nil = decode(io.new_entry,
    num_addr_bit, num_data_type_bit, num_idx_type_bit, num_oper_bit, num_access_bit)

  // Read the target entry
  val nxt_start_addr :: nxt_data_typ :: nxt_idx_typ :: nxt_oper_typ ::
    Nil = decode(str_table.read(str_ptr),
    num_addr_bit, num_data_type_bit, num_idx_type_bit, num_oper_bit)

  // Read the target remaining number of access
  val nxt_num_access : UInt = str_count_table.read(str_ptr)

  // Output the target entry
  io.select_entry := Cat(nxt_start_addr, nxt_data_typ,
    nxt_idx_typ, nxt_oper_typ, nxt_num_access)
}
