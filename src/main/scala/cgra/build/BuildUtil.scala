package cgra.build

import cgra.entity.Entity

trait BuildUtil {
  var internal_entity_id_counter = 0
  def assign_entity_id(ll:List[Entity]) :Int={
    ll.foreach(x=>{x.entity_id = internal_entity_id_counter;internal_entity_id_counter += 1})
    internal_entity_id_counter
  }
  def assign_entity_id(ll:List[Entity],start:Int) :Unit={
    internal_entity_id_counter = start
    assign_entity_id(ll)
  }
}
