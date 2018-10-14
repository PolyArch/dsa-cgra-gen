// See README.md for license details.

package dsl.generator

import dsl.IR._
import cgra._
import chisel3._
import chisel3.util._
import tile._

trait CgraGenerator {

  class CgraInstance(model:CgraModel) extends Module
    with HasFabricParams {

    val io = IO(new Bundle{
      val input_ports = Vec(model.InterfacePorts
        .count(ip=>{ip.InOrOut=="InputPorts"}),Flipped(DecoupledIO(UInt(fabricDataWidth.W))))

      val output_ports = Vec(model.InterfacePorts
        .count(ip=>{ip.InOrOut=="OutputPorts"}),DecoupledIO(UInt(fabricDataWidth.W)))

      val interfaceChannel_Sel = Input(Vec(model.InterfacePorts.length,UInt({
        model.InterfacePorts.map(x=>log2Ceil(x.numSecIOPort)).max
      }.W)))
      val cfg_mode = Input(Bool())
    })

    var FabricGrid: Array[Array[FabricModule]] = _
    var ConnectionList: List[ModuleChannel] = List()
    var InterfacePortList: List[InterfacePort] = List()

    // Grid Building
    FabricGrid = new Array[Array[FabricModule]](model.numRows)
    for(row <- model.GridIR.indices){
      FabricGrid(row) = new Array[FabricModule](model.numCols)
      for(col <- model.GridIR(row).indices){
        FabricGrid(row)(col) = model.GridIR(row)(col) match {
          case x:GridRouterIR =>
            Module(new Switch(x.row,x.col,
              x.numInput,
              x.numOutput,x.inputLocation.toArray,
              x.outputLocation.toArray,
              x.deComp,x.muxDirMatrix,
              0,1))
          case x:GridFUIR =>
            Module(new FU(x.row,x.col,
              x.numInput,
              x.numOutput,
              x.inputLocation.toArray,
              x.outputLocation.toArray,
              x.deComp, x.Instructions,
              x.maxDelayPipeLen,
              x.muxDirMatrix,
              0,1))
          case _ => null
        }
        FabricGrid(row)(col) match {
          case x:FabricModule => FabricGrid(row)(col).io.cfg_mode := io.cfg_mode
          case _=>
        }

      }
    }

    // Internal Connection
    model.ConnectModuleIR.foreach(connect=>{
      val currConnectionModule = Module(new ModuleChannel(connect.deCompInput,
        connect.deCompOutput,
        connect.FIFOdepth))
      ConnectionList = ConnectionList :+ currConnectionModule
      val fromRow = connect.fromModule.row
      val fromCol = connect.fromModule.col
      val toRow = connect.toModule.row
      val toCol = connect.toModule.col
      val fromPort = connect.fromPort
      val toPort = connect.toPort
      val fromDecomp = connect.deCompInput
      val toDecomp = connect.deCompOutput
      //(numModuleInput * subNet + inPort)
      for(subNet <- 0 until fromDecomp){
        val fromPorts =  FabricGrid(fromRow)(fromCol) match {
          case x:Switch => x.io.output_ports(x.numModuleOutput * subNet + fromPort)
          case x:FU =>x.io.output_ports(x.numModuleOutput * subNet + fromPort)
          case _=> throw new Exception("Grid have unknown module")
        }
        currConnectionModule.io.input_ports(subNet) <> fromPorts
      }
      for(subNet <- 0 until toDecomp){
        val toPorts =  FabricGrid(toRow)(toCol) match {
          case x:Switch => x.io.input_ports(x.numModuleInput * subNet + toPort)
          case x:FU =>x.io.input_ports(x.numModuleInput * subNet + toPort)
          case _=> throw new Exception("Grid have unknown module")
        }
        toPorts <> currConnectionModule.io.output_ports(subNet)
      }
    })

    // Interface Port
    model.InterfacePorts.foreach(ifP=>{
      var currInterface = Module(new InterfacePort(
        IOType = ifP.InOrOut,
        numSec = ifP.numSecIOPort,
        secDecomp = ifP.secDecompes,
        secFIFO = ifP.secFIFOes
      ))
      InterfacePortList = InterfacePortList :+ currInterface
      ifP.InOrOut match {
        case "InputPorts" =>
          ifP.connectIR.zipWithIndex.foreach(connI=>{
            val conn = connI._1
            val index = connI._2
            var currConn = Module( new ModuleChannel(
              deCompInput = conn.deCompInput,
              deCompOutput = conn.deCompOutput,
              FIFOdepth = conn.FIFOdepth
            ))
            ConnectionList = ConnectionList :+ currConn
            val decompDataWidth = fabricDataWidth/conn.deCompInput
            for(fromIFPdecomp <- 0 until conn.deCompInput){
              currConn.io.input_ports(fromIFPdecomp).bits := currInterface.io.output_ports(index)
                .bits((1+fromIFPdecomp)*decompDataWidth - 1,fromIFPdecomp*decompDataWidth)
              currConn.io.input_ports(fromIFPdecomp).valid := currInterface.io.output_ports(index).valid
            }
            currInterface.io.output_ports(index).ready := currConn.io.input_ports.map(_.ready).reduceLeft(_&&_)
            val toModuleDecomp = conn.deCompOutput
            val toModule = conn.toModule
            for(subNet <- 0 until toModuleDecomp){
              FabricGrid(toModule.row)(toModule.col).io.input_ports(toModule.numInput * subNet + conn.toPort) <>
                currConn.io.output_ports(subNet)
            }
          })
        case "OutputPorts" =>
          ifP.connectIR.zipWithIndex.foreach(connI=>{
            val conn = connI._1
            val index = connI._2
            var currConn = Module( new ModuleChannel(
              deCompInput = conn.deCompInput,
              deCompOutput = conn.deCompOutput,
              FIFOdepth = conn.FIFOdepth
            ))
            ConnectionList = ConnectionList :+ currConn
            val fromModuleDecomp = conn.deCompInput
            val fromModule = conn.fromModule
            for(subNet <- 0 until fromModuleDecomp){
              FabricGrid(fromModule.row)(fromModule.col).io
                .output_ports(fromModule.numOutput * subNet + conn.fromPort) <> currConn.io.input_ports(subNet)
            }
            val decompDataWidth = fabricDataWidth/conn.deCompOutput
              currInterface.io.input_ports(index).bits := currConn.io.output_ports.map(_.bits).reduceLeft(Cat(_,_))
              currInterface.io.input_ports(index).valid := currConn.io.output_ports.map(_.valid).reduceLeft(_&&_)
            currConn.io.output_ports.foreach(oP=>{
              oP.ready := currInterface.io.input_ports(index).ready
            })
          })
      }
    })
    var in = 0
    var out= 0
    for(infp <- model.InterfacePorts.indices){
      if(model.InterfacePorts(infp).InOrOut=="InputPorts"){
        InterfacePortList(infp).io.input_ports.head <> io.input_ports(in)
        in += 1
      }
      if(model.InterfacePorts(infp).InOrOut=="OutputPorts"){
        io.output_ports(out) <> InterfacePortList(infp).io.output_ports.head
        out += 1
      }
      InterfacePortList(infp).io.sel_wire := io.interfaceChannel_Sel(infp)
    }

  }
}



