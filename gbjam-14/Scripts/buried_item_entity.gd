class_name BuriedItemEntity extends Entity

@onready var previous_state: bool = false
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

func _process(_delta: float) -> void:
	if self.diggable != previous_state:
		previous_state = self.diggable
		if previous_state:
			animation_player.play("Item_Buried")
		else:
			animation_player.play("RESET")
