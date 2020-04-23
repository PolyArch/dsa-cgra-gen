package cgra.memory

import chisel3._
import chisel3.util._
import common.data_type._
import common.mem_operation
import common.wrapper._
import mem_util.str_type._

/*
class general_str_table(
                 // Basic parameter
                 num_str : Int = 8, // number of port is equal to number of stream
                 support_data_type : Set[data_type] = Set(b64), // 8 / 16 / 32 / 64
                 max_array_size : Int = 255,
                 // Indirect access and offset
                 is_ind : Boolean = false,
                 // Indirect / Direct Dimension Size
                 dimension_properties : List[(str_type, Int, Int, List[Int])]
                   = List((both, 255, 8, Nil)),
                 // List[(str_type, max_dimension_size, max_stride, List[max_stretch])]
                 // Offset
                 num_offset : Int = 0,
                 max_offset : Int = 0
               ) extends Module{

  // requirement


}
*/