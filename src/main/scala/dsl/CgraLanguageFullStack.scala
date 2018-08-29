// See README.md for license details.

package dsl

import dsl.IR.CgraModel
import dsl.compiler.{CgraLanCompiler, _}
import dsl.generator.{CgraGenerator, _}
import dsl.parser.{CgraParser, _}

object CgraLanguageFullStack extends App
  with CgraGenerator{

      val test = new CgraLanguageFullStack

      chisel3.Driver.execute(args, () =>new CgraInstance(test.model))
}

class CgraLanguageFullStack extends Env
  with CgraGenerator
  with CgraLanCompiler
  with CgraParser
{

  val fileName : String = "template"
  val parsedCodes:List[Any] = cgraLanParse(fileName)
  val model:CgraModel = cgraCompile(parsedCodes)
  val foo = ""
}



/*
object CgraLanguageFullStack extends App{
  override def main (cgraLanFiles:Array[String]):Unit = {

    class CgraFullStack(fileName:String)
      extends Env
        with CgraGenerator
        with CgraLanCompiler
        with CgraParser
    {
      val parsedCodes:List[Any] = cgraLanParse(fileName)
      val model:CgraModel = cgraCompile(parsedCodes)
      chisel3.Driver.execute(args, () =>new CgraInstance(model))
    }

    cgraLanFiles.foreach(x => {
      new CgraFullStack(x)

    })
    println("Finished ! ")
  }

}
*/