extends Entity

func _ready() -> void:
	self.myCell = get_parent()
	myCell.occupyingEntity = self

func can_entity_enter(entering_entity: Entity) -> bool:
	return false
