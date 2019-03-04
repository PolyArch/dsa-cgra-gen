package cgra.parameter

// This package is for those parameters that are just part of module's parameters,
// which can be instantiated to a true module

case class subnet_location_param (sp:Int,ss:Int){
  var port:Int = sp
  var subnet:Int = ss
}

case class subnet_param() {
  var source_param : List[subnet_location_param] = Nil

  var multiple_factor : Int = 0
  var multiple_source_param : List[List[subnet_location_param]] = Nil
  var multiple_delay_param : List[Int] = Nil
  var multiple_alu_param : List[Int] = Nil
}

case class port_param(io_type:String,port_index:Int,num_subnet:Int) {

  lazy val subnets_param : List[subnet_param] =
    List.fill[subnet_param](num_subnet)(subnet_param())

  var source_configs : List[List[subnet_location_param]] = Nil
  var multiple_source_configs :  List[List[List[subnet_location_param]]] = Nil

  var method : String = "Group by Port"

  // Method
  def num_config = source_configs.length
  def get_io_type = io_type
  def isInput = io_type == "input"
  def isOutput = io_type == "output"
  def use_default_port_params : port_param = {
    this
  }
  def get_source_mode(set_of_subnet_source:List[List[subnet_location_param]])
  : List[List[subnet_location_param]] = get_source_mode(method,set_of_subnet_source)
  def get_source_mode(method:String,set_of_subnet_source:List[List[subnet_location_param]])
  : List[List[subnet_location_param]] = {
    method match {
      // set_of_subnet_source = subnets_param.map(_.source_param)
      case "Full" =>
        println("[warn] Full Interconnection can be really complicated")
        source_configs =
          crossJoin(set_of_subnet_source).map(_.toList).toList
        source_configs
      // subnets_param.flatMap(_.source_param.map(_.port)) == set_of_subnet_source.flatMap(_.map(_.port))
      case "Group by Port" =>
        val port_list : List [Int]= set_of_subnet_source.flatMap(_.map(_.port)).distinct
          //subnets_param.flatMap(_.source_param.map(_.port)).distinct
        var res : List[List[subnet_location_param]] = Nil

        for (port <- port_list){
          val source_for_each_subnet = set_of_subnet_source.map(_.filter(_.port == port))
            //subnets_param.map(_.source_param.filter(_.port == port))
          if (source_for_each_subnet.contains(Nil)){
            throw new Exception("Group by Port require every subnet have same input port")
          }
          val current_group_combination = crossJoin(source_for_each_subnet)
          res = res ::: current_group_combination.asInstanceOf[List[List[subnet_location_param]]]
        }
        source_configs = res
        source_configs
      // subnets_param.flatMap(_.source_param.map(_.subnet)) == set_of_subnet_source.flatMap(_.map(_.subnet))
      case "Group by Index" =>
        val subnet_list : List [Int]= set_of_subnet_source.flatMap(_.map(_.subnet)).distinct
          //subnets_param.flatMap(_.source_param.map(_.subnet)).distinct
        var res : List[List[subnet_location_param]] = Nil
        for (subnet <- subnet_list){
          val source_for_each_subnet = set_of_subnet_source.map(_.filter(_.subnet == subnet))
            //subnets_param.map(_.source_param.filter(_.subnet == subnet))
          if (source_for_each_subnet.contains(Nil)){
            throw new Exception("Group by Subnet require every subnet have same input subnet")
          }
          val current_group_combination = crossJoin(source_for_each_subnet)
          res = res ::: current_group_combination.asInstanceOf[List[List[subnet_location_param]]]
        }
        source_configs = res
        source_configs
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