extends Entity

class_name Blocked

@export var blocksProjectiles : bool = true

func _ready() -> void:
	self.myCell = get_parent()
	myCell.occupyingEntity = self

func can_entity_enter(entering_entity: Entity) -> bool:
	if(entering_entity is DartEntity && !blocksProjectiles):
		return true
	return false
