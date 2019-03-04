import cgra.parameter.Constant.INPUT_TYPE
import cgra.parameter.{IsKey, IsParameters, WithOperandIndex, port_subnet}
import chisel3.util.log2Ceil

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
  def toXML = <port_subnet>{io} {port} {subnet} {num_subnet}</port_subnet>
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

  def toXML = <mux> {sources.map(_.toXML)} </mux>
}