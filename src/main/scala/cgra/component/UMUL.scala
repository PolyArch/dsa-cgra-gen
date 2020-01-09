package cgra.component

import chisel3._
import chisel3.util._

class UMUL_composed(data_width: Int, finest_width : Int ) extends Module{

  private val decomposer : Int = data_width / finest_width
  private val num_ctrl : Int = log2Ceil(decomposer) + 1

  val io = IO(new Bundle{
    val a = Input(UInt(data_width.W))
    val b = Input(UInt(data_width.W))
    val result = Output(UInt((data_width * 2).W))
    val ctrl = Input(UInt(log2Ceil(num_ctrl).W)) // 0 -> 64, 1 -> 32x2, 2 -> 16x4, 3 -> 8x8
  })

  // Fine Bit Width
  private val Ai : IndexedSeq[UInt]= for(idx <- 0 until decomposer) yield {
    io.a((idx+1)*finest_width-1,idx*finest_width)
  }
  private val Bi : IndexedSeq[UInt] = for(idx <- 0 until decomposer) yield {
    io.b((idx+1)*finest_width-1,idx*finest_width)
  }

  // Partial Product (each partial product is double-wide of finest width)
  private val AiBi : IndexedSeq[IndexedSeq[UInt]] =
    Ai.map(ai=>{Bi.map(bi=>{ai * bi})})

  // Reduce the partial result for different decomposability level
  private var temp_offset = finest_width
  private var temp_part_product = AiBi
  private val reduce_results =
    (for (reduce_idx <- 0 until log2Ceil(decomposer)) yield {
      val curr_partial_product = reducePartialProduct(temp_part_product, temp_offset)
      temp_part_product = curr_partial_product._1
      temp_offset = curr_partial_product._2
      curr_partial_product
  }).reverse :+ (AiBi, finest_width)

  // Concat result from different decomposability level
  val mul_result = for (idx <- reduce_results.indices) yield {
    val partial_product = reduce_results(idx)._1
    val decomp_width = reduce_results(idx)._2
    val size = partial_product.length
    val result : UInt = (for (diag_idx <- 0 until size) yield {
      partial_product(diag_idx)(diag_idx)(decomp_width * 2 - 1, 0)
    }).reverse.reduce(Cat(_,_))
    (idx.U,result)
  }

  io.result := MuxLookup(io.ctrl, 0.U, mul_result)

  def reducePartialProduct(partial_product : IndexedSeq[IndexedSeq[UInt]],
                          offset_bitwidth : Int) :
  (IndexedSeq[IndexedSeq[UInt]], Int) = {
    val size_a = partial_product.length
    val size_b = partial_product.head.length
    val partial_result_width = partial_product.flatten.map(_.getWidth).distinct
    require(size_a == size_b)
    require(size_a % 2 == 0)

    val new_size = size_a / 2
    val partial_product_array = for
      (idx_a <- 0 until new_size;
       idx_b <- 0 until new_size) yield {
      partial_product(idx_a * 2)(idx_b * 2) +&
        (partial_product(idx_a * 2 + 1)(idx_b * 2) << offset_bitwidth).asUInt() +&
        (partial_product(idx_a * 2)(idx_b * 2 + 1) << offset_bitwidth).asUInt() +&
        (partial_product(idx_a * 2 + 1)(idx_b * 2 + 1) << 2 * offset_bitwidth).asUInt()
    }
    println("Partial Width = " + partial_result_width
      + "Old Size = " + size_a + ", new size = " + new_size)
    (partial_product_array.grouped(new_size).toIndexedSeq, offset_bitwidth * 2)
  }

}

class UMUL(data_width : Int) extends Module{
  val io = IO(new Bundle{
    val a = Input(UInt(data_width.W))
    val b = Input(UInt(data_width.W))
    val p = Output(UInt((data_width * 2).W))
  })

  io.p := io.a * io.b

}

object gen_UMUL_composed extends App{
  chisel3.Driver.execute(args,()=>{
    val module = new UMUL_composed(64, 16)
    println(module)
    module
  })
}

object gen_UMUL extends App {
  chisel3.Driver.execute(args,()=>{
    val module = new UMUL(64)
    println(module)
    module
  })
}