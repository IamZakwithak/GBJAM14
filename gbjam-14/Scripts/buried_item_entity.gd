class_name BuriedItemEntity extends Entity

@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

func _ready():
	animation_player.play("Item_Buried")
