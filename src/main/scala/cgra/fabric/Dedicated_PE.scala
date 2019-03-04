package cgra.fabric

import cgra.common.mmio.mmio_if
import cgra.parameter._
import chisel3._

import scala.xml.Elem

// ------ Parameters ------
case class DedicatedPeParams(parent_type: String,
                             parent_id: Int,
                             tile_id:Int)
  extends PeParams(parent_type: String,parent_id:Int,tile_id:Int)
    with IsParameters {
  override val inst_firing : String = "dedicated"




  def ReadyForSynthesis: Unit = {

  }
  def toXML(k:IsKey) : Elem = {
    <Processing_Element>
      <InstructionFiring>{inst_firing}</InstructionFiring>
    </Processing_Element>
  }
}

// ------ Module ------
class Dedicated_PE(p:TileParams) extends Module {
  val param = p.asInstanceOf[DedicatedPeParams]
  val io = IO(new Bundle{
    val tile_io = param.get_tile_bundle
    val host_interface = new mmio_if
  })

  val num_output = param.get_num_output
  val num_input = param.get_num_input
  val word_width = param.get_word_width

  val input_decomposer = param.input_word_width_decomposer
  val output_decomposer = param.output_word_width_decomposer
}