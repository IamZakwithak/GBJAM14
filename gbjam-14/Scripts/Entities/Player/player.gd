class_name Player extends Entity

@export var inventoryParent : Node2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var movement_direction = move.direction
@onready var isbarking: bool = false

@onready var sfx_footstep: AudioStreamPlayer2D = $SFX_Footstep
@onready var sfx_bark: AudioStreamPlayer2D = $SFX_Bark
@onready var sfx_misc: AudioStreamPlayer2D = $SFX_Misc

@onready var sfx : Dictionary [String, Array] = {
	"bark": [
		preload("res://Audio/bark1.wav"),
		preload("res://Audio/bark2_1.wav"),
		preload("res://Audio/bark3.wav"),
		preload("res://Audio/bark4.wav")
	],
	"footstep": [
		preload("res://Audio/footstep1.wav"),
		preload("res://Audio/footstep2.wav")
	],
	"stuck": [
		preload("res://Audio/hitwall.wav"),
	],
}

var move : PlayerMove = PlayerMove.new()
var bark : PlayerBark = PlayerBark.new()
var interact : PlayerInteract = PlayerInteract.new()

var myTurn : bool = true
var onOil : bool = false

var inventory_item : PickupItem


func _ready() -> void:
	myCell = get_parent()
	move.performingPlayer = self 
	bark.performingPlayer = self
	interact.performingPlayer = self
	RoomManager.current_room = get_parent().get_parent()
	RoomManager.return_action_to_player.connect(player_turn_again)

func play_sound(comp, key=null):
	
	if typeof(comp) == TYPE_STRING:
		key = comp
		comp = sfx_misc
	
	comp.stream = sfx[key].pick_random()
	comp.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event: InputEvent) -> void:
	if !myTurn || onOil:
		print("not my turn")
		return
	if event.is_action_pressed("move_up"):
		move_towards(0, -1)
	if event.is_action_pressed("move_left"):
		move_towards(-1, 0)
	if event.is_action_pressed("move_right"):
		move_towards(1, 0)
	if event.is_action_pressed("move_down"):
		move_towards(0, 1)
	if event.is_action_pressed("interact"):
		take_action(interact)
	if event.is_action_pressed("bark"):
		isbarking = true
		update_bark_direction()
		if take_action(bark):
			play_sound(sfx_bark, "bark")
	
func update_anim(vector2: Vector2):
	animation_tree.set("parameters/StateMachine/MoveState/StandState/blend_position", vector2)
	
func update_bark_direction():
	animation_tree.set("parameters/StateMachine/MoveState/BarkState/blend_position", movement_direction)

func move_towards(x: int, y : int):
	move.direction = Vector2(x,y)
	movement_direction = move.direction
	update_anim(movement_direction)
	
	if take_action(move):
		play_sound(sfx_footstep, "footstep")
	else:
		play_sound(sfx_footstep, "stuck")

func take_action(action : Action) -> bool: 
	
	if(action.can_do_action()) :  
		action.do_action()
		return true
	else:
		return false

func player_turn_again() -> void: 
	myTurn = true

func _on_sfx_bark_finished() -> void:
	isbarking = false
