// See README.md for license details.

package dsl.generator

import dsl.IR._
import cgra._
import tile.ModuleChannel



trait CgraGenerator {

  def cgraGenerate(model:CgraModel):CgraInstance = {
      new CgraInstance
  }

  class CgraInstance {

      var SwitchList: List[Switch] = List()
      var FuList: List[FU] = List()
      var ConnectionList: List[ModuleChannel] = List()
      var InterfacePortList: List[InterfacePort] = List()
  }
}



