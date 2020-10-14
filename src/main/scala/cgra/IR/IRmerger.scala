package cgra.IR

import scala.io.Source
import java.io._
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

// IR merger is used to merge the IR with the Yaml Configuration
object IRmerger {
  def mergeIRwithCgra(irFileName:String,cgraFileName:String)={
    // Read Original Files
    val irFile = new File(irFileName)
    val hwFile = new File(cgraFileName) // AbsolutePath
    val irLines = Source.fromFile(irFile).getLines()
    val hwLines = Source.fromFile(hwFile).getLines

    // Timestamp
    val tp : String = DateTimeFormatter.ofPattern("yyMMdd_HHmmss").format(LocalDateTime.now)

    // Create Temp File
    val tempFileName : String = cgraFileName.split("\\.").head + "_" + tp +".v"
    val tempFile = new File(tempFileName)
    val pw = new PrintWriter(tempFile)

    // ------- Merge Togather
    // print config file
    pw.write("/*\n")
    for (line <- irLines) pw.write(line + "\n")
    pw.write("*/\n")
    // print cgra file
    for (line <- hwLines) pw.write(line + "\n")
    pw.close
    println("Generated Verilog File Path : \n" + tempFile.getAbsolutePath)
  }
}
