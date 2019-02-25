package cgra.config

// This package is for those parameters that are just part of module's parameters,
// which can be instantiated to a true module

case class subnet_location_param (sp:Int,ss:Int){
  var port:Int = sp
  var subnet:Int = ss
}

case class subnet_param() {
  var source_param : List[subnet_location_param] = Nil
}

case class port_param(io_type:String,port_index:Int,num_subnet:Int) {

  lazy val subnets_param : List[subnet_param] =
    List.fill[subnet_param](num_subnet)(subnet_param())
  var destination_config : List[List[subnet_location_param]] = Nil
  var method : String = "Group by Port"

  // Method
  def num_config = destination_config.length
  def get_io_type = io_type
  def isInput = io_type == "input"
  def isOutput = io_type == "output"
  def use_default_port_params : port_param = {
    this
  }
  def get_source_mode: List[List[subnet_location_param]] = get_source_mode(method)
  def get_source_mode(method:String) : List[List[subnet_location_param]] = {
    method match {
      case "Full" =>
        println("[warn] Full Interconnection can be really complicated")
        destination_config =
          crossJoin(subnets_param.map(_.source_param)).map(_.toList).toList
        destination_config
      case "Group by Port" =>
        val port_list : List [Int]= subnets_param.flatMap(_.source_param.map(_.port)).distinct
        var res : List[List[subnet_location_param]] = Nil
        for (port <- port_list){
          val source_for_each_subnet = subnets_param.map(_.source_param.filter(_.port == port))
          if (source_for_each_subnet.contains(Nil)){
            throw new Exception("Group by Port require every subnet have same input port")
          }
          val current_group_combination = crossJoin(source_for_each_subnet)
          res = res ::: current_group_combination.asInstanceOf[List[List[subnet_location_param]]]
        }
        destination_config = res
        destination_config
      case "Group by Index" =>
        val subnet_list : List [Int]= subnets_param.flatMap(_.source_param.map(_.subnet)).distinct
        var res : List[List[subnet_location_param]] = Nil
        for (subnet <- subnet_list){
          val source_for_each_subnet = subnets_param.map(_.source_param.filter(_.subnet == subnet))
          if (source_for_each_subnet.contains(Nil)){
            throw new Exception("Group by Subnet require every subnet have same input subnet")
          }
          val current_group_combination = crossJoin(source_for_each_subnet)
          res = res ::: current_group_combination.asInstanceOf[List[List[subnet_location_param]]]
        }
        destination_config = res
        destination_config
      case _ => throw new Exception("No such method")
    }
  }
  private def crossJoin[T](list: Traversable[Traversable[T]]): Traversable[Traversable[T]] =
    list match {
      case xs :: Nil => xs map (Traversable(_))
      case x :: xs => for {
        i <- x
        j <- crossJoin(xs)
      } yield Traversable(i) ++ j
    }
}