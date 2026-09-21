class_name EntitySpawner extends Entity

@export var entity_to_spawn : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func spawn_entity() -> void:
	
	var entity_ref = entity_to_spawn.instantiate()
	myCell.add_child(entity_ref)
	myCell.overlappedEntity = entity_ref
	
	
	
	
