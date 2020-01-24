package cgra.component

import chisel3._
import chisel3.util._

class UADD(data_width : Int) extends Module{
  val io = IO(
    new Bundle{
      val a = Input(UInt(data_width.W))
      val b = Input(UInt(data_width.W))
      val s = Output(UInt(data_width.W))
    }
  )
  io.s := io.a + io.b
}


class UADD_composed(data_width : Int, finest_width : Int) extends Module{

  private val decomposer : Int = data_width / finest_width
  private val num_ctrl : Int = log2Ceil(decomposer) + 1

  val io = IO(
    new Bundle{
      val a = Input(UInt(data_width.W))
      val b = Input(UInt(data_width.W))
      val result = Output(UInt(data_width.W))
      val ctrl = Input(UInt({log2Ceil(num_ctrl) max 1}.W))
      // 0 -> 64, 1 -> 32x2, 2 -> 16x4, 3 -> 8x8
    }
  )

  // Fine Bit Width
  private val Ai : IndexedSeq[UInt]= for(idx <- 0 until decomposer) yield {
    io.a((idx+1)*finest_width-1,idx*finest_width)
  }
  private val Bi : IndexedSeq[UInt] = for(idx <- 0 until decomposer) yield {
    io.b((idx+1)*finest_width-1,idx*finest_width)
  }

  // Partial Product (each partial product is double-wide of finest width)
  private val Ai_add_Bi : IndexedSeq[UInt] = for(idx <- 0 until decomposer) yield {
    Ai(idx) +& Bi(idx)
  }

  // Reduce the partial result for different decomposability level
  private var temp_offset = finest_width
  private var temp_part_result = Ai_add_Bi
  private val reduce_results =
    (for (reduce_idx <- 0 until log2Ceil(decomposer)) yield {
      val curr_partial_product = reducePartialSum(temp_part_result, temp_offset)
      temp_part_result = curr_partial_product._1
      temp_offset = curr_partial_product._2
      curr_partial_product
    }).reverse :+ (Ai_add_Bi, finest_width)

  // Concat result from different decomposability level
  val mul_result = for (idx <- reduce_results.indices) yield {
    val partial_sum = reduce_results(idx)._1
    val decomp_width = reduce_results(idx)._2
    val size = partial_sum.length
    val result : UInt = (for (diag_idx <- 0 until size) yield {
      val curr_result = partial_sum(diag_idx)
      printf(p"width of decomp result = $decomp_width\n")
      curr_result(decomp_width - 1,0)
    }).reverse.reduce(Cat(_,_))
    (idx.U,result)
  }

  for(idx <- 0 until decomposer){
    printf(p"A($idx) = ${Ai(idx)}, B($idx) = ${Bi(idx)}, ")
    printf(p"A($idx) + B($idx) = ${Ai_add_Bi(idx)}\n")
  }

  io.result := MuxLookup(io.ctrl, 0.U, mul_result)

  def reducePartialSum(partial_sum : IndexedSeq[UInt], offset_bitwidth : Int) :
  (IndexedSeq[UInt], Int) = {
    val size = partial_sum.length
    val partial_result_width = partial_sum.map(_.getWidth).distinct
    require(size % 2 == 0)
    val new_size = size / 2
    val reduced_partial_sum = for
      (idx <- 0 until new_size) yield {

        Cat(
          partial_sum(idx * 2 + 1) + partial_sum(idx * 2)(offset_bitwidth),
          partial_sum(idx * 2)(offset_bitwidth - 1,0)
        )

        //partial_sum(idx * 2) + (partial_sum(idx * 2 + 1) << offset_bitwidth).asUInt
      }
    println("Partial Width = " + partial_result_width +
      ", Old Size = " + size + ", new size = " + new_size)
    (reduced_partial_sum, offset_bitwidth * 2)
  }

}

import GenUtil.GenUtil._
object gen_UADD extends App{
  chisel3.Driver.execute(args,()=>{
    val module = new UADD(64)
    println(module)
    module
  })
}

object gen_UADD_composed extends App{

  val data_widths = List(16,32,64)
  val granularities = List(8,16,32,64)

  for(dw<- data_widths; gr <- granularities){
    if(gr <= dw){
      chisel3.Driver.execute(args,()=>{
        val module = new UADD_composed(dw, gr)
        module
      })
    }
  }
}