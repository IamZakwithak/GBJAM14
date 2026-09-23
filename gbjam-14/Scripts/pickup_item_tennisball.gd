class_name PickupItemTennisBall extends PickupItem

func _ready() -> void:
	pass # Replace with function body.

func do_interaction() -> void:
	RoomManager.dungeonAlive = true
	RoomManager.dungeon_come_to_life.emit()
	super()

func drop_item_func() -> void:
	RoomManager.dungeonAlive = false
	RoomManager.dungeon_go_to_sleep.emit()
