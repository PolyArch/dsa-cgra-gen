// See README.md for license details.

package encode

import scala.collection.mutable.Map

object configSwitchContentEncode extends configEncode {
  class MuxHw(oPort:Int,sNet:Int) {
    val outPort :Int= oPort
    val subNet :Int= sNet

    override def equals(obj: scala.Any): Boolean = {
      obj match {
        case x:MuxHw => x.subNet == this.subNet && x.outPort == this.outPort
        case _ => false
      }
    }
  }
  class MuxEncode(cB:Int,L:Int,H:Int) {
    var configBitSec : Int = cB
    val lowBit :Int= L
    val highBits :Int= H
    var EncodeType = "SwitchMux"
  }
  def switchContentEncode(SegRegWidth:Array[(Int,Int,Int)])
  :Map[(Int,Int),MuxEncode]={
    val SwitchMuxEncode = Map[(Int,Int),MuxEncode]()
    var configSection = 0
    var lowBit = colBits.high + 1
    var highBit = lowBit
    for (outPort <- SegRegWidth.map(OpSnWi => OpSnWi._1).distinct.sorted){
      val sortedSubnetWidth = SegRegWidth.filter(_._1 == outPort)
        .map(OpSnWi=>(OpSnWi._2,OpSnWi._3)).sortBy(_._1)
      for(subNetIndex <- sortedSubnetWidth.indices){
        val SelRegWidth = sortedSubnetWidth(subNetIndex)._2
        highBit = lowBit + SelRegWidth - 1
        if(highBit > configContent.high){
          // switch to new section
          lowBit = colBits.high + 1
          highBit = lowBit + SelRegWidth - 1
          configSection += 1
          if(highBit > configContent.high)
            throw new Exception(s"Output Direction " +
              s"${outPort}, subNet " +
              s"${sortedSubnetWidth(subNetIndex)}," +
              s" its config bits length exceed the maximum")
        }

        val muxHw = (outPort,sortedSubnetWidth(subNetIndex)._1)
        val muxEncode = new MuxEncode(configSection,lowBit,highBit)
        SwitchMuxEncode += (muxHw -> muxEncode)
        lowBit = highBit + 1
      }
    }
    SwitchMuxEncode
  }
}
