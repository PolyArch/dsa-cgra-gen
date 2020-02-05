package dsl

class sslink extends IRPrintable{
  private var sink_node:ssnode = _
  private var source_node:ssnode = _
  def get_source = source_node
  def get_sink = sink_node
  def * (duplicate_time:Int) = {
    for (i <- 0 until duplicate_time) yield source_node --> sink_node
  }
  def postprocess():Unit = {}

  def reverse():Unit={
    val thisSourceInfo = getPropByKey("source")
    val thisSinkInfo = getPropByKey("sink")
    // Delete Original
    sink_node.delete_source(source_node)
    source_node.delete_sink(sink_node)
    // Add Reverse
    sink_node.add_sink(source_node)
    source_node.add_source(sink_node)
    apply("source",thisSinkInfo)
    apply("sink",thisSourceInfo)
  }

  def apply(source:ssnode, sink:ssnode)={
    source_node = source
    sink_node = sink
  }

  def delete:Unit={
    source_node.delete_sink(sink_node)
    sink_node.delete_source(source_node)
  }
}