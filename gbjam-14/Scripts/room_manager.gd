extends Node

signal player_took_action
signal dungeon_turn_start
signal return_action_to_player
signal room_changed
signal dungeon_come_to_life

var camera : Camera2D
var current_room : Room
var dungeonAlive : bool = false
var rooms : Array[Room] = []
@export var default_dungeon_time = 0.5
var special_timer = 0.0
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	player_took_action.connect(delay_to_dungeon_turn)
	dungeon_come_to_life.connect(toggle_life_bool)

func get_current_room() -> Room: 
	return current_room

func delay_to_dungeon_turn () -> void: 
	await get_tree().create_timer(0.5).timeout
	dungeon_turn_start.emit()
	var time_to_wait = special_timer if special_timer != 0.0 else default_dungeon_time
	await get_tree().create_timer(special_timer).timeout
	return_action_to_player.emit()

func toggle_life_bool() -> void: 
	dungeonAlive = true
