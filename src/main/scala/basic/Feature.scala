package basic

trait RegisterControlled extends Entity {
  Parameters += "index_config_register" -> -1
  Parameters += "config_base" -> -1
  Parameters += "config_bound" -> -1
}

trait IsPort extends Entity {
  Parameters += "IO Type" -> ""
  Parameters += "hasValid" -> false
  Parameters += "hasReady" -> false
  Parameters += "function" -> "" // data/control
}
trait WithWordWidth extends Entity {
  Parameters += "Word_Width" -> -1
}

trait WithRegisterFile extends Entity {
  Parameters += "register_files_length" -> -1
  Parameters += "register_file_width" -> -1
}

trait WithDecomposer extends Entity {
  Parameters += "input_decomposer" -> List()
  Parameters += "output_decomposer" -> List()
}