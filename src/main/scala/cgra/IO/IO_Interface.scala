package cgra.IO
/*
import chisel3._
import chisel3.util._
import cgra.config.Constant._
import cgra.entity.Port
import cgra.fabric.Shared_PE.common.interconnect.{link_if_in, link_if_out}
import scala.collection.mutable.ListBuffer
*/
object IO_Interface {
  /*
  def get_io(p:ListBuffer[Port]) = {
    p.map(x=>{
      x.Parameters("IO_Type").v match {
        case INPUT_TYPE =>{
          x.Parameters("hasValid").v match {
            case true =>
              Flipped(x.Parameters("hasReady").v match {
                case true =>{
                  val word_width = x.get("Word_Width").asInstanceOf[Int]
                  if (word_width >1){
                    DecoupledIO(UInt(x.get("Word_Width").asInstanceOf[Int].W))
                  }else{
                    DecoupledIO(Bool())
                  }
                }
                case false =>{
                  val word_width = x.get("Word_Width").asInstanceOf[Int]
                  if (word_width >1){
                    ValidIO(UInt(x.get("Word_Width").asInstanceOf[Int].W))
                  }else{
                    ValidIO(Bool())
                  }
                }
              })
            case false =>{
              val word_width = x.get("Word_Width").asInstanceOf[Int]
              if (word_width >1){
                Input(UInt(x.get("Word_Width").asInstanceOf[Int].W))
              }else{
                Input(Bool())
              }
            }
          }
        }
        case OUTPUT_TYPE =>{
          x.Parameters("hasValid").v match {
            case true =>
              x.Parameters("hasReady").v match {
                case true =>{
                  val word_width = x.get("Word_Width").asInstanceOf[Int]
                  if (word_width >1){
                    DecoupledIO(UInt(x.get("Word_Width").asInstanceOf[Int].W))
                  }else{
                    DecoupledIO(Bool())
                  }
                }
                case false =>{
                  val word_width = x.get("Word_Width").asInstanceOf[Int]
                  if (word_width >1){
                    ValidIO(UInt(x.get("Word_Width").asInstanceOf[Int].W))
                  }else{
                    ValidIO(Bool())
                  }
                }
              }
            case false =>{
              val word_width = x.get("Word_Width").asInstanceOf[Int]
              if (word_width >1){
                Output(UInt(x.get("Word_Width").asInstanceOf[Int].W))
              }else{
                Output(Bool())
              }
            }
          }
        }
        case MMIO_TYPE =>
          mmio_if(x.get("Index_Width").asInstanceOf[Int],x.get("Word_Width").asInstanceOf[Int])
        case MULTI_TAG_PACKET_TYPE =>
          val num_channel = x.Parameters("num_channel").value.asInstanceOf[Int]
          val tag_width = x.Parameters("tag_width").value.asInstanceOf[Int]
          val word_width = x.Parameters("word_width").value.asInstanceOf[Int]
          x.Parameters("IO Type").value.toString match {
            case INPUT_TYPE =>
              Vec(num_channel,new link_if_in(tag_width,word_width))
            case OUTPUT_TYPE =>
              Vec(num_channel,new link_if_out(tag_width,word_width))
          }
      }
    }).toList
  }
  */
}
/*
case class mmio_if(index_width:Int,word_width:Int) extends Bundle {

  // DEVICE that store data, **use Flipped(new mmio_if) for those who consume data (like ALU)

  val read_req = Input(Bool())
  val read_ack = Output(Bool())
  val read_index = Input(UInt(index_width.W))
  val read_data = Output(UInt(word_width.W))

  val write_req = Input(Bool())
  val write_ack = Output(Bool())
  val write_index = Input(UInt(index_width.W))
  val write_data = Input(UInt(word_width.W))
}
*/