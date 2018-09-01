// See README.md for license details.

package dsl.compiler

import dsl.lex._
import dsl.syx.ReALan

class Env extends ReALan{

  var VariableList : List[EnvVariable] = List()

  var ConnectionList : List[EnvConnection] = List()

  class EnvVariable {
    var Name:String = ""
    var Type:String = ""
    var Entity:Any = _
  }

  class EnvAssignment {
    val VarOperated = new EnvVariable
    val VarOperating:Any = null
    val OperationType :String = "="
  }

  class EnvConnection {
    var VarTo:Item = _
    var VarFrom:Item = _
    var ConnectionFeature :String = ""
  }

  import scala.reflect.runtime.{universe => ru}
  implicit class ForAnyInstance[T: ru.TypeTag](i: T)(implicit c: scala.reflect.ClassTag[T]) {

    /* a mirror sets a scope of the entities on which we have reflective access */
    val mirror = ru.runtimeMirror(getClass.getClassLoader)

    /* here we get an instance mirror to reflect on an instance */
    val im = ru.runtimeMirror(i.getClass.getClassLoader)

    def fieldInfo(name: String) = {
      ru.typeOf[T].members.filter(!_.isMethod).filter(_.name.decoded.trim.equals(name)).foreach(s => {
        val fieldValue = im.reflect(i).reflectField(s.asTerm).get

        /* typeSignature contains runtime type information about a Symbol */
        s.typeSignature match {
          case x if x =:= ru.typeOf[String] => /* do something */
          case x if x =:= ru.typeOf[Int] => /* do something */
          case x if x =:= ru.typeOf[Boolean] => /* do something */
          case x if x =:= ru.typeOf[List[String]] =>
        }
      })
      val foo = ""
    }
  }
  def manOf[T: Manifest](t: T): Manifest[T] = manifest[T]
}