package cgra.IR
import java.io._
import java.util

import org.yaml.snakeyaml.Yaml

import scala.collection.JavaConverters._
import scala.collection.mutable

object IRwriter {
  def writeCgra(c:mutable.Map[String,Any], filename:String) = {
    // TODO: I don't see the necessity to write back IR at this point
    // create and populate a java map
    val jMap = new util.HashMap[String, String]()
    jMap.put("first_name", "Alvin")
    jMap.put("last_name",  "Alexander")

    // convert the java map to a scala map
    val sMap = jMap.asScala

    val yaml = new Yaml
    val output = yaml.dump(jMap)
    System.out.println(output)

    val pw = new PrintWriter(new File(filename))
    pw.write(output)
    pw.close
  }
}
