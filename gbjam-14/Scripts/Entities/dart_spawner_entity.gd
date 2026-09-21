class_name DartSpawnerEntity extends EntitySpawner

@export var dart_spawn_direction : Vector2i

var myDart : DartEntity
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RoomManager.dungeon_come_to_life.connect(spawn_entity)

func spawn_entity() -> void:
	if(myCell.myRoom.room_index == RoomManager.current_room.room_index):
		var entity_ref = entity_to_spawn.instantiate() as DartEntity
		myDart = entity_ref
		myCell.add_child(entity_ref)
		myDart.dart_died.connect(spawn_entity)
		myCell.overlappedEntity = entity_ref	
		entity_ref.direction = dart_spawn_direction
		
func can_entity_enter(entering_entity: Entity) -> bool:
	if entering_entity is DartEntity:
		return true
	return false
