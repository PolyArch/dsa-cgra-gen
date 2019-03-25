package cgra.IR

import scala.io.Source
import java.io._

object IRmerger {
  def mergeIRwithCgra(irFileName:String,cgraFileName:String)={
    // Read Original Files
    val irFile = new File(irFileName)
    val hwFile = new File(cgraFileName) // AbsolutePath
    val irLines = Source.fromFile(irFile).getLines()
    val hwLines = Source.fromFile(hwFile).getLines

    // Create Temp File
    val tempFile = new File(cgraFileName +".tmp")
    val pw = new PrintWriter(tempFile)

    // ------- Merge Togather
    // print config file
    pw.write("/*\n")
    for (line <- irLines) pw.write(line + "\n")
    pw.write("*/\n")
    pw.write("----------\n") // Print split line
    // print cgra file
    for (line <- hwLines) pw.write(line + "\n")
    pw.close

    // Rename
    val merged = tempFile.renameTo(hwFile)
    println(merged)
  }
}
