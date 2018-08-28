// See README.md for license details.test.isInstanceOf[List[String]]
package dsl.compiler.evaluate

import dsl.IR._
import dsl.compiler._
import dsl.lex._

trait Evaluate extends Env
  with IRBuilder{
  def evaluateEnv(enviro:Env):CgraModel={
    var model = new CgraModel
    enviro.VariableList.foreach(vari=>{

      val currVari:EnvVariable= vari.asInstanceOf[EnvVariable]

      val varEntity = vari.Entity
      val varFields = varEntity.getClass.getDeclaredFields.toList

      varFields.foreach(varField=>{
        val fieldName = varField.getName
        val fieldType = varField.getType
        val entityField = varEntity.getClass.getDeclaredField(fieldName)
        entityField.setAccessible(true)
        val entityValue = entityField.get(varEntity)//.asInstanceOf[fieldType.type ]

        entityValue match {
       //   case enVal:Function => functionCall(enVal)
          case _ =>
        }
        val test2 = varField.getClass
        val foo = vari
      })

      vari.Type match {
        case "FU" => model = buildFUIRModule(currVari,model)
       // case "Router" => model = buildRouterIRModule(vari,model)
       // case "CGRA" => model = buildCGRAIRModule(vari,model)
        case _=>
      }

    })
    model
  }




}

