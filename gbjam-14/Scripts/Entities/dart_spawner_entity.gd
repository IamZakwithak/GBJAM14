class_name DartSpawnerEntity extends EntitySpawner

@export var dart_spawn_direction : Vector2i
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RoomManager.dungeon_come_to_life.connect(spawn_entity)

func spawn_entity() -> void:
	var entity_ref = entity_to_spawn.instantiate() as DartEntity
	myCell.add_child(entity_ref)
	myCell.overlappedEntity = entity_ref	
	entity_ref.direction = dart_spawn_direction
