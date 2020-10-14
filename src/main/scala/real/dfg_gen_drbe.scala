package real

import java.io.{File, PrintWriter}

object dfg_gen_drbe extends App {

  for(num_link <- 2 until 32 by 2; num_node <- 2 until 32 by 2){
    val pw = new PrintWriter(new File(s"./drbe/dfg_link${num_link}_node${num_node}.dfg"))
    // Write the input
    pw.write(s"Input: I [$num_link]\n")

    // Write link
    pw.write("\n")
    for(link_idx <- 0 until num_link){
      for(node_idx <- 0 until num_node){
        if(node_idx == 0){
          pw.write(s"Agg${link_idx}_${node_idx} = PPU(I${link_idx}, 0.0f)\n")
        }else {
          pw.write(s"Agg${link_idx}_${node_idx} = PPU(I${link_idx}, Agg${link_idx}_${node_idx - 1})\n")
        }
      }
      pw.write(s"O${link_idx} = PPU(I${link_idx}, Agg${link_idx}_${num_node - 1})\n")
      pw.write("\n")
    }

    // Write the output
    pw.write(s"Output: O [$num_link]\n")

    pw.close
  }
}

import java.io._

object drbe_command_gen extends App{
  val pw = new PrintWriter(new File(s"./drbe/command_v1.sh"))
  for(num_row <- 4 to 32 by 2; num_col <- 4 to num_row by 2; num_link <- 2 until 32 by 2; num_node <- 2 until 32 by 2){
    if(num_link * num_node <= num_row * num_col){
      val hw_name = s"drbe_row${num_row}_col$num_col.json"
      val sw_name = s"dfg_link${num_link}_node$num_node.dfg"
      pw.write(s"ss_sched ${"./configs/drbe/"+hw_name} ${"./dfgs/drbe/"+sw_name} -v > ./logs/log_row${num_row}_col${num_col}_link${num_link}_node${num_node}.txt\n")
    }
  }
  pw.close()
}