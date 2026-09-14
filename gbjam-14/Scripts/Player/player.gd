class_name Player extends Entity


# Called when the node enters the scene tree for the first time.

var move : PlayerMove = PlayerMove.new()
var dig : PlayerDig = PlayerDig.new()
var pickup : PlayerPickup = PlayerPickup.new()

func _ready() -> void:
	
	move.performingEntity = self 
	dig.performingEntity = self
	pickup.performingEntity = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	match event:
		"move_up":
			move.direction = Vector2(0,1)
			take_action(move)
		"move_down":
			move.direction = Vector2(0,-1)
			take_action(move)
		"move_left":
			move.direction = Vector2(-1,0)
			take_action(move)
		"move_right":
			move.direction = Vector2(1,0)
			take_action(move)
		"pickup":
			pass
		"dig":
			pass
		"pause":
			pass 
	
func take_action(action : Action) -> void: 
	
	if(action.can_do_action()) : 
		RoomManager.player_took_action.emit()
		action.do_action() 
