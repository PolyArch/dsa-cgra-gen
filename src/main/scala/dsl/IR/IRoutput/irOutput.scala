package dsl.IR.IRoutput

import dsl.IR._

import scala.util.Properties

trait irOutput {

  implicit def Seq2JSONString (Ses:Seq[_]):String={
    var tar = "["
    for(se <- Ses){
      se match {
        case se:Seq[_] => tar = tar + Seq2JSONString(se) + ","
        case x:Tuple2[Int,Int] => tar = tar + "["+x._1+","+x._2+"]" +","
      }
    }
    tar = tar.reverse.replaceFirst(",","").reverse
    tar = tar + "]"
    tar
  }
  implicit def Array2JSONString (Ses:Array[_]):String={
    var tar = "["
    for(se <- Ses){
      se match {
        case se:Array[_] => tar = tar + Array2JSONString(se) + ","
        case _ => tar = tar + se.toString +","
      }
    }
    tar = tar.reverse.replaceFirst(",","").reverse
    tar = tar + "]"
    tar
  }
  implicit def Module2JSON (md:GridModule):String ={
    var emptyString = ""
    emptyString = emptyString +"\""+ md.name +"\""+ ":{"

    val basicFields = (new GridModule).getClass.getDeclaredFields
    for(basicField <- basicFields){
      basicField.setAccessible(true)

      val fieldJSONformat:String = basicField.get(md) match {
        case x:GridModule => {
          "{"+Module2JSON(x)+"}"
        }
        case x:Array[_] => {
          Array2JSONString(x)
        }
        case x:Seq[_] => {
          Seq2JSONString(x)
        }
        case x:String => "\""+x+"\""
        case x=>x.toString
      }
      emptyString = emptyString + Properties.lineSeparator +"\""+ basicField.getName +"\""+ ":"+ fieldJSONformat + ","
    }

    var fields = md.getClass.getDeclaredFields

    md match {
      case x:GridFUIR => {
        fields = (new GridFUIR).getClass.getDeclaredFields
      }
      case x:GridRouterIR => {
        fields = (new GridRouterIR).getClass.getDeclaredFields
      }
      case _ => throw new Exception("GridIR contains different modules")
    }


    for(field <- fields){
      field.setAccessible(true)

      val fieldJSONformat:String = field.get(md) match {
        case x:GridModule => {
          "{"+Module2JSON(x)+"}"
        }
        case x:Array[_] => {
          Array2JSONString(x)
        }
        case x:Seq[_] => {
          Seq2JSONString(x)
        }
        case x:String => "\""+x+"\""
        case x=>x.toString
      }
      emptyString = emptyString + Properties.lineSeparator +"\""+ field.getName +"\""+ ":"+ fieldJSONformat + ","
    }
    emptyString = emptyString.reverse.replaceFirst(",","").reverse
    emptyString = emptyString + "}"+Properties.lineSeparator
    emptyString
  }

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
            "{"+Module2JSON(x)+"}"
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

        emptyString = emptyString + Properties.lineSeparator +"\""+ field.getName +"\""+ ":"+ fieldJSONformat + ","
      }
      emptyString = emptyString.reverse.replaceFirst(",","").reverse
      emptyString = emptyString + "},"
    })
    emptyString = emptyString.reverse.replaceFirst(",","").reverse
    emptyString + "}"
  }


  def outputGridIR(model:CgraModel):String={

    var emptyString = "\"GridIR\":{"
    model.GridIR.foreach(x => x.foreach(md=>{

      if(md != null){
        emptyString = emptyString + Module2JSON(md) +","
      }

    })
    )
    emptyString = emptyString.reverse.replaceFirst(",","").reverse
    emptyString + "}"
  }

}
