package basic

trait BuildUtil {
  var internal_entity_id_counter = 0
  def assign_entity_id(ll:List[Entity]) :Unit={
    ll.foreach(x=>{x.entity_id = internal_entity_id_counter;internal_entity_id_counter += 1})
  }
  def assign_entity_id(ll:List[Entity],start:Int) :Unit={
    internal_entity_id_counter = start
    assign_entity_id(ll)
  }
}