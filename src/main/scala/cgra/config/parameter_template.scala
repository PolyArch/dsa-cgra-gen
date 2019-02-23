package cgra.config


case class subnet_source_param (sp:Int,ss:Int){
  var port:Int = sp
  var subnet:Int = ss
}

case class subnet_param() {
  var source_param : List[subnet_source_param] = Nil
}

class port_param(num_subnet:Int) {
  val subnets_param : List[subnet_param] = List.fill[subnet_param](num_subnet)(subnet_param())

  def getModes(method:String) : Traversable[Traversable[subnet_source_param]] = {
    method match {
      case "Full" =>
        println("[warn] Full Interconnection can be really complicated")
        crossJoin(subnets_param.map(_.source_param))
      case "Group by Port" =>
        val port_list : List [Int]= subnets_param.flatMap(_.source_param.map(_.port)).distinct
        var res : List[List[subnet_source_param]] = Nil
        for (port <- port_list){
          val source_for_each_subnet = subnets_param.map(_.source_param.filter(_.port == port))
          if (source_for_each_subnet.contains(Nil)){
            throw new Exception("Group by Port require every subnet have same input port")
          }
          val current_group_combination = crossJoin(source_for_each_subnet)
          res = res ::: current_group_combination.asInstanceOf[List[List[subnet_source_param]]]
        }
        res
      case "Group by Index" =>
        val subnet_list : List [Int]= subnets_param.flatMap(_.source_param.map(_.subnet)).distinct
        var res : List[List[subnet_source_param]] = Nil
        for (subnet <- subnet_list){
          val source_for_each_subnet = subnets_param.map(_.source_param.filter(_.subnet == subnet))
          if (source_for_each_subnet.contains(Nil)){
            throw new Exception("Group by Subnet require every subnet have same input subnet")
          }
          val current_group_combination = crossJoin(source_for_each_subnet)
          res = res ::: current_group_combination.asInstanceOf[List[List[subnet_source_param]]]
        }
        res
      case _ => throw new Exception("No such method")
    }
  }
  def crossJoin[T](list: Traversable[Traversable[T]]): Traversable[Traversable[T]] =
    list match {
      case xs :: Nil => xs map (Traversable(_))
      case x :: xs => for {
        i <- x
        j <- crossJoin(xs)
      } yield Traversable(i) ++ j
    }
}