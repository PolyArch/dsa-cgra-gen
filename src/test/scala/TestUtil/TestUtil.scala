package TestUtil

object CgraTestUtil {
  implicit class ExtendedRandom(ran: scala.util.Random) {
    def nextByte = (ran.nextInt(256)).toByte
    def nextByteArray(size: Int) = {
      val arr = new Array[Byte](size)
      ran.nextBytes(arr)
      arr
    }
  }
  def fixLength(src: String, bitLength : Int) : String = {
    if(src.length < bitLength){
      fixLength("0" + src, bitLength)
    }else{
      src.reverse.substring(0,bitLength).reverse
    }
  }
  implicit class BigIntUtil(num : BigInt) extends scala.AnyRef {
    private val binaryString : String = num.toString(2);
    private val length : Int = num.bitLength

    def clear : BigInt = 0
    def Bi : String = binaryString
    def Bi(len:Int) : String = {
      fixLength(binaryString,len)
    }
    def Bi(binaryString: String) : BigInt ={
      BigInt(binaryString,2)
    }
    private def rec_setBit(num:BigInt, high:Int, low: Int) : BigInt ={
      if(low > high){
        num
      }else{
        rec_setBit(num.setBit(low), high, low+1)
      }
    }
    def apply(high:Int, low: Int) : BigInt ={
      val res = Bi(num.Bi(high + 1).reverse.substring(low,high+1).reverse)
      res
    }
    def setBit(high:Int, low:Int) : BigInt ={
      rec_setBit(num, high, low)
    }
    def allSet : BigInt = {
      rec_setBit(num,length - 1, 0)
    }
    def decompose(decomposer: Int, dBitLength: Int) : IndexedSeq[BigInt]={
      for(slot_idx <- 0 until decomposer) yield {
        val low = dBitLength * slot_idx
        val high = dBitLength * (slot_idx + 1) - 1
        num(high,low)
      }
    }
    def decompose(decomposer: Int) : IndexedSeq[BigInt] ={
      val dBitLength : Int = {
        val mo = length % decomposer
        if (mo == 0){
          length / decomposer
        }else{
          length / decomposer + 1
        }
      }
      decompose(decomposer,dBitLength)
    }
    def ||| (str: String, bitLength: Int) : BigInt = {
      if(str.length < bitLength){
        num ||| (str + str, bitLength)
      }else{
        Bi(num.Bi + str.reverse.substring(0,bitLength).reverse)
      }

    }
    def ||| (str : String) : BigInt = {
      Bi(num.Bi + str)
    }
    def ||| (lower_value : BigInt, bitLength: Int) : BigInt = {
      if (bitLength > 0) {
        Bi(num.Bi + lower_value.Bi(bitLength))
      } else if (bitLength == 0) {
        num
      } else {
        assert(false,"append a negative length value??")
        num
      }
    }
    def |*| (rnd_max : Int, duplicate_time : Int, bitLength: Int, isRandom : Boolean):BigInt = {
      if(duplicate_time < 1){
        num
      }else{
        if(isRandom) {
          val rnt_int = scala.util.Random.nextInt(rnd_max)
          (num ||| (rnt_int, bitLength)) |*| (rnd_max, duplicate_time - 1, bitLength,isRandom)
        } else {
          (num ||| (rnd_max, bitLength)) |*| (rnd_max, duplicate_time - 1, bitLength,isRandom)
        }
      }
    }
    def |*| (duplicate_time : Int, bitLength : Int):BigInt = {
      if(duplicate_time < 2){
        num
      }else{
        num ||| (num, bitLength) |*| (duplicate_time - 1, bitLength)
      }
    }
  }
}
