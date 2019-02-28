package cgra.fabric

import cgra.parameter._


// ------ Parameter ------
case class SharedPeParams(parent_type: String,
                          parent_id: Int,
                          tile_id:Int)
  extends PeParams(parent_type: String,parent_id:Int,tile_id:Int)
    with IsParameters {
  override val inst_firing : String = "shared"

  def ReadyForSynthesis: Unit = {

  }
}

// ------ Module ------
class Shared_PE {

}
