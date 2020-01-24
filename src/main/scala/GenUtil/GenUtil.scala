package GenUtil

import java.nio.file.{Files, Paths, StandardCopyOption}

object GenUtil {
  def moveRenameFile(source: String, destination: String): Unit = {
    val path = Files.move(
      Paths.get(source),
      Paths.get(destination),
      StandardCopyOption.REPLACE_EXISTING
    )
    // could return `path`
  }
}