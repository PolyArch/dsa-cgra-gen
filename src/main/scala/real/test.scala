package real

import dsl._

object test extends App {

  val node1 = new ssnode("sw")

  node1("mesh",456)("god",List("cold",1))(
    "map",Map("a" -> 123, 134 -> 435.245)
  )

  val node2 = node1.clone()

  val node3 = node2.clone()

  val test = new ssfabric

  test(node1 --> node2)(
    node1 --> node2)(
    node3 --> node1)(
    node3 --> node2)(
    node2 --> node1)



  //test(node1,node2).foreach(l=>l.reverse())

  node1("nodeType","fu")

  test.printIR("IR/test")
}
