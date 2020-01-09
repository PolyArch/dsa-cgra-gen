package TestUtil

object Random {
  implicit class ExtendedRandom(ran: scala.util.Random) {
    def nextByte = (ran.nextInt(256)).toByte
    def nextByteArray(size: Int) = {
      val arr = new Array[Byte](size)
      ran.nextBytes(arr)
      arr
    }
  }
  def LeadZeros(src: String, bitLength : Int) : String = {
    if(src.length < bitLength){
      LeadZeros("0" + src, bitLength)
    }else{
      src
    }
  }
}

