// See README.md for license details.

package dsl.library

import dsl.compiler.Env
import dsl.lex._

class FUClass{
  var Opcodes:List[String] = List()
  var Output_Routing:List[Location] = List()
  var Mapping:String = ""// Shared(8) //8 instructions in instruction buffer
  var Firing:String = "" //TriggeredInstructions //(Triggered-instructions dataflow execution)
  var Size:List[Int] = List()
}

class FUClassInitializer extends Env{
  def fuInitializer(Properties:List[Any]): FUClass ={
    var newFU = new FUClass

    val FUfieldName:List[String] = newFU.getClass.getDeclaredFields.map(_.getName).toList
    val propertiesName:List[String] = Properties.asInstanceOf[List[Assign]].map(x=>x.AssignTarget.itemName)

    if (!Properties.forall(member=>{member.isInstanceOf[Assign]
      // inside the class, there should only contains assignment
    })){
      throw new Exception("operation besides Assignment is inside Class instantiation")
    }

    if((propertiesName diff FUfieldName) nonEmpty){
      throw new Exception("FU Class do not have such field")
    }

    Properties.foreach(p=>{
      val memberDefined:Assign = p.asInstanceOf[Assign]
      val memberName = memberDefined.AssignTarget.itemName
      val memberContent = memberDefined.AssignFrom

      memberName match {
        case "Opcodes" =>
          if (!memberContent.isInstanceOf[Collection]) {
            throw new Exception("Opcodes need to be collection")
          }
          val ops = memberContent.asInstanceOf[Collection].CollectionSet
          if (ops.forall(o => o.isInstanceOf[Item])) {
            newFU.Opcodes = ops.map(x => x.asInstanceOf[Item].itemName)
          }
          else {
            throw new Exception("thing other than Item can not be assign to Opcodes")
          }
        case "Output_Routing" =>
          if (!memberContent.isInstanceOf[Collection]) {
            throw new Exception("Output_Routing need to be collection")
          }
          val outRs = memberContent.asInstanceOf[Collection].CollectionSet
          if(outRs.forall(oR=>oR.isInstanceOf[Location])){
            newFU.Output_Routing = outRs.map(oR=>oR.asInstanceOf[Location])
          }else{
            throw new Exception("Output_Routing need to be collection of location")
          }
        case "Mapping" =>
          if (!memberContent.isInstanceOf[Item]){
            throw new Exception("Mapping needs to be Item")
          }
          val mp = memberContent.asInstanceOf[Item].itemName
          newFU.Mapping = mp
        case "Firing" =>
          if (!memberContent.isInstanceOf[Item]){
            throw new Exception("Firing needs to be Item")
          }
          val fir = memberContent.asInstanceOf[Item].itemName
          newFU.Firing = fir
        case "Size" =>
          if (!memberContent.isInstanceOf[Location]){
            throw new Exception("Size needs to be Location style")
          }
          val si = memberContent.asInstanceOf[Location]
          newFU.Size = List(si.x,si.y)
        case _ => throw new Exception("FU does not contain such field")
      }
    })
    newFU
  }
}

/*

class FUClass{
  var Opcodes:List[String] = List()
  var Output_Routing:List[Int] = List()
  var Mapping:String = ""// Shared(8) //8 instructions in instruction buffer
  var Firing = "" //TriggeredInstructions //(Triggered-instructions dataflow execution)
  var Size:List[Int] = List()
}

 */