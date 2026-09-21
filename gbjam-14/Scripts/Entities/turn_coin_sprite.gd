extends Sprite2D

@export var animation_player: AnimationPlayer
@onready var last_player_state: bool = true

func _process(_delta:float) -> void:
	var player_ref = get_tree().get_first_node_in_group("Player")
	if player_ref.myTurn != last_player_state:
		last_player_state = player_ref.myTurn
		if player_ref.myTurn:
			animation_player.play("Dungeon_To_Player")
		else:
			animation_player.play("Player_To_Dungeon")
