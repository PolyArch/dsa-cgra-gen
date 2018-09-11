// See README.md for license details.

package dsl

import java.io._
import dsl.IR.IRoutput.irOutput
import dsl.IR.{CgraModel, GridFUIR, GridModule, GridRouterIR}
import dsl.compiler.{ReALanCompiler, _}
import dsl.generator.{CgraGenerator, _}
import dsl.parser.{CgraParser, _}

import scala.util.Properties


object ReALanguage extends App
  with CgraGenerator{

  val ReAL = new ReALanguage(args(0))

  val pw = new PrintWriter(new File("IRoutput/"+args(0)+".json"))
  pw.write(ReAL.toString)
  pw.close

  chisel3.Driver.execute(args, () =>new CgraInstance(ReAL.model))
}

class ReALanguage(fileName:String) extends Env
  with CgraGenerator
  with irOutput
  with ReALanCompiler
  with CgraParser
{
  val parsedCodes:List[Any] = ReALanParse(fileName)
  val model:CgraModel = cgraCompile(parsedCodes)
  override def toString= {
    "{"+"\"numRows\":"+model.numRows+","+Properties.lineSeparator+
    "\"numCols\":"+model.numCols+","+Properties.lineSeparator+
      outputGridIR(model)+Properties.lineSeparator+","+outputConnectionIR(model)+"}"
  }
}