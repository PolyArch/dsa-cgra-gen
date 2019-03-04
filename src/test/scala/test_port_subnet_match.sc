import scala.math.log

def port_subnet_match(is:Int,os:Int,nis:Int,nos:Int):Boolean={
  var index_more = is
  var index_less = os
  var num_more = nis
  var num_less = nos
  if (nis<nos){
    var index_more = os
    var index_less = is
    var num_more = nos
    var num_less = nis
    println("Changed")
  }

  println(index_more >> (log(num_more/num_less)/log(2)).toInt)
  println(num_more)
  println(num_less)

  index_less == (index_more >> (log(num_more/num_less)/log(2)).toInt)
}

port_subnet_match(2,11,4,16)