package cgra.parameter

import config._
import cgra.parameter.Constant._
import chisel3.util.log2Ceil

import scala.xml.Elem

// --------------Module Config-----------------------------------------
// Internal Module Key
trait IsKey {
  var refer_id :Int = -1
  def toXML(k:IsKey) : Elem
  def KeyXML : Elem = {
    <refer_id>{refer_id}</refer_id>
  }
}
case class port_subnet(t:String,p:Int,s:Int,d:Int) extends IsKey {
  var io : String = t
  var port : Int = p
  var subnet : Int = s
  var num_subnet : Int = d
  override def equals(o: Any): Boolean = {
    var result : Boolean = o match {
      case o:port_subnet => {
        io == o.io && port == o.port && subnet == o.subnet// && num_subnet == o.subnet
      }
      case _ => false
    }
    result
  }

  override def KeyXML: Elem = {
    toXML(this)
  }
  def toXML(k:IsKey) = {
    <port_subnet>
      <io_type>{io}</io_type><port>{port}</port><subnet>{subnet}</subnet>
    </port_subnet>
  }
}

// Internal Module Parameter
trait IsParameters extends IsKey{
  var config_sec : Int = -1
  var base : Int = -1
  var bound : Int = -1
  def get_bound(num_option:Int):Int = {bound = base + log2Ceil(num_option) - 1;bound}
  def toXML(k:IsKey) : Elem
  def get_config_XML  = {
    <CONFIG><CONFIG_BASE>{base}</CONFIG_BASE><CONFIG_BOUND>{bound}</CONFIG_BOUND><CONFIG_SECTION>{config_sec}</CONFIG_SECTION></CONFIG>
  }
}
// Internal Module Trait
trait WithOperandIndex {
  var operand_index : Int = -1
  def SetOperandIndex(oi:Int) = operand_index = oi
}

// ------ MUX ------
case class MUX() extends IsParameters
  with WithOperandIndex
  with IsKey{
  var sources : List[port_subnet] = Nil // Reconfigurable
  def add_source(p:Int,s:Int,d:Int) : Unit = {
    if (!sources.exists(x=>x.equals(port_subnet(INPUT_TYPE,p,s,d))))
      sources = sources ::: List(port_subnet(INPUT_TYPE,p,s,d))
  }
  def get_config_range = log2Ceil(sources.length)
  def add_source(ps:port_subnet) : Unit = add_source(ps.port,ps.subnet,ps.num_subnet)
  def hasSource = sources.nonEmpty
  def notInitialized = !hasSource

  def toXML(k:IsKey) ={
    <MUX>
      {KeyXML}
      {get_config_XML}
      {sources.zipWithIndex.map(x=> <Mux_Source><sel>{x._2}</sel>{x._1.KeyXML}</Mux_Source>)}
      <Mux_Destination>{k.KeyXML}</Mux_Destination>
    </MUX>
  }
}

// ------ Delay Pipe ------
case class Delay_Pipe() extends IsParameters
  with WithOperandIndex
  with IsKey {
  var sources : List[IsKey] = Nil
  var delay : List[Int] = Nil // Reconfigurable
  var max_delay : Int = -1
  def add_delay_option (n:Int) :Unit = {
    delay = delay ::: List(n)
    max_delay = delay max
  }
  def get_delay_by_max_delay : Unit = delay = (0 to max_delay).toList
  def toXML(k:IsKey) = {
    <DELAY_PIPE>
      {KeyXML}
      {get_config_XML}
    </DELAY_PIPE>
  }
}

// ------ Arithmetic Logic Unit ------
case class Alu() extends IsParameters
  with IsKey{
  var sources : List[IsKey] = Nil
  var inst : List[Int] = Nil // Reconfigurable
  var num_operand : Int = -1
  var num_opcode = -1
  def add_inst(i:Int) : Unit = {
    inst = inst ::: List(i)
    num_opcode = inst length
  }
  def toXML(k:IsKey) = {
    <ALU>
      {KeyXML}
      {get_config_XML}
    </ALU>
  }
}