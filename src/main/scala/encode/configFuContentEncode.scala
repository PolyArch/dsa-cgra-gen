// See README.md for license details.

package encode

import encode.configSwitchContentEncode.{MuxEncode, MuxHw, colBits, configContent}
import tile.Constant._
import scala.collection.mutable.Map

object configFuContentEncode extends configEncode{
  class FuMuxHw(oPort:Int,sNet:Int,oPer:Int)
    extends MuxHw(oPort,sNet) {
    val operand:Int = oPer
    override def equals(obj: scala.Any): Boolean = {
      obj match {
        case x:FuMuxHw => x.subNet == this.subNet &&
          x.outPort == this.outPort &&
          x.operand == this.operand
        case _ => false
      }
    }
  }
  class FuEncode (cB:Int,L:Int,H:Int,cP:String)
    extends MuxEncode(cB,L,H){
    EncodeType = cP

    override def toString: String = {
      "section:" + this.configBitSec + ", " +
        "Low:" + this.lowBit + ", " +
        "High:" + this.highBits + ", " +
        "type:" + this.EncodeType
    }
  }
  def fuContentEncode(OpSbOpType_Wid:Array[(Int,Int,Int,String,Int)])
    :Map[(Int,Int,Int,String),FuEncode] = {
    val FuContentEncode = Map[(Int,Int,Int,String),FuEncode]()
    var configSection = 0
    var lowBit = colBits.high + 1
    var highBit = lowBit
    for (outPort <- OpSbOpType_Wid.map(OpSnWi => OpSnWi._1).distinct.sorted){
      val sortedSubnetWidth = OpSbOpType_Wid.filter(_._1 == outPort)
        .map(OpSnWi=>(OpSnWi._2,OpSnWi._3,OpSnWi._4,OpSnWi._5)).sortBy(_._1)
      for(subNet <- sortedSubnetWidth.map(_._1).distinct.sorted){
        val sortedOperandTypeWidth = sortedSubnetWidth.filter(_._1 == subNet)
          .map(SbOpTy_Wid => (SbOpTy_Wid._2,SbOpTy_Wid._3,SbOpTy_Wid._4)).sortBy(_._1)
          require(sortedOperandTypeWidth.filter(_._2 == "ALU").length == 1)
        for(componentType <- ComponentInFu){
          val sortedOperandWidth = sortedOperandTypeWidth.filter(_._2 == componentType)
            .map(SbOpTy_Wid => (SbOpTy_Wid._1,SbOpTy_Wid._3)).sortBy(_._1)
          for (operand <- sortedOperandWidth.indices){
            val componentWidth:Int = sortedOperandWidth(operand)._2
            highBit = lowBit + componentWidth - 1
            if(highBit > configContent.high){
              // switch to new section
              lowBit = colBits.high + 1
              highBit = lowBit + componentWidth - 1
              configSection += 1
              if(highBit > configContent.high)
                throw new Exception(s"Output Direction " +
                  s"${outPort}, subNet " +
                  s"${subNet}, operand " +
                  s"${operand}"+
                  s" its config bits length exceed the maximum")
            }
            val FuComponentHw = (outPort,subNet,operand,componentType)
            val FuEncode = new FuEncode(configSection,lowBit,highBit,componentType)
            FuContentEncode += (FuComponentHw -> FuEncode)
            lowBit = highBit + 1
          }
        }
      }
    }
    FuContentEncode
  }
}
