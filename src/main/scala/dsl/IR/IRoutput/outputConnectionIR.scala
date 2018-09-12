package dsl.IR.IRoutput

import dsl.IR.{CgraModel, ConnectIR, GridModule}

import scala.util.Properties

trait outputConnectionIR extends formatValue{
  def outputConnectionIR(model:CgraModel):String={
    var emptyString = "\"ConnectionIR\":{"
    model.ConnectModuleIR.zipWithIndex.foreach(cI=>{
      val c = cI._1
      emptyString = emptyString+Properties.lineSeparator+"\"Connection"+cI._2+"\":" + "{"
      val fields = (new ConnectIR).getClass.getDeclaredFields
      for(field <- fields){
        field.setAccessible(true)

        val fieldJSONformat:String = field.get(c) match {
          case x:GridModule => {
            "\""+x.name+"\""
          }
          case x:Array[_] => {
            Array2JSONString(x)
          }
          case x:Seq[_] => {
            Seq2JSONString(x)
          }
          case x:Tuple2[Int,Int]=> "[" + x._1+","+x._2+"]"
          case x:String=>"\""+x+"\""
          case x => x.toString
        }
          /*
        if(field.getName == "FIFOdepth" ||
          field.getName == "toModule" ||
          field.getName == "fromModule" ||
          field.getName == "")
          */
          emptyString = emptyString + Properties.lineSeparator +"\""+ field.getName +"\""+ ":"+ fieldJSONformat + ","
      }
      emptyString = emptyString.reverse.replaceFirst(",","").reverse
      emptyString = emptyString + "},"
    })
    emptyString = emptyString.reverse.replaceFirst(",","").reverse
    emptyString + "}"
  }
}
