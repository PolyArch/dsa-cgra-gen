package cgra.config

import config._

// --------------Module Config-----------------------------------------

trait IsKey
case class port_subnet(t:String,p:Int,s:Int) extends IsKey {
  var io : String = t
  var port : Int = p
  var subnet : Int = s
  var num_subnet : Int = s
}

trait IsParameters
case class Mux_source_param() extends WithOperandIndex
   with IsParameters {
  var index : Int = -1
  var source_port_subnet : List[(Int,Int)] = Nil
  def add_source(p:Int,s:Int) : Unit =
    source_port_subnet = source_port_subnet ::: List((p,s))
  def hasSource = source_port_subnet.nonEmpty
  def notInitialized = !hasSource
}
case class Delay_pipe_param() extends WithOperandIndex
  with IsParameters {
  var index : Int = -1
  var delay : List[Int] = Nil
  var max_delay : Int = -1
}
case class Alu_param() extends IsParameters {
  var index : Int = -1
  var inst : List[Int] = Nil
  var num_operand : Int = -1
  var num_opcode = -1
}

class WithOperandIndex {
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