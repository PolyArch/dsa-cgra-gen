package real

import dsl._

object micro_demo_answer extends App{

  // define vector port
  val vport_i1 = new ssnode("vector port")
  val vport_i2 = new ssnode("vector port")
  val vport_o1 = new ssnode("vector port")

  // define switch
  val sw1 = new ssnode("switch")
  val sw2 = new ssnode("switch")
  val sw3 = new ssnode("switch")
  val sw4 = new ssnode("switch")

  // define processing element that can do Add and Mul
  val pe = new ssnode("processing element")
  pe("instructions", Seq("Add", "Mul"))

  // define the CGRA fabric
  val my_cgra = new ssfabric
  my_cgra("default_data_width", 64)

  // define connection
  my_cgra(
    vport_i1 --> sw1)(
    vport_i2 --> sw2)(
    sw3 --> vport_o1)(
    sw1 <-> sw2)(
    sw1 <-> sw3)(
    sw2 <-> sw4)(
    sw3 <-> sw4)(
    sw1 --> pe)(
    sw2 --> pe)(
    sw3 --> pe)(
    sw4 <-> pe
  )

  // Add a new vector port
  val vport_i3 = new ssnode("vector port")

  // Add a new switch
  val new_sw = sw1.clone()

  // Add a new processing element
  val pe_div = new ssnode("processing element")
  pe_div("instructions", "Div")

  // Add connections to fabric
  my_cgra(vport_i3 --> new_sw)(
    sw1 --> pe_div)(
    new_sw --> pe_div)(
    pe_div --> sw3)

  // print IR
  my_cgra.printIR(filename = "my_cgra_div")
}
