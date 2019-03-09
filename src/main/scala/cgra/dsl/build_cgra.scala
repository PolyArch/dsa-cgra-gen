package cgra.dsl

import cgra.build.Build
import cgra.fabric.{Dedicated_PE, Router}

class build_cgra extends Build{

  val word_width = 64
  val reg_file_length = 4
  val reg_file_width = 16

  val dedi_pe = Dedicated_PE()
  val switch = Router()

//  dedi_pe have ()

}
