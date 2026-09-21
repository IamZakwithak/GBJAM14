class_name PickupItemGem extends PickupItem


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func do_interaction() -> void:
	RoomManager.dungeonAlive = true
	RoomManager.dungeon_come_to_life.emit()
	super()

func drop_item_func() -> void:
	RoomManager.dungeonAlive = false
	RoomManager.dungeon_go_to_sleep.emit()
	
