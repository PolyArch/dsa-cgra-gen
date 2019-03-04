package basic

import basic.Constant._
import scala.collection.mutable.ListBuffer

trait EntityUtil {
  def assign_direction(pss:ListBuffer[Port]):Unit={

    if(pss.forall(p=>p.get("Port_Index")==None && p.get("Direction") == None)){
      for (i <- pss.indices){
        pss(i).have("Port_Index",i)
      }
    }
    for (ps <- pss){
      val index = ps.get("Port_Index")
      ps.have("Direction",Index_Direction_Map(index.asInstanceOf[Int]))
    }
  }
}
