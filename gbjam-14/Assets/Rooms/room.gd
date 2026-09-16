class_name Room extends Node2D

@export var grid : Array[Cell] = []
@export var grid_width : int
@export var grid_height : int

func _ready() -> void:
	RoomManager.current_room = self
	for i in grid.size():
		grid[i].roomLocation = Vector2(i % grid_width, i / grid_width)

		

func set_cell(cell_to_put: Cell, x : int,y : int) -> void :
	var index = x + (y * grid_width)
	grid[index] = cell_to_put
	
func get_cell(x : int,y : int) -> Cell :
	#print("Trying to get cell at ", x, ",", y)
	var index = x + (y * grid_width)
	return grid[index]

func validate_index(x: int, y: int) -> bool: 
	var index = x + (y * grid_width) 
	if index >= 0 && index < grid.size() :
		return true
	return false
