class_name Player extends Entity

@export var inventoryParent : Node2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var movement_direction = move.direction
@onready var isbarking: bool = false

var move : PlayerMove = PlayerMove.new()
var bark : PlayerBark = PlayerBark.new()
var interact : PlayerInteract = PlayerInteract.new()

var myTurn : bool = true

var inventory_item : PickupItem

func _ready() -> void:
	myCell = get_parent()
	move.performingEntity = self 
	bark.performingEntity = self
	interact.performingPlayer = self
	RoomManager.current_room = get_parent().get_parent()
	RoomManager.return_action_to_player.connect(player_turn_again)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event: InputEvent) -> void:
	if !myTurn:
		return
	if event.is_action_pressed("move_up"):
			move.direction = Vector2(0,-1)
			movement_direction = move.direction
			update_anim(movement_direction)
			take_action(move)
	if event.is_action_pressed("move_left"):
			move.direction = Vector2(-1,0)
			movement_direction = move.direction
			update_anim(movement_direction)
			take_action(move)
	if event.is_action_pressed("move_right"):
			move.direction = Vector2(1,0)
			movement_direction = move.direction
			update_anim(movement_direction)
			take_action(move)
	if event.is_action_pressed("move_down"):
			move.direction = Vector2(0, 1)
			movement_direction = move.direction
			update_anim(movement_direction)
			take_action(move)
	if event.is_action_pressed("interact"):
			take_action(interact)
	if event.is_action_pressed("bark"):
			isbarking = true
			update_bark_direction()
			take_action(bark)
	
func update_anim(vector2: Vector2):
	animation_tree.set("parameters/StateMachine/MoveState/StandState/blend_position", vector2)
	
func update_bark_direction():
	animation_tree.set("parameters/StateMachine/MoveState/BarkState/blend_position", movement_direction)

	
func take_action(action : Action) -> void: 
	myTurn = false
	if(action.can_do_action()) :  
		action.do_action() 

func player_turn_again() -> void: 
	myTurn = true
