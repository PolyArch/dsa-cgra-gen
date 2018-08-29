// See README.md for license details.

package dsl.library.builtinClass

import dsl.compiler.Env
import dsl.lex.{Collection, Item, Location}

class SwitchClass {
  var Input_Routing :List[Location] = List()
  var Output_Routing :List[Location] = List()
  var Routing:String = ""
}

class SwitchClassInitializer extends Env{
  def initializer(Properties:List[Any]): SwitchClass ={
    var newSwitch = new SwitchClass

    val SwitchfieldName:List[String] = newSwitch.getClass.getDeclaredFields.map(_.getName).toList
    val propertiesName:List[String] = Properties.asInstanceOf[List[Assign]].map(x=>x.AssignTarget.itemName)

    if (!Properties.forall(member=>{member.isInstanceOf[Assign]
      // inside the class, there should only contains assignment
    })){
      throw new Exception("operation besides Assignment is inside Class instantiation")
    }

    if((propertiesName diff SwitchfieldName) nonEmpty){
      throw new Exception("Switch Class do not have such field")
    }
    fieldInitializer(newSwitch,Properties)
  }

  private def fieldInitializer(newSwitch:SwitchClass,Properties:List[Any]): SwitchClass ={
    Properties.foreach(p=>{
      val memberDefined:Assign = p.asInstanceOf[Assign]
      val memberName = memberDefined.AssignTarget.itemName
      val memberContent = memberDefined.AssignFrom
      memberName match {
        case "Output_Routing" =>
          if (!memberContent.isInstanceOf[Collection]) {
            throw new Exception("Output_Routing need to be collection")
          }
          val outRs = memberContent.asInstanceOf[Collection].CollectionSet
          if(outRs.forall(oR=>oR.isInstanceOf[Location])){
            newSwitch.Output_Routing = outRs.map(oR=>oR.asInstanceOf[Location])
          }else{
            throw new Exception("Output_Routing need to be collection of location")
          }

        case "Input_Routing" =>
          if (!memberContent.isInstanceOf[Collection]) {
            throw new Exception("Output_Routing need to be collection")
          }
          val outRs = memberContent.asInstanceOf[Collection].CollectionSet
          if(outRs.forall(oR=>oR.isInstanceOf[Location])){
            newSwitch.Input_Routing = outRs.map(oR=>oR.asInstanceOf[Location])
          }else{
            throw new Exception("Output_Routing need to be collection of location")
          }

        case "Routing" =>
          if (!memberContent.isInstanceOf[Item]){
            throw new Exception("Mapping needs to be Item")
          }
          val mp = memberContent.asInstanceOf[Item].itemName
          newSwitch.Routing = mp
        case _ => throw new Exception("Switch does not contain such field")
      }
    })
    newSwitch
  }
}