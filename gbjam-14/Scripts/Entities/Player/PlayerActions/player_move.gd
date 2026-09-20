class_name PlayerMove extends PlayerAction

var direction : Vector2i

func can_do_action() -> bool:
	if (!RoomManager.get_current_room().validate_index(performingPlayer.myCell.roomLocation.x + direction[0], performingPlayer.myCell.roomLocation.y + direction[1]) 
	|| (direction.x > 0 && performingPlayer.myCell.roomLocation.x == RoomManager.current_room.grid_width - 1) 
	|| (direction.x < 0 && performingPlayer.myCell.roomLocation.x == 0)):
		return false
	var cell_to_move_to : Cell = RoomManager.get_current_room().get_cell(performingPlayer.myCell.roomLocation.x + direction[0], performingPlayer.myCell.roomLocation.y + direction[1])

	if cell_to_move_to != null && cell_to_move_to.check_can_entity_enter(performingPlayer):
		return true
		
	return false
	
func do_action() -> void:
	
	var cell_to_move_to : Cell = RoomManager.get_current_room().get_cell(performingPlayer.myCell.roomLocation.x + direction[0], performingPlayer.myCell.roomLocation.y + direction[1])
	print("Moving from ", performingPlayer.myCell.roomLocation, " to ", cell_to_move_to.roomLocation, " with direction vector ", direction)
	print("Cell to move to is occupied by... ", cell_to_move_to.occupyingEntity)
	performingPlayer.myCell.entity_exited.emit()
	performingPlayer.reparent(cell_to_move_to, false)		
	if(cell_to_move_to.overlappedEntity == null && cell_to_move_to.occupyingEntity != null):
		cell_to_move_to.overlappedEntity = cell_to_move_to.occupyingEntity
	cell_to_move_to.occupyingEntity = null
	performingPlayer.myCell = cell_to_move_to
	performingPlayer.myCell.occupyingEntity = performingPlayer
	if(cell_to_move_to.overlappedEntity != null && cell_to_move_to.overlappedEntity is Oil):
		performingPlayer.onOil = true
		await cell_to_move_to.get_tree().create_timer(0.5).timeout
		if(can_do_action()):
			do_action()
	#direction = Vector2.ZERO
	performingPlayer.onOil = false
	RoomManager.player_took_action.emit()
	
