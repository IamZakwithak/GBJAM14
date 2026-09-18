extends Entity

@export var connected_cell: int
@onready var entity_to_unlock = self.get_parent().get_parent().grid[connected_cell -1].get_child(0)
#Need to make sure the transition entity is the first child of the Cell node 					 ^

func _ready():
	set_entity_to_unlock.call_deferred()

func set_entity_to_unlock():
	myCell.entity_enter.connect(unlock_entity)
	
func unlock_entity(entering_entity: Entity) -> void:
	if entity_to_unlock.is_locked:
		entity_to_unlock.is_locked = false
