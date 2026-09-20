class_name PlayerBark extends PlayerAction

func do_action() -> void:
	RoomManager.player_took_action.emit()
	performingPlayer.myTurn = false
