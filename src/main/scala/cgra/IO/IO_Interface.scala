package cgra.IO

import chisel3._
import chisel3.util._
import cgra.config.Constant._
import cgra.entity.Port

import scala.collection.mutable.ListBuffer

object IO_Interface {
  def get_io(p:ListBuffer[Port]) = {
    MixedVec(p map (x=>{
      x.Parameters("IO_Type").v match {
        case INPUT_TYPE =>{
          x.Parameters("hasValid").v match {
            case true =>
              Flipped(x.Parameters("hasReady").v match {
                case true =>
                  DecoupledIO(UInt(x.get("Word_Width").asInstanceOf[Int].W))
                case false =>
                  ValidIO(UInt(x.get("Word_Width").asInstanceOf[Int].W))
              })
            case false =>
              Input(UInt(x.get("Word_Width").asInstanceOf[Int].W))
          }
        }
        case OUTPUT_TYPE =>{
          x.Parameters("hasValid").v match {
            case true =>
              x.Parameters("hasReady").v match {
                case true =>
                  DecoupledIO(UInt(x.get("Word_Width").asInstanceOf[Int].W))
                case false =>
                  ValidIO(UInt(x.get("Word_Width").asInstanceOf[Int].W))
              }
            case false =>
              Output(UInt(x.get("Word_Width").asInstanceOf[Int].W))
          }
        }
        case MMIO_TYPE =>
          mmio_if(x.get("Index_Width").asInstanceOf[Int],x.get("Word_Width").asInstanceOf[Int])
      }
    }))
  }
}

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