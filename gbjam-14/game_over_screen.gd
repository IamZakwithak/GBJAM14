extends Node2D

@export_file var dungeon_scene_path : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up"):
			$".".get_tree().change_scene_to_file(dungeon_scene_path)
	if event.is_action_pressed("move_left"):
			$".".get_tree().change_scene_to_file(dungeon_scene_path)
	if event.is_action_pressed("move_right"):
			$".".get_tree().change_scene_to_file(dungeon_scene_path)
	if event.is_action_pressed("move_down"):
			$".".get_tree().change_scene_to_file(dungeon_scene_path)
	if event.is_action_pressed("interact"):
			$".".get_tree().change_scene_to_file(dungeon_scene_path)
	if event.is_action_pressed("bark"):
			$".".get_tree().change_scene_to_file(dungeon_scene_path)
