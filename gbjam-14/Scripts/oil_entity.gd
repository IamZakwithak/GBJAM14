class_name Oil extends InteractableEntity

var activeOil = false

func _ready() -> void:
	myCell = get_parent()
	RoomManager.dungeon_come_to_life.connect(toggle_active)
	
func do_interaction() -> void:
	pass

func toggle_active() -> void: 
	if(myCell.myRoom.room_index == RoomManager.current_room.room_index):
		activeOil = !activeOil
		if activeOil:
			$OilActiveSprite.visible = true
			$OilInactiveSprite.visible = false
		else : 
			$OilActiveSprite.visible = false
			$OilInactiveSprite.visible = true
