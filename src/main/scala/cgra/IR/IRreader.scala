package cgra.IR

import org.yaml.snakeyaml.Yaml
import org.yaml.snakeyaml.constructor.Constructor

import scala.collection.mutable.ListBuffer
import scala.reflect
import java.io.{File, FileInputStream}
import scala.beans.BeanProperty

object IRreader {
  def main(args: Array[String]) {
    val filename = "/home/sihao/ss-cgra-gen/src/main/scala/cgra/cgra_3x3"
    val input = new FileInputStream(new File(filename))
    val yaml = new Yaml
    val e = yaml.load(input)
    println(e)
  }
}

class EmailAccount {
  @BeanProperty var accountName = ""
  @BeanProperty var username = ""
  @BeanProperty var password = ""
  @BeanProperty var mailbox = ""
  @BeanProperty var imapServerUrl = ""
  @BeanProperty var protocol = ""
  @BeanProperty var minutesBetweenChecks = 0
  @BeanProperty var usersOfInterest = new java.util.ArrayList[String]()
  override def toString: String = s"acct: $accountName, user: $username, url: $imapServerUrl"
}