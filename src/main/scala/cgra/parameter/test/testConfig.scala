package cgra.parameter.test

import cgra.parameter.{port_param, subnet_location_param}

object TestConfig extends App{

/*
  //var testConfig = Class.forName("cgra.config.mergeConfigs").newInstance.asInstanceOf[Config]
  var testConfig = Class
    .forName("cgra.config.merge_PeSwitch_Config")
    .newInstance.asInstanceOf[Config]

  var parameters:Parameters = testConfig.toInstance



  val test = TileKey.default
  val otherKey = No_1.default
  val key3default = No_3.default

  val t = 1

  var No1Params = parameters(No_1)

  var someParams = parameters(No_3)
  //var extraParam = parameters(BroadcastKey)
  //var busParam = parameters(ExtBus)

  val RouterParams = parameters(RouterKey)

  RouterParams.interconnect_type = "Bus"
*/

  /*
  val emptyParam:Parameters = Parameters.empty
  emptyParam.
*/

  /*
  val No1_PE_param = parameters(PeKey)
  val No1_Switch_param = parameters(RouterKey)
  val Mix_RouterPE_param = parameters(RouterKey).is


  val connect_1 = Connect(0,1423,456)
  val connect_2 = Connect(3,1,456)

  val array_Connect_Config:Array[Parameters] = Array(
    new Connect_Config(connect_1,0,2),
    new Connect_Config(connect_2,5,3))

  val connects_config = array_Connect_Config.reduce(_ ++ _)

  val test = connects_config(connect_1)
*/
  val test = new port_param("output",1,4)
  val zero_subnet_source = subnet_location_param(-1,-1)
  test.subnets_param(0).source_param =
    subnet_location_param(0,0)::
    subnet_location_param(1,2)::
    subnet_location_param(2,1)::
    subnet_location_param(3,1)::zero_subnet_source::Nil

  test.subnets_param(1).source_param =
    subnet_location_param(0,0)::
      subnet_location_param(0,2)::
     // subnet_location_param(9,2)::
      subnet_location_param(1,1)::
      subnet_location_param(2,1)::
      subnet_location_param(3,1)::zero_subnet_source::Nil

  test.subnets_param(2).source_param =
    subnet_location_param(0,2)::
      subnet_location_param(1,1)::
      subnet_location_param(1,2)::
      subnet_location_param(2,1)::
      subnet_location_param(3,1)::zero_subnet_source::Nil

  test.subnets_param(3).source_param =
    subnet_location_param(0,3)::
      subnet_location_param(1,2)::
      subnet_location_param(1,3)::
      subnet_location_param(2,1)::
      subnet_location_param(3,1)::zero_subnet_source::Nil

  //val tryTest = test.get_source_mode("Group by Port")




  println("Hello World")
}