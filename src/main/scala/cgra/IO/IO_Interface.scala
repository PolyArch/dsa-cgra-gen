package cgra.IO

import chisel3.{Bundle, _}
import chisel3.util._

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

case class ReqAckConf_if(ww:Int) extends Bundle {
  val valid = Output(Bool())
  val bits = Output(UInt(ww.W))
  val ready = Input(Bool())
  val config = Output(Bool())

  override def cloneType: ReqAckConf_if.this.type = ReqAckConf_if(ww).asInstanceOf[this.type]
}

case class ReqAckConf_t(ww:Int) extends Bundle{
  val valid : Bool = Bool()
  val bits : UInt = UInt(ww.W)
  val ready : Bool = Bool()
  val config : Bool = Bool()
}
object port_generator {
  def gc_port (p:ReqAckConf_if, t:String):Unit={
    t match {
      case "Data" => p.valid := DontCare;p.config := DontCare;p.ready := DontCare
      case "Data_Valid" => p.config := DontCare;p.ready := DontCare
      case "Data_Valid_Ready" => p.config := DontCare
      case "Data_Config" =>  p.valid := DontCare;p.ready := DontCare
      case "Data_Valid_Config" => p.ready := DontCare
      case "Data_Valid_Ready_Config" =>
    }
  }
  /*
  def get_port(t:String,ww:Int) = {
    val port = t match {
      case "Data" => new ReqAckConf_if(ww){valid := DontCare;config := DontCare;ready := DontCare}
      case "Data_Valid" => new ReqAckConf_if(ww){config := DontCare;ready := DontCare}
      case "Data_Valid_Ready" => new ReqAckConf_if(ww){config := DontCare}
      case "Data_Config" =>  new ReqAckConf_if(ww){valid := DontCare;ready := DontCare}
      case "Data_Valid_Config" => new ReqAckConf_if(ww){ready := DontCare}
      case "Data_Valid_Ready_Config" => new ReqAckConf_if(ww)
    }
    port
  }
  */
}
/*
object port_generator {
  def get_port(t:String,ww:Int):Bundle= {
    val port = t match {
      case "Data" => Data_IO(ww)
      case "Data_Valid" => Data_Valid_IO(ww)
      case "Data_Valid_Ready" => Data_Valid_Ready(ww)
      case "Data_Config" => Data_Config_IO(ww)
      case "Data_Valid_Config" => Data_Valid_Config_IO(ww)
      case "Data_Valid_Ready_Config" => Data_Valid_Ready_Config(ww)
    }
    port
  }
}
*/

case class config_wire(ww:Int) extends Bundle {
  val bits = UInt(ww.W)
  val config = Bool()
}
/*
case class Data_IO(ww:Int)extends Bundle{val bits = Output(UInt(ww.W))}
case class Data_Valid_IO(ww:Int)extends Bundle{val bits = Output(UInt(ww.W));val valid = Output(Bool())}
case class Data_Valid_Ready(ww:Int)extends Bundle{val bits = Output(UInt(ww.W));val valid = Output(Bool());val ready = Input(Bool())}
case class Data_Config_IO(ww:Int)extends Bundle{val bits = Output(UInt(ww.W));val config = Output(Bool())}
case class Data_Valid_Config_IO(ww:Int)extends Bundle{val bits = Output(UInt(ww.W));val valid = Output(Bool());val config = Output(Bool())}
case class Data_Valid_Ready_Config(ww:Int)extends Bundle{val bits = Output(UInt(ww.W));val valid = Output(Bool());val ready = Input(Bool());val config = Output(Bool())}
*/

class has_bits_io(ww:Int) extends Bundle {
  val bits : UInt = Output(UInt(ww.W))
}

trait has_valid_io extends Bundle {
  val valid : Bool = Output(Bool())
}

trait has_ready_io extends Bundle {
  val ready : Bool = Input(Bool())
}

trait has_config_io extends Bundle {
  val config : Bool = Output(Bool())
}
