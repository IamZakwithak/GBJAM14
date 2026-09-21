extends Node2D

@export var rooms : Array[Room]
@export var camera : Camera2D
@export var buriedItemEntity : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RoomManager.rooms = rooms
	RoomManager.camera = camera
	RoomManager.current_room = rooms[0]
	RoomManager.camera.position = RoomManager.current_room.position + Vector2(84,84)
	RoomManager.buried_item_entity = buriedItemEntity
	init_room_indexes.call_deferred()

func init_room_indexes() -> void: 
	for  i in RoomManager.rooms.size():
		print("Adding room ", i)
		RoomManager.rooms[i].room_index = i

	#camera.reparent(rooms[0])
	#camera.position = rooms[0].position + Vector2(35,40)
		 # Replace with function body.
