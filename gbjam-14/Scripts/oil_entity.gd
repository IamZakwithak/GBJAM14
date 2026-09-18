extends Entity

class_name Oil

func _ready() -> void:
	self.myCell = get_parent()
	myCell.occupyingEntity = self
