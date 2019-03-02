package cgra.fabric

import cgra.parameter._

import scala.xml.Elem


// ------ Parameter ------
case class SharedPeParams(parent_type: String,
                          parent_id: Int,
                          tile_id:Int)
  extends PeParams(parent_type: String,parent_id:Int,tile_id:Int)
    with IsParameters {
  override val inst_firing : String = "shared"

  def ReadyForSynthesis: Unit = {

  }
  def toXML(k:IsKey) : Elem = {
    <Processing_Element>
    </Processing_Element>
  }
}

// ------ Module ------
class Shared_PE {

}
