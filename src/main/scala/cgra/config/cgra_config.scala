package cgra.config

import config._

// --------------Module Config-----------------------------------------
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
trait isKey

trait isParameters