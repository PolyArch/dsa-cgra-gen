// See README.md for license details.

package dsl.library

import dsl.lex._

class FUClass{
  var Opcodes:List[String] = List()
  var Output_Routing:List[Location] = List()
  var Mapping:String = ""// Shared(8) //8 instructions in instruction buffer
  var Firing = "" //TriggeredInstructions //(Triggered-instructions dataflow execution)
  var Size:List[Int] = List()
}

class FUClassInitializer{
  def fuInitializer(Properties:List[Any]): FUClass ={
    var newFU = new FUClass
    if (Properties.forall(member=>{
      val memberType = member.getClass.toString.split(Array('.','$'))
      memberType.contains("CgraLanAssignment")
      // inside the class, there should only contains assignment
    })){

    }else{
      throw new Exception("operation besides Assignment is inside Class instantiation")
    }
    newFU
  }
}