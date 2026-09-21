class_name DartEntity extends Entity

var move = DartMoveAction
var direction : Vector2i = Vector2i(0,0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move = DartMoveAction.new()
	move.performingEntity = self
	deferred_stuff.call_deferred()
	RoomManager.dungeon_turn_start.connect(take_action)
	RoomManager.room_changed.connect(destroy_self)

func deferred_stuff() -> void: 
	myCell = get_parent()

func take_action() -> void: 
	if(move.can_do_action()) :  
		move.do_action() 

func destroy_self() -> void: 
	queue_free()
