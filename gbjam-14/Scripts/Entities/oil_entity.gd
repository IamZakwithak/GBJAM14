extends Entity

func _ready() -> void:
	self.myCell = get_parent()
	myCell.occupyingEntity = self
