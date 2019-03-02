package cgra.fabric

import cgra.parameter._

import scala.xml.Elem

// ------ Parameters ------
case class InterfacePortParams(parent_type: String,
                               parent_id: Int,
                               tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int)
  with IsParameters {
  refer_id = tile_id
  override val TYPE:String = "ip_port"
  var buffer_depth       : Array[Int] = null
  def ReadyForSynthesis: Unit = {

  }
  def toXML(k:IsKey) : Elem = {
    <InterfacePort>
    </InterfacePort>
  }
}

// ------ Module ------
class new_Interface_Port {

}
