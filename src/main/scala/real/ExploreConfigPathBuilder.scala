package real

import cgra.IR.IRconfigpather
import cgra.IR.IRreader.readIR

object ExploreConfigPathBuilder extends App{

  // PrintWriter
  import java.io._
  val pw = new PrintWriter(new File("./IR/explore.config-path.csv" ))
  pw.write("ideal-stage, actual-stage, num-nodes, num-input, overhead\n")


  for (num_row <- 3 until 7;num_col <- 3 until 10 by 3){
    val num_node = num_col * num_row + (num_col - 1) * (num_row - 1)
    val ideal_stage = num_node / num_col;
    var max_stage = 10000.0;
    // build config path multiple time
    for(iter <- 0 until 5){
      val config_net = new config_path(num_row,num_col)
      val temp_max_stage : Double = (new IRconfigpather).build_config_path(readIR(config_net.filename + ".json"))
      println("build finished")
      if(temp_max_stage < max_stage){
        max_stage = temp_max_stage;
      }
    }
    pw.write(ideal_stage + ","
      + max_stage + ","
      + num_node + ", "
      + num_col + ", "
      + max_stage / ideal_stage + "\n")
  }

  pw.close
}
