extends Entity

@export var room_index : int 
@export var connected_location : Vector2
@export var is_locked : bool 

var other_room : Room 

func _ready() -> void:
	set_other_room.call_deferred()

func set_other_room() -> void: 
	if RoomManager.rooms.size() > 0 :
		other_room = RoomManager.rooms[room_index]
		myCell.entity_enter.connect(change_room)


func transition_condition_met() -> bool:
	return !is_locked

func change_room(entering_entity: Entity) -> void: 
	
	if transition_condition_met():
		
		RoomManager.current_room = 	 RoomManager.rooms[room_index]
		RoomManager.room_changed.emit()
		entering_entity.reparent(other_room.get_cell(connected_location.x, connected_location.y), false)
		entering_entity.myCell = entering_entity.get_parent()
		entering_entity.myCell.occupyingEntity = entering_entity
		RoomManager.camera.reparent(RoomManager.current_room)
		RoomManager.camera.position = Vector2(84,84)
		

		
	
