extends Button

@onready var sfx_start_pressed: AudioStreamPlayer2D = $SFX_StartPressed
@onready var start_button_sprite: Sprite2D = $StartButtonSprite

func _on_pressed() -> void:
	sfx_start_pressed.play()
	
func _on_sfx_start_pressed_finished() -> void:
	get_tree().change_scene_to_file("res://Scenes/dungoen.tscn")

func _ready() -> void:
	mouse_entered.connect(on_button_hovered)
	mouse_exited.connect(on_button_unhovered)

func _process(delta: float) -> void:
	if Input.is_action_pressed("interact"):
		get_tree().change_scene_to_file("res://Scenes/dungoen.tscn")

func on_button_hovered():
	start_button_sprite.frame = 1
	
func on_button_unhovered():
	start_button_sprite.frame = 0
