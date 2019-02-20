// See README.md for license details.

package cgra

import chisel3._
import chisel3.util._
import tile._

class InterfacePort(IOType:String,
                    numSec:Int,
                    secDecomp :List[Int],
                    secFIFO : List[Int]
                   )  extends Module
  with HasFabricParams{
  val io = IO(new Bundle{
    val input_ports:Vec[DecoupledIO[UInt]] = IOType match {
      case "InputPorts" => Vec(1, Flipped(DecoupledIO(UInt(fabricDataWidth.W))))
      case "OutputPorts" => Vec(numSec, Flipped(DecoupledIO(UInt(fabricDataWidth.W))))
    }
    val output_ports:Vec[DecoupledIO[UInt]] = IOType match {
      case "InputPorts" => Vec(numSec, DecoupledIO(UInt(fabricDataWidth.W)))
      case "OutputPorts" => Vec(1, DecoupledIO(UInt(fabricDataWidth.W)))
    }
    val sel_wire = Input(UInt({
      if(log2Ceil(numSec)<1){
        1
      }else{
        log2Ceil(numSec)
      }
    }.W))
  })

  val SelReg = RegInit(0.U({
    if(log2Ceil(numSec)<1){
      1
    }else{
      log2Ceil(numSec)
    }
  }.W))
  SelReg := io.sel_wire
  //TODO: How to select is not defined yet

  val ChannelArray = new Array[ModuleChannel](numSec)
  if(IOType=="InputPorts"){
    for(nS <- 0 until numSec){

      ChannelArray(nS) = Module(new ModuleChannel(
        deCompInput = 1,
        deCompOutput = secDecomp(nS),
        FIFOdepth = Array.fill[Int](secDecomp(nS))(secFIFO(nS))
      ))
      io.output_ports(nS).bits := ChannelArray(nS).io.output_ports.map(_.bits).reduceLeft(Cat(_,_))
      io.output_ports(nS).valid := ChannelArray(nS).io.output_ports.map(_.valid).reduceLeft(_&&_)
      ChannelArray(nS).io.output_ports.foreach(ioP=>{
        ioP.ready := io.output_ports(nS).ready
      })
    }
    Range(0,numSec).foreach(nS=>{
      when(SelReg === nS.U){
        ChannelArray(nS).io.input_ports.map(_.bits).reduceLeft(Cat(_,_)) := io.input_ports.head.bits
        ChannelArray(nS).io.input_ports.foreach(iPV=>{
          iPV.valid := io.input_ports.head.valid
        })
        io.input_ports.head.ready := ChannelArray(nS).io.input_ports.map(_.ready).reduceLeft(_&&_)
      }.otherwise{
        ChannelArray(nS).io.input_ports.map(_.bits).reduceLeft(Cat(_,_)) := 0.U
        ChannelArray(nS).io.input_ports.foreach(iPV=>{
          iPV.valid := false.B
        })
        io.input_ports.head.ready := false.B
      }
    })
  }else if(IOType=="OutputPorts"){
    for(nS <- 0 until numSec){
      ChannelArray(nS) = Module(new ModuleChannel(
        deCompInput = secDecomp(nS),
        deCompOutput = 1,
        FIFOdepth = Array.fill[Int](secDecomp(nS))(secFIFO(nS))
      ))
      ChannelArray(nS).io.input_ports.zipWithIndex.foreach(cIP=>{
        val iP = cIP._1
        val ind = cIP._2
        val decompDataWidth = fabricDataWidth/secDecomp(nS)
        iP.bits := io.input_ports(nS).bits(decompDataWidth * (ind + 1) - 1,decompDataWidth*ind)
      })
      ChannelArray(nS).io.input_ports.foreach(ipC=>{
        ipC.valid := io.input_ports(nS).valid
      })
      io.input_ports(nS).ready := ChannelArray(nS).io.input_ports.map(_.ready).reduceLeft(_&&_)
    }

    Range(0,numSec).foreach(nS=>{
      when(SelReg === nS.U){
        io.output_ports.head.bits := ChannelArray(nS).io.output_ports.map(_.bits).reduceLeft(Cat(_,_))
        io.output_ports.head.valid := ChannelArray(nS).io.output_ports.map(_.valid).reduceLeft(_&&_)
        ChannelArray(nS).io.output_ports.foreach(oPC=>{
          oPC.ready := io.output_ports.head.ready
        })
      }.otherwise{
        io.output_ports.head.bits := 0.U
        io.output_ports.head.valid := false.B
        ChannelArray(nS).io.output_ports.foreach(oPC=>{
          oPC.ready := false.B
        })
      }
    })

  }else{
    throw new Exception("IOType can only be In/OutputPorts")
  }

}

object InterfacePortDriver extends App {chisel3.Driver.execute(args, () => new InterfacePort("InputPorts",2,List(4,4),List(4,4)))}