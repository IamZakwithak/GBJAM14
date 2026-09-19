class_name Player extends Entity

@export var inventoryParent : Node2D

var move : PlayerMove = PlayerMove.new()
var bark : PlayerBark = PlayerBark.new()
var interact : PlayerInteract = PlayerInteract.new()

var inventory_item : PickupItem

func _ready() -> void:
	myCell = get_parent()
	move.performingEntity = self 
	bark.performingEntity = self
	interact.performingPlayer = self
	RoomManager.current_room = get_parent().get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up"):
			move.direction = Vector2(0,-1)
			take_action(move)
	if event.is_action_pressed("move_left"):
			move.direction = Vector2(-1,0)
			take_action(move)
	if event.is_action_pressed("move_right"):
			move.direction = Vector2(1,0)
			take_action(move)
	if event.is_action_pressed("move_down"):
			move.direction = Vector2(0, 1)
			take_action(move)
	if event.is_action_pressed("interact"):
			take_action(interact)
	if event.is_action_pressed("bark"):
			take_action(bark)
	
func take_action(action : Action) -> void: 
	
	if(action.can_do_action()) : 
		RoomManager.player_took_action.emit()
		action.do_action() 
