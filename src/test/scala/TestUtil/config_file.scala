package TestUtil
import scala.io.Source

object config_file {
  def get_config_bits(filename:String): Seq[BigInt] ={
    val line_list = Source.fromFile(filename).getLines.toList
    val no_comment_lines = line_list.filter(line => !line.trim.startsWith("//"))
    val config_bits = no_comment_lines.map(line=>BigInt(line.split(" ").apply(1)))
    config_bits
  }
}
