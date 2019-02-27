package cgra.parameter

import config._
import cgra.parameter.Constant._
import chisel3.util.log2Ceil

// --------------Module Config-----------------------------------------
// Internal Module Key
trait IsKey
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
}

// Internal Module Parameter
trait IsParameters {
  var config_sec : Int = -1
  var base : Int = -1
  var bound : Int = -1
  def get_bound(num_option:Int):Int = {bound = base + log2Ceil(num_option) - 1;bound}
}

case class MUX() extends IsParameters
  with WithOperandIndex{
  //var index : Int = -1
  var sources : List[port_subnet] = Nil // Reconfigurable

  def add_source(p:Int,s:Int,d:Int) : Unit = {
    if (!sources.exists(x=>x.equals(port_subnet(INPUT_TYPE,p,s,d))))
      sources = sources ::: List(port_subnet(INPUT_TYPE,p,s,d))
  }
  def get_config_range = log2Ceil(sources.length)
  def add_source(ps:port_subnet) : Unit = add_source(ps.port,ps.subnet,ps.num_subnet)
  def hasSource = sources.nonEmpty
  def notInitialized = !hasSource
}
case class Delay_Pipe() extends IsParameters
  with WithOperandIndex {
  //var index : Int = -1
  var delay : List[Int] = Nil // Reconfigurable
  var max_delay : Int = -1
  def add_delay_option (n:Int) :Unit = {
    delay = delay ::: List(n)
    max_delay = delay max
  }
  def get_delay_by_max_delay : Unit = delay = (0 to max_delay).toList
}
case class Alu() extends IsParameters{
  //var index : Int = -1
  var inst : List[Int] = Nil // Reconfigurable
  var num_operand : Int = -1
  var num_opcode = -1
  def add_inst(i:Int) : Unit = {
    inst = inst ::: List(i)
    num_opcode = inst length
  }
}

// Internal Module Trait
trait WithOperandIndex {
  var operand_index : Int = -1
  def SetOperandIndex(oi:Int) = operand_index = oi
}


/*
class Dedicated_PE_Config[T](key:T) extends Config((site, here, up) => {
  case key:Dedicated_PE => DedicatedPeParams("",key.parent_id,key.tile_id)
})

class Shared_PE_Config[T](key:T) extends Config((site, here, up) => {
  case key:Shared_PE => SharedPeParams("",key.parent_id,key.tile_id)
})

class Alu_Config[T](key:T) extends Config((site,here,up) => {
  case key:Alu => AluParams("PE",key.parent_id,key.tile_id)
})

class Router_Config[T](key:T) extends Config((site,here,up) => {
  case key:Router => RouterParams("",key.parent_id,key.tile_id)
})


class Tile_Config[T](key:T) extends Config((site,here,up) => {
  case key:Shared_PE => SharedPeParams(key.parent_name,key.parent_id,key.tile_id)
  case key:Dedicated_PE => DedicatedPeParams(key.parent_name,key.parent_id,key.tile_id)
  case key:Router => RouterParams(key.parent_name,key.parent_id,key.tile_id)
  case key:Alu => AluParams(key.parent_name,key.parent_id,key.tile_id)
})
*/