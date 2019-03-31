package cgra.IR

import org.yaml.snakeyaml.Yaml
import java.io.{File, FileInputStream}
import java.util
import scala.collection.mutable._
import IRconvertor._
import cgra.config.system.data_word_width


object IRreader {
  def readCgra(filename:String) = {
    val input = new FileInputStream(new File(filename))
    val yaml = new Yaml()
    val j_cgra = yaml.load(input).asInstanceOf[util.Map[String,Any]]
    val s_cgra = JavaMap2ScalaMap(j_cgra)
    s_cgra += "description_filename" -> filename
    s_cgra += "config_filename" -> filename.replace("yaml","xml")
    s_cgra
  }
}