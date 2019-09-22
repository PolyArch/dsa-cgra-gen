package dsl.real

import dsl._

object test extends App {

  val node1 = new ssnode("sw")

  node1("mesh",456)("god",List("cold",1))(
    "map",Map("a" -> 123, 134 -> 435.245)
  )

  val node2 = node1.clone()

  val test = new ssfabric

  test(node1 --> node2)

  test(node1 --> node2)

  //test(node1,node2).foreach(l=>l.reverse())

  node1("nodeType","fu")

  test.printfile("IR/test")
}
