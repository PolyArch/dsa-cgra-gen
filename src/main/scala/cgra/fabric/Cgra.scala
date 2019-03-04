package cgra.fabric

import cgra.parameter._

import scala.xml.Elem

// CGRA (for further use, in case we need one CGRA to be a tile itself, which means we can have multiple CGRAs)
case class CgraParams(parent_type: String,
                      parent_id: Int,
                      tile_id:Int)
  extends TileParams(parent_type: String,parent_id:Int,tile_id:Int)
    with IsParameters {
  override val TYPE: String = "CGRA"

  var ProcessingElements_Size:(Int,Int) = (0,0)

  private var routers_params :List[RouterParams] = Nil
  private var pe_params : List[PeParams] = Nil
  private var interface_port_params : List[InterfacePortParams] = Nil
  private var connects_params : List[ConnectParam] = Nil

  def fill_processing_element(pe:TileParams) : Unit = {

  }
  def interconnect (connects:List[ConnectParam]) : Unit ={
    connects_params = connects
  }

  def ReadyForSynthesis: Unit = {

  }
  def toXML(k:IsKey) : Elem = {
    <Cgra>
    </Cgra>
  }
}

class Cgra {

}
