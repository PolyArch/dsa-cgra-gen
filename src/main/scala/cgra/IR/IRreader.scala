package cgra.IR

import org.yaml.snakeyaml.Yaml
import java.io.{File, FileInputStream}
import java.util
import IRconvertor._
import cgra.IR.IRpreprocessor._

object IRreader {
  def readIR(filename:String) = {
    val input = new FileInputStream(new File(filename))
    val yaml = new Yaml()
    val j_cgra = yaml.load(input).asInstanceOf[util.Map[String,Any]]
    val s_cgra = JavaMap2ScalaMap(j_cgra)
    s_cgra += "description_filename" -> filename
    s_cgra += "config_filename" -> filename.replace("yaml","xml")
    preprocess(s_cgra)
  }
}