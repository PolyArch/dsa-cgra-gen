// See README.md for license details.

package dsl.IR.build

import dsl.IR._
import dsl.compiler.Env
import dsl.lex.Item
import dsl.library.builtinClass._

trait CgraIRBuild extends Env
  with RouterIRBuild{
  def buildCGRAIR(vari:EnvVariable,model:CgraModel,enviro:Env):CgraModel={

    val CgraProperties = vari.Entity.asInstanceOf[CGRAClass]
    val CgraTopology = CgraProperties.Topology.asInstanceOf[Array[Array[String]]]
    model.numRows = CgraTopology.length
    model.numCols = CgraTopology.head.length

    model.GridIR = new Array[Array[GridModule]](model.numRows)
    for(row <- model.GridIR.indices){
      model.GridIR(row) = new Array[GridModule](model.numCols)
      for(col <- model.GridIR(row).indices){
        val thisLocationModuleName:String = CgraTopology(row)(col)
        if(thisLocationModuleName!=""){
          val toBePlacedInThisLocation:List[GridModule] = model.GridModuleIR.filter(gM=>gM.name == thisLocationModuleName)
          if (toBePlacedInThisLocation.length > 1){
            throw new Exception("multiple modules to be placed in same place")
          }
          if(toBePlacedInThisLocation isEmpty){
            throw new Exception("Topology describe an nonexisted module : " + thisLocationModuleName)
          }
          toBePlacedInThisLocation.head match {
            case x:GridRouterIR => model.GridIR(row)(col) = x.copy(x)
            case x:GridFUIR => model.GridIR(row)(col) = x.copy(x)
            case _ => throw new Exception("assign a unknown type module : " + thisLocationModuleName)
          }
        }
      }
    }
    addImplicitRouter(vari,model,enviro)
  }



  def addImplicitRouter (vari:EnvVariable,model:CgraModel,enviro:Env):CgraModel ={
    val CgraProperties = vari.Entity.asInstanceOf[CGRAClass]
    val implicitRouter = model.GridModuleIR.filter(gM=>gM.name == CgraProperties.Router.itemName)

    if(implicitRouter isEmpty){
      throw new Exception("default router is not defined")
    }

    for(row<-0 until model.numRows;col<-0 until model.numCols){
      val neighBorLocation = for {
        offsetRow <- -1 to 1
        offsetCol <- -1 to 1
        if((row + offsetRow + 1) > 0 &&(row+offsetRow+ 1)<=model.numRows)&&
          ((col + offsetCol + 1) > 0 &&(col+offsetCol+ 1)<=model.numCols)&&
          !(offsetRow==0&&offsetCol==0)
      }yield (row + offsetRow,col + offsetCol)

      if(neighBorLocation.exists(nB=>{
        model.GridIR(nB._1)(nB._2).isInstanceOf[GridFUIR] &&
          model.GridIR(row)(col) == null &&
          model.GridIR(nB._1)(nB._2).inputLocation.exists(fromNeighbor=>{
            (fromNeighbor._1 + nB._1 == row)&&(fromNeighbor._2 + nB._2 == col)
          })
      })){
        model.GridIR(row)(col) = implicitRouter.head.asInstanceOf[GridRouterIR]
          .copy(implicitRouter.head.asInstanceOf[GridRouterIR])
      }
    }
    compressRouterUnusedIO(vari,model,enviro)
  }

  def compressRouterUnusedIO (vari:EnvVariable,model:CgraModel,enviro:Env):CgraModel ={
    val RouterLocationSet = for{
      row <- 0 until model.numRows
      col <- 0 until model.numCols
      if model.GridIR(row)(col).isInstanceOf[GridRouterIR]
    }yield (row,col)
    RouterLocationSet.foreach(routerLoc=>{
      val row = routerLoc._1
      val col = routerLoc._2
      for (offset <- model.GridIR(row)(col).outputLocation){
        val offsetRow = offset._1
        val offsetCol = offset._2
        if(((row + offsetRow + 1) > 0 &&(row + offsetRow + 1)<=model.numRows)&&
          ((col + offsetCol + 1) > 0 &&(col + offsetCol + 1)<=model.numCols)){

          if(!model.GridIR(row + offsetRow)(col + offsetCol).isInstanceOf[GridModule]){

            // Connect to some where which is not a module
            if(model.GridIR(row)(col).outputLocation.contains((offsetRow,offsetCol))){
              model.GridIR(row)(col).outputLocation =
                model.GridIR(row)(col).outputLocation diff List((offsetRow,offsetCol))
              model.GridIR(row)(col).numOutput -= 1
            }
          }else{

            // Neighbor do not connect back
            if(!model.GridIR(row + offsetRow)(col + offsetCol).outputLocation.exists(fromNeighbor=>{
              (fromNeighbor._1 + offsetRow==0)&&(fromNeighbor._2 + offsetCol==0)
            })){
              if(model.GridIR(row)(col).inputLocation.contains((offsetRow,offsetCol))){
                model.GridIR(row)(col).inputLocation =
                  model.GridIR(row)(col).inputLocation diff List((offsetRow,offsetCol))
                model.GridIR(row)(col).numInput -= 1
              }
            }

            // target module does not have Corresponding input
            if(!model.GridIR(row + offsetRow)(col + offsetCol).inputLocation.exists(fromNeighbor=>{
              (fromNeighbor._1 + offsetRow==0)&&(fromNeighbor._2 + offsetCol==0)
            })){
              if(model.GridIR(row)(col).outputLocation.contains((offsetRow,offsetCol))){
                model.GridIR(row)(col).outputLocation =
                  model.GridIR(row)(col).outputLocation diff List((offsetRow,offsetCol))
                model.GridIR(row)(col).numOutput -= 1
              }
            }

          }

        }else{
          // Not a valid array , Input in edge is only defined by Interface port

          if(model.GridIR(row)(col).outputLocation.contains((offsetRow,offsetCol))){
            model.GridIR(row)(col).outputLocation =
              model.GridIR(row)(col).outputLocation diff List((offsetRow,offsetCol))
            model.GridIR(row)(col).numOutput -= 1
          }

          if(model.GridIR(row)(col).inputLocation.contains((offsetRow,offsetCol))){
            model.GridIR(row)(col).inputLocation =
              model.GridIR(row)(col).inputLocation diff List((offsetRow,offsetCol))
            model.GridIR(row)(col).numInput -= 1
          }

        }
      }
      model.GridIR(row)(col).row = row
      model.GridIR(row)(col).col = col
    })

    updateRouterDecomp(vari,model,enviro)
  }

  def updateRouterDecomp(vari:EnvVariable,model:CgraModel,enviro:Env):CgraModel ={

    val RouterLocationSet = for{
      row <- 0 until model.numRows
      col <- 0 until model.numCols
      if model.GridIR(row)(col).isInstanceOf[GridRouterIR]
    }yield (row,col)

    RouterLocationSet.foreach(routerLocation=>{
      val row = routerLocation._1
      val col = routerLocation._2
      model.GridIR(row)(col).outputLocation.foreach(offset=>{
        val offsetRow = offset._1
        val offsetCol = offset._2
        model.GridIR(row)(col).deComp =
          model.GridIR(row)(col).deComp max model.GridIR(row+offsetRow)(col+offsetCol).deComp
      })

    })
    updateModuleLocation(vari,model,enviro)
  }

  def updateModuleLocation(vari:EnvVariable,model:CgraModel,enviro:Env):CgraModel={

    for(row <- 0 until model.numRows;col <- 0 until model.numCols){
      if(model.GridIR(row)(col) != null){
        model.GridIR(row)(col).row = row
        model.GridIR(row)(col).col = col
        model.GridIR(row)(col).existed = true
      }
    }
    createBypassCgraConnection(vari,model,enviro)
  }


  def createBypassCgraConnection (vari:EnvVariable,model:CgraModel,enviro:Env):CgraModel={
    enviro.ConnectionList.foreach(envCon=>{

      val foo = model.GridIR.flatten


      val fromModules = model.GridIR.flatten.filter(gM=>{

        gM!=null&&gM.name==envCon.VarFrom.itemName
      })

      val toModules = model.GridIR.flatten.filter(gM=>{
        gM!=null&&gM.name==envCon.VarTo.itemName
      })

      if (fromModules.length>1){
        throw new Exception("connect from multiple modules with same name")
      } else if (fromModules.isEmpty) {
        throw new Exception("connect from undefined module")
      }
      if (toModules.length>1){
        throw new Exception("connect to multiple modules with same name")
      }else if (toModules.isEmpty) {
        throw new Exception("connect from undefined module")
      }
      if(!fromModules.head.isInstanceOf[GridFUIR])
        fromModules.head.numOutput += 1
      toModules.head.numInput += 1

      fromModules.head.outputLocation = fromModules.head.outputLocation union List((model.numRows,model.numCols))
      toModules.head.inputLocation = toModules.head.inputLocation union List((model.numRows,model.numCols))

      model.ConnectModuleIR = model.ConnectModuleIR :+
        new ConnectIR{
          fromModule = fromModules.head
          toModule = toModules.head
          connectFeatureList = envCon.ConnectionFeature
          fromLocation = (fromModules.head.row,fromModules.head.col)
          toLocation = (toModules.head.row,toModules.head.col)
          fromPort = fromModules.head.numOutput - 1
          toPort = toModules.head.numInput - 1
          deCompInput = fromModules.head.deComp
          deCompOutput = toModules.head.deComp
          //TODO:specify FIFO depth for each fifo channel
          FIFOdepth = Array.fill[Int](deCompInput max deCompOutput)(4)
        }
    })
    buildInternalConnection(vari,model,enviro)
  }

  def buildInternalConnection(vari:EnvVariable,model:CgraModel,enviro:Env):CgraModel={
    for(row <- 0 until model.numRows;col <- 0 until model.numCols){
      if(model.GridIR(row)(col) != null){
        val iFromModule = model.GridIR(row)(col)
        for(outPort <- 0 until iFromModule.numOutput){
          val offsetRow = iFromModule.outputLocation(outPort)._1
          val offsetCol = iFromModule.outputLocation(outPort)._2

          if(row + offsetRow >= model.numRows || col + offsetCol >= model.numCols){
            // it is a bypass
          }else{
            val iTOModule = model.GridIR(row + offsetRow)(col + offsetCol)

            val iToPort = iTOModule.inputLocation.zipWithIndex.find(inP=>{
              val connectBack = inP._1
              (connectBack._1 + offsetRow == 0) && (connectBack._2 + offsetCol == 0)
            }).map(_._2)

            if (iToPort isEmpty){
              throw new Exception("target do not have corresponding input")
            }

            val toRow = row + offsetRow
            val toCol = col + offsetCol
            val decompInput = iFromModule.deComp
            val decompOutput = iTOModule.deComp
            //TODO:specify FIFO depth for each fifo channel
            val FIFODepth = Array.fill[Int](decompInput max decompOutput)(4)

            model.ConnectModuleIR = model.ConnectModuleIR :+
              new ConnectIR{
                fromModule = iFromModule
                toModule = iTOModule
                connectFeatureList = {
                  if(decompInput == 1 && decompOutput == 1){
                    ""
                  }else{
                    "d"
                  }
                }
                fromLocation = (row,col)
                toLocation = (toRow,toCol)
                fromPort = outPort
                toPort = showOption(iToPort).asInstanceOf[Int]
                deCompInput = decompInput
                deCompOutput = decompOutput
                FIFOdepth = FIFODepth
              }
          }
        }
      }
    }
    buildInterFacePortIR(vari,model,enviro)
  }

  def buildInterFacePortIR(vari:EnvVariable,model:CgraModel,enviro:Env):CgraModel={

    val CgraProperties = vari.Entity.asInstanceOf[CGRAClass]
    for(inP <- CgraProperties.Inputs.indices){
      val numSec = CgraProperties.Inputs(inP).length
      val IOName = "InputPorts"
      val pNames:List[String] = CgraProperties.Inputs(inP) match {
        case x:List[Item] => x.zipWithIndex.map("In" + _._2)
        /*TODO: Specify interface port with connection
      case x:List[Connection] => x.map(_.fromPort.head.itemName)
        */
        case _ => throw new Exception("Interface Port can only defined by Item or Connection")
      }
      val gModules:List[GridModule] = CgraProperties.Inputs(inP) match {
        case x:List[Item] => model.GridIR.flatten.filter(gM=>{
          gM!=null&&x.map(_.itemName).contains(gM.name)
        }).toList
        /* TODO: Specify interface port with connection
      case x:List[Connection] => model.GridIR.flatten.filter(gM=>{
        x.map(_.toPort.head.itemName).contains(gM.name)
      }).toList
      */
      }

      model.InterfacePorts = model.InterfacePorts :+
        new InterfacePortIR{
          InOrOut = IOName
          numSecIOPort = numSec
          portNames = pNames
          gridModules = gModules
          secFIFOes = List.fill[Int](numSec)(4)
          secDecompes = gridModules.map(_.deComp)
          // TODO : specify each FIFO length in future
        }
    }

    for(outP <- CgraProperties.Outputs.indices){
      val numSec = CgraProperties.Outputs(outP).length
      val IOName = "OutputPorts"
      val pNames:List[String] = CgraProperties.Outputs(outP) match {
        case x:List[Item] => x.zipWithIndex.map("Out" + _._2)
        /*TODO: Specify interface port with connection
      case x:List[Connection] => x.map(_.fromPort.head.itemName)
        */
        case _ => throw new Exception("Interface Port can only defined by Item or Connection")
      }
      val gModules:List[GridModule] = CgraProperties.Outputs(outP) match {
        case x:List[Item] => model.GridIR.flatten.filter(gM=>{
          gM!=null&&x.map(_.itemName).contains(gM.name)
        }).toList
        /* TODO: Specify interface port with connection
      case x:List[Connection] => model.GridIR.flatten.filter(gM=>{
        x.map(_.toPort.head.itemName).contains(gM.name)
      }).toList
        */
      }

      model.InterfacePorts = model.InterfacePorts :+
        new InterfacePortIR{
          InOrOut = IOName
          numSecIOPort = numSec
          portNames = pNames
          gridModules = gModules
          secFIFOes = List.fill[Int](numSec)(4)
          secDecompes = gridModules.map(_.deComp)
          // TODO : specify each FIFO length in future
        }
    }
    buildConnectionToInterface(vari,model,enviro)
  }

  def buildConnectionToInterface (vari:EnvVariable,model:CgraModel,enviro:Env):CgraModel={
    model.InterfacePorts.foreach(ifP=>{
      ifP.InOrOut match {
        case "InputPorts" =>
          for(x <- ifP.gridModules.indices){
            ifP.gridModules(x).inputLocation = ifP.gridModules(x).inputLocation :+ (model.numRows,model.numCols)
            ifP.gridModules(x).numInput += 1
            val tPort = ifP.gridModules(x).numInput - 1
            ifP.connectIR = ifP.connectIR :+
              new ConnectIR{
                toModule = ifP.gridModules(x)
                toPort = tPort
                deCompInput = ifP.secDecompes(x)
                deCompOutput = toModule.deComp
                //TODO: Interface FIFO depth can be changed
                FIFOdepth = Array.fill[Int](deCompOutput max deCompInput)(2)
              }
          }
        case "OutputPorts" =>
          for(x <- ifP.gridModules.indices){
            ifP.gridModules(x).outputLocation = ifP.gridModules(x).outputLocation :+ (model.numRows,model.numCols)
            ifP.gridModules(x).numOutput += 1
            val fPort = ifP.gridModules(x).numOutput - 1
            ifP.connectIR = ifP.connectIR :+
              new ConnectIR{
                fromModule = ifP.gridModules(x)
                fromPort = fPort
                deCompInput = fromModule.deComp
                deCompOutput = ifP.secDecompes(x)
                //TODO: Interface FIFO depth can be changed
                FIFOdepth = Array.fill[Int](deCompOutput max deCompInput)(2)
              }
          }
      }
    })
    buildRouterMuxDirMatrix(vari,model,enviro)
  }


}
