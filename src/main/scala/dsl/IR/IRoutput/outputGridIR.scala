// See README.md for license details.

package dsl.IR.IRoutput

import dsl.IR._

import scala.util.Properties

trait outputGridIR extends formatValue{
  def outputGridIR(model:CgraModel):String={

    var emptyString = "\"GridIR\":{"+ Properties.lineSeparator

    model.GridIR.flatten.filter(_!=null)foreach(md=>{
      emptyString += GridModule2Json(md,model) + "," + Properties.lineSeparator
    })

    emptyString = emptyString.reverse.replaceFirst(",","").reverse
    emptyString + "}"
  }

  def GridModule2Json (md:GridModule,model: CgraModel):String ={
    var emptyString = "\""+md.name + "\":{"+ Properties.lineSeparator

    var fields = md.getClass.getDeclaredFields

    md match {
      case x:GridRouterIR =>
        emptyString += "\"type\":\"Switch\"" +","+ Properties.lineSeparator
        fields = (new GridRouterIR).getClass.getDeclaredFields
      case x:GridFUIR =>
        emptyString += "\"type\":\"FU\"" +","+ Properties.lineSeparator
        fields = (new GridFUIR).getClass.getDeclaredFields
    }

    emptyString += "\"col\":"
    emptyString +=  md.col
    emptyString += ","+ Properties.lineSeparator

    emptyString += "\"row\":"
    emptyString +=  md.row
    emptyString += ","+ Properties.lineSeparator

    emptyString += "\"deComp\":"
    emptyString += "\"" + md.deComp + "\""
    emptyString += ","+ Properties.lineSeparator

    emptyString += "\"input\":"
    emptyString += locationList2Name("i",md.inputLocation,md,model)
    emptyString += ","+ Properties.lineSeparator

    emptyString += "\"output\":"
    emptyString += locationList2Name("o",md.outputLocation,md,model)
    emptyString += ","+ Properties.lineSeparator

    md match {
      case x:GridFUIR =>
        if(x.Firing=="Shared"){
          require(x.Iteration > 1,"Shared region need to have more than one instructions")
        }
      case _ =>
    }

    for (field <- fields){
      field.setAccessible(true)

      field.get(md) match {
        case x: Array[_] =>
          if(field.getName == "Instructions"){
            emptyString += ("\""+field.getName + "\":" + OutputSubNetOperand2JSON(x))
            emptyString += "," + Properties.lineSeparator
          }
        case x:String =>
          emptyString += "\""+field.getName + "\":" + "\"" + x + "\""
          emptyString += "," + Properties.lineSeparator
        case x =>
          emptyString += "\""+field.getName + "\":"  + x.toString
          emptyString += "," + Properties.lineSeparator
      }
    }
    emptyString = emptyString.reverse.replaceFirst(",","").reverse
    emptyString + "}"
  }

  def OutputSubNetOperand2JSON(value:  Array[_]):String={

    def buildNamedStructure(upperString:String,stage:Int,curr: Array[_]):String={

      var emptyString = upperString

      for(x <- 0 until stage){
        emptyString += "\t"
      }

      curr match {
        case x:Array[Boolean]=>
          emptyString += Array2JSONString(x)

        case x:Array[Int]=>
          emptyString += Array2JSONString(x)

        case x:Array[Array[_]] =>
          val stageName = stage match {
            case 0 => "\"outPut_"
            case 1 => "\"subNet_"
            case 2 => "\"operand_"
          }

          for(i <- 0 until x.length){
            for(x <- 0 until stage){
              emptyString += "\t"
            }
            emptyString += stageName + i + "\":"+ Properties.lineSeparator
            if(x(i).isInstanceOf[Array[Array[_]]])
              emptyString += "{"
            emptyString = buildNamedStructure(emptyString,stage+1,x(i))
            if(x(i).isInstanceOf[Array[Array[_]]])
              emptyString += "}"
            emptyString += "," + Properties.lineSeparator
          }
          emptyString = emptyString.reverse.replaceFirst(",","").reverse
          emptyString + "}"

        case _ =>
      }

      emptyString


    }

    var emptyString = "{"
    emptyString = buildNamedStructure(emptyString,0,value)
    emptyString + "}"
  }

  def locationList2Name(io:String,tuples: List[(Int, Int)], md:GridModule,model: CgraModel):String ={
    def extraLink(io:String,Port: Int, module: GridModule, model: CgraModel):String ={
      var targetName = ""
      var targetConnection:ConnectIR = null

      io match {
        case "o" =>{
          val tempC = model.ConnectModuleIR.filter(c=>{c.fromModule==md&&c.fromPort==Port})
          /*
          if(tempC.length > 1){
            throw new Exception("One port have multiple connection")
          }
          */
          //TODO:one output can have multiple, but be attention
          //Todo:in "extralink" means extra connection like bypass or connection to interface
          //todo: we can use tempC.head it is because we think the "BYPASS" is always in front of "Internal Connection"
          if(tempC.nonEmpty){
            targetConnection = tempC.head
            targetName = targetConnection.toModule.name
          }else{
            val targetConnections = model.InterfacePorts.filter(c=>{c.InOrOut=="OutputPorts"}).zipWithIndex
            for(tCI <- targetConnections.indices){
              if(targetConnections(tCI)._1.connectIR.exists(cc=>{cc.fromModule == md && cc.fromPort==Port})){
                targetName = "OutputPorts_" + targetConnections(tCI)._2
              }
            }
          }
        }
        case "i" =>{

          val tempC = model.ConnectModuleIR.filter(c=>{c.toModule==md&&c.toPort==Port})
          if(tempC.length > 1){
            throw new Exception("One port have multiple connection")
          }

          if(tempC.nonEmpty){
            targetConnection = tempC.head
            targetName = targetConnection.fromModule.name
          }else{
            val targetConnections = model.InterfacePorts.filter(c=>{c.InOrOut=="InputPorts"}).zipWithIndex
            for(tCI <- targetConnections.indices){
              if(targetConnections(tCI)._1.connectIR.exists(cc=>{cc.toModule == md && cc.toPort==Port})){
                targetName = "InputPorts_" + targetConnections(tCI)._2
              }
            }
          }
        }
        case _ => throw new Exception("unknown io type")
      }

      targetName
    }
    var emptyString = "["
    tuples.zipWithIndex.foreach(tpI=>{
      val tp = tpI._1
      if(tp._1>=model.numRows&&tp._2>=model.numCols){
        var port = tpI._2
        if(md.isInstanceOf[GridModule]&&io=="o"){
          port = 0
        }
        emptyString += "\"" + (extraLink(io,port,md,model) + "\",")
      }else{
        emptyString += "\"" + model.GridIR(md.row+tp._1)(md.col+tp._2).name + "\","
      }
    })

    emptyString = emptyString.reverse.replaceFirst(",","").reverse
    emptyString + "]"
  }

}
