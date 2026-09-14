class_name Room extends Node2D

@export var grid : Array[Cell] = []
@export var grid_width : int
@export var grid_height : int

func set_cell(cell_to_put: Cell, x : int,y : int) -> void :
	var index = x + (y * grid_width)
	grid[index] = cell_to_put
	
func get_cell(x : int,y : int) -> Cell :
	var index = x + (y * grid_width)
	return grid[index]
