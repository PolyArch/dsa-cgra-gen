package cgra.fabric.common.datapath

import cgra.fabric.Reconfigurable

import scala.xml.Elem


class Multiplexer extends Reconfigurable{
  var config_high : Int = -1
  var config_low : Int = -1
  var sources : List[String] = Nil
  var sink : String = ""
  var subnet : Int = -1
  var operand : Int = -1
  def config2XML : Elem = {
    <MUX>
      <Config_High_Bit>{config_high}</Config_High_Bit>
      <Config_Low_Bit>{config_low}</Config_Low_Bit>
      <Sources>
        {sources.zipWithIndex.map(s=>{
        <Source>
          <Select>{s._2}</Select><Port>{sources(s._2)}</Port>
        </Source>
      })}
      </Sources>
      <Sink><Port>{sink}</Port></Sink>
      {if(operand != -1) <Idx_Operand>{operand}</Idx_Operand>}
    </MUX>
  }
}