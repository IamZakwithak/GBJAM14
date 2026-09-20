class_name DartEntity extends Entity

@export var move = DartMoveAction
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move = DartMoveAction.new()
	RoomManager.dungeon_turn_start.connect(move.do_action)
