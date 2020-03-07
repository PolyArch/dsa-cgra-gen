package cgra.memory

import chisel3._
import chisel3.util._
import common.mem_operation
import common.wrapper._

class ind_str_table(num_str : Int, // number of stream support
                    memory_size : Int, // Memory size in Byte
                    max_num_access : Int, // Maximum number of access for one stream
                    data_types : Set[Int], // Set of data type supported
                    idx_types : Set[Int], // Set of index type supported
                    oper_types : mem_operation.ValueSet // Set of operation supported.
                    // e.g. subset of Write/Read/Update(add, sub, min, max)
                   )
  extends Module{
  // Parameter Requirement
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
    val in_start_addr : UInt = Input(UInt(num_addr_bit.W))
    val in_num_access : UInt= Input(UInt(num_access_bit.W))
    val in_data_type : UInt = Input(UInt(num_data_type_bit.W))
    val in_idx_type : UInt = Input(UInt(num_idx_type_bit.W))
    val in_oper_type : UInt = Input(UInt(num_oper_bit.W))

    // Output Entry of Stream Table
    val out_start_addr : UInt = Output(UInt(num_addr_bit.W))
    val out_num_access : UInt= Output(UInt(num_access_bit.W))
    val out_data_type : UInt = Output(UInt(num_data_type_bit.W))
    val out_idx_type : UInt = Output(UInt(num_idx_type_bit.W))
    val out_oper_type : UInt = Input(UInt(num_oper_bit.W))

    // Output Control
    val isFull : Bool = Output(Bool())
  })

  // Create the actual table as Sync Memory
  val str_table = SyncReadMem(num_str, UInt(num_total_bit.W))
  val str_count_table = SyncReadMem(num_str, UInt(num_access_bit.W))

  // Pointer that select the target stream
  val str_ptr = RegInit(0.U(num_max_stream_bit.W))

  val start_addr :: data_typ :: idx_typ :: oper_typ :: Nil =
    decode(str_table.read(str_ptr),
      num_addr_bit, num_data_type_bit, num_idx_type_bit, num_oper_bit)

}
