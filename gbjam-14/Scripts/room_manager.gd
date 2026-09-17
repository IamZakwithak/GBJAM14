extends Node

signal player_took_action
signal room_changed

var camera : Camera2D
var current_room : Room
var rooms : Array[Room] = []
# Called when the node enters the scene tree for the first time.

func get_current_room() -> Room: 
	return current_room
