package cgra.fabric.XmlV.common

import cgra.config.Constant._
import cgra.entity._

class Decomposer extends Entity{

  val input_ports = Ports.filter(p=>p.io == INPUT_TYPE)
  val output_ports = Ports.filter(p=>p.io == INPUT_TYPE)

  def forsyn = {}
}
