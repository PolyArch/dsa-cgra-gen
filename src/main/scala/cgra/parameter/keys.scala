// This file contains parameters that can truly be turned to hardware(tiles), should be case class

package cgra.parameter

import config._
import cgra.fabric._

import scala.xml.Elem


// ------ Keys ------

case class Connect(id:Int,source_refer_id:Int,destination_refer_id:Int)
  extends Field[ConnectParam]
  with IsKey

case class Router private (parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[RouterParams](RouterParams(parent_name,parent_id,tile_id))
    with IsKey

case class Dedicated_PE private (parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[DedicatedPeParams](DedicatedPeParams(parent_name,parent_id,tile_id))
    with IsKey

case class Shared_PE private (parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[SharedPeParams](SharedPeParams(parent_name,parent_id,tile_id))
    with IsKey

case class Cgra private (parent_name:String,parent_id:Int,tile_id:Int)
  extends Field[CgraParams](CgraParams(parent_name,parent_id,tile_id))
    with IsKey