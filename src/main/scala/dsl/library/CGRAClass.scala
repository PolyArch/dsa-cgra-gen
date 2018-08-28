
// See README.md for license details.

package dsl.library

import dsl.compiler.Env
import dsl.lex._

class CGRAClass {
  var Router : Item = _
  var Topology :Any = _
  var Inputs : Array[List[Item]] = _
  var Outputs : Array[List[Item]]= _
}

class CGRAClassInitializer extends Env{
  def initializer(Properties:List[Any]): CGRAClass ={
    var newCGRA = new CGRAClass

    val CGRAfieldName:List[String] = newCGRA.getClass.getDeclaredFields.map(_.getName).toList
    val propertiesName:List[String] = Properties.asInstanceOf[List[Assign]].map(x=>x.AssignTarget.itemName)

    if (!Properties.forall(member=>{member.isInstanceOf[Assign]
      // inside the class, there should only contains assignment
    })){
      throw new Exception("operation besides Assignment is inside Class instantiation")
    }

    if((propertiesName diff CGRAfieldName) nonEmpty){
      throw new Exception("CGRA Class do not have such field")
    }
    fieldInitializer(newCGRA,Properties)
  }

  private def fieldInitializer(newCGRA:CGRAClass,Properties:List[Any]): CGRAClass ={
    Properties.foreach(p=>{
      val memberDefined:Assign = p.asInstanceOf[Assign]
      val memberName = memberDefined.AssignTarget.itemName
      val memberContent = memberDefined.AssignFrom
      memberName match {
          
        case "Router" =>
          if (!memberContent.isInstanceOf[Item]) {
            throw new Exception("Router need to be Item")
          }
          val mC = memberContent.asInstanceOf[Item]
          if(mC.isInstanceOf[Item]){
            newCGRA.Router= mC
          }else{
            throw new Exception("Router need to be Item")
          }
          
        case "Topology" =>
          if (!memberContent.isInstanceOf[Function]){
            throw new Exception("Topology needs to be function")
          }
          val mC = memberContent.asInstanceOf[Function]
          newCGRA.Topology = mC

        case "Inputs" =>
          if (!memberContent.isInstanceOf[Collection]){
            throw new Exception("Inputs needs to be Collection")
          }
          val mC = memberContent.asInstanceOf[Collection]
          newCGRA.Inputs = new Array[List[Item]](mC.CollectionSet.length)
          for(i <- newCGRA.Inputs.indices){
            val imC = mC.CollectionSet(i)
            if(!imC.isInstanceOf[Collection]){
              throw new Exception("Inputs is a collection of collection")
            }
            newCGRA.Inputs(i) = imC.asInstanceOf[Collection]
              .CollectionSet
              .map(x=>x.asInstanceOf[Item])
          }

        case "Outputs" =>
          if (!memberContent.isInstanceOf[Collection]){
            throw new Exception("Outputs needs to be Collection")
          }
          val mC = memberContent.asInstanceOf[Collection]
          newCGRA.Outputs = new Array[List[Item]](mC.CollectionSet.length)
          for(i <- newCGRA.Outputs.indices){
            val imC = mC.CollectionSet(i)
            if(!imC.isInstanceOf[Collection]){
              throw new Exception("Outputs is a collection of collection")
            }
            newCGRA.Outputs(i) = imC.asInstanceOf[Collection]
              .CollectionSet
              .map(x=>x.asInstanceOf[Item])
          }
          
        case _ => throw new Exception("CGRA does not contain such field")
      }
    })
    newCGRA
  }
}