package cgra.IR

import java.util

import chisel3.util.log2Ceil
import scala.collection.mutable._
import scala.collection.JavaConversions._
import cgra.config.encoding.update_encoding
import scala.collection.JavaConverters.{asScalaBuffer, mapAsScalaMap}
import scala.collection.mutable

object IRconvertor {
  // ------ Common ------
  implicit def JavaMap2ScalaMap(javaMap:util.Map[String,Any]):mutable.Map[String,Any]={
    val scalaMap = mapAsScalaMap(javaMap)
    for(kv <- scalaMap){
      val (key,value) = kv
      println("key = " + key + ", value = " + value)
      scalaMap(key) = value match {
        case i:Int => i
        case d:Double =>  d
        case b:Boolean => b
        case s:String => s
        case ll:List[_] => ll
        case l:util.ArrayList[_] => {
          asScalaBuffer(l.map(p => p match {
            case p:util.Map[String,Any] => JavaMap2ScalaMap(p)
            case _ => p
          })).toList
        }
        case jMap:util.Map[String,Any] => JavaMap2ScalaMap(jMap)
      }
    }
    scalaMap
  }
  implicit def JavaListString2ScalaListString(a:util.ArrayList[String]):List[String]={
    asScalaBuffer(a).toList
  }
}
