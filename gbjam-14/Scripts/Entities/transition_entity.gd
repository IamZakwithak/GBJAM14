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


func transition_condition_met(entering_entity : Player) -> bool:
	var possible_key
	
	if(entering_entity.inventory_item != null && entering_entity.inventory_item is PickupItemKey):
		possible_key = entering_entity.inventory_item as PickupItemKey
	
	if is_locked && possible_key != null && possible_key.door_location_to_unlock == myCell.roomLocation :
		return true
		
	return !is_locked

func change_room(entering_entity: Player) -> void: 
	
	if transition_condition_met(entering_entity):
		
		RoomManager.current_room = 	 RoomManager.rooms[room_index]
		RoomManager.room_changed.emit()
		entering_entity.reparent(other_room.get_cell(connected_location.x, connected_location.y), false)
		entering_entity.myCell = entering_entity.get_parent()
		entering_entity.myCell.occupyingEntity = entering_entity
		RoomManager.camera.reparent(RoomManager.current_room)
		RoomManager.camera.position = Vector2(60,60)
		

		
	
