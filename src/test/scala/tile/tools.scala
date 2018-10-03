// See README.md for license details.

package tile

import scala.util.Random

object tools extends HasFabricParams{
  def asUnsigned(unsignedLong: Long):BigInt = (BigInt(unsignedLong >>> 1) << 1) + (unsignedLong & 1)
  def getRandomBits:BigInt={
    asUnsigned(Random.nextLong())
  }
  def getRandomBoolean : Boolean = Random.nextBoolean()


  def dupString (str:String,width:Int) : String = {
    if (width > 1)
      dupString(str,width-1) + str
    else
      str
  }

  def unsignedBigInt(a:BigInt,aluDataWidth:Int):BigInt = {
    if(a>=0)
      a
    else{
      val sBigIntL = a.toString(2).length
      var sBigIntBinStr = a.toString(2).substring(1,sBigIntL)

      sBigIntBinStr = dupString("0",aluDataWidth - sBigIntL + 1) + sBigIntBinStr

      println("before " + sBigIntBinStr)
      val subStr = sBigIntBinStr.map(c=>
        if(c == '0')
          '1'
        else
          '0'
      )
      println("after  " + subStr)
      BigInt(subStr,2) + 1
    }
  }

  def calculateAluResult (opcodeName:String,
                          op1:BigInt, op2:BigInt,
                          aluDataWidth:Int) : BigInt = {
    val SignedResult = opcodeName match {
      case "Add" => op1 + op2
      case "Sub" => op1 - op2
      case "Mul" => op1 * op2
      case "UDiv" => op1 / op2
      case "And" => op1 & op2
      case "Or" => op1 | op2
      case "Xor" => op1 ^ op2
      case _ => throw new Exception("No match opcode")
    }


    val SignedResultBinary = SignedResult.toString(2)
    val SignedResultBinaryLen = SignedResultBinary.length

    println("calculating expected SignedResult " + SignedResultBinary)

    var UnsignedResult = unsignedBigInt(SignedResult,aluDataWidth)

    if(UnsignedResult.toString(2).length > aluDataWidth)
      UnsignedResult = BigInt(UnsignedResult.toString(2).reverse.substring(0,aluDataWidth).reverse,2)

    println("calculating expected UnsignedResult " + UnsignedResult.toString(2))
    UnsignedResult
  }
}
