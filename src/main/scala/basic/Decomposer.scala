package basic

import basic.Constant._

class Decomposer extends Entity{

  val input_ports = Ports.filter(p=>p.io == INPUT_TYPE)
  val output_ports = Ports.filter(p=>p.io == INPUT_TYPE)

  def forsyn = {}
}
