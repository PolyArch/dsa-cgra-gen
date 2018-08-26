package dsl.prePar

import java.io.File

import scala.util.Properties

trait fileClean{
  def fileRead(fileInfo:String): String = {

    var fileName:String = new String(fileInfo.getBytes(),"UTF-8")
    println(fileName)

    if(!fileInfo.endsWith(".cgral")){
      fileName  = fileName + ".cgral"
    }
    println(fileName)

    try{
      // relative path
      scala.io.Source.fromFile("model/" + fileName,"UTF-8") mkString
    }catch{
      // absolute path
      case _:Throwable => try{
        val ProjectAbsPath = new File(".").getAbsolutePath().reverse.substring(1).reverse
        val modelDirPath : String = ProjectAbsPath + "model\\"
        println(modelDirPath + fileName)
        scala.io.Source.fromFile(modelDirPath + fileName,"UTF-8") mkString
      }catch{
        case x :Throwable => {
          println(x)
          throw new Exception(fileName + " : No such file or directory")}
      }
    }

  }

  def commentDelete(undeleted:String) : String ={
    def paraCommentDelete (paraUnDelete: String): String ={
      val sta:Int = paraUnDelete.indexOf("/*")
      val end:Int = paraUnDelete.indexOf("*/") + 2
      val length :Int=paraUnDelete.length
      if((end<sta)|(sta<0)|(end<0))
        paraUnDelete
      else
        paraCommentDelete(paraUnDelete.substring(0,sta)+
          paraUnDelete.substring(sta,end).replaceAll(".+","")
          +paraUnDelete.substring(end,length))
    }
    def lineCommentDelete (lineUnDelete:String) : String ={
      val sta:Int = lineUnDelete.indexOf("//")
      val end:Int = lineUnDelete.indexOf(Properties.lineSeparator,sta)
      val length : Int = lineUnDelete.length
      if((end<sta)|(sta<0)|(end<0))
        lineUnDelete
      else
        lineCommentDelete(lineUnDelete.substring(0,sta)+lineUnDelete.substring(end,length))
    }

    lineCommentDelete(paraCommentDelete(undeleted))
  }

  def deleteLastSep(undeleted:String) : String =
    undeleted.reverse.replaceFirst(";","").reverse
}