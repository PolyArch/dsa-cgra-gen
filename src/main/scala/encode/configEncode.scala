// See README.md for license details.

package encode

import chisel3.UInt

trait configEncode {
  val rowBits = new Bits(3,0)
  val colBits = new Bits(7,4)
  val configContent = new Bits(58,8)
  //val configSection = new Bits(59,58)
  val configSection = new Bits(61,59)
  val configHeader = new Bits(63,62)

  def configBitsString : String =
      configHeader.toBinaryString +
      //subNetBits.toBinaryString +
        configSection.toBinaryString +
        configContent.toBinaryString +
        colBits.toBinaryString + rowBits.toBinaryString

  require(rowBits.bitsLen == colBits.bitsLen)
}

class Bits(H:Int,L:Int){
  val low:Int = L
  val high:Int = H
  var content : BigInt = 0
  def bitsLen:Int = high - low + 1
  def toBinaryString:String = content.toString(2)

  require(high>=low)
  require(content.toString(2).length <= bitsLen)
}
