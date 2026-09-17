class_name PlayerMove extends Action

var direction : Vector2i

func can_do_action() -> bool:
	if (!RoomManager.get_current_room().validate_index(performingEntity.myCell.roomLocation.x + direction[0], performingEntity.myCell.roomLocation.y + direction[1]) 
	|| (direction.x > 0 && performingEntity.myCell.roomLocation.x == RoomManager.current_room.grid_width - 1) 
	|| (direction.x < 0 && performingEntity.myCell.roomLocation.x == 0)):
		return false
	var cell_to_move_to : Cell = RoomManager.get_current_room().get_cell(performingEntity.myCell.roomLocation.x + direction[0], performingEntity.myCell.roomLocation.y + direction[1])

	if cell_to_move_to != null && cell_to_move_to.check_can_entity_enter(performingEntity):
		return true
		
	return false
	
func do_action() -> void:
	
	var cell_to_move_to : Cell = RoomManager.get_current_room().get_cell(performingEntity.myCell.roomLocation.x + direction[0], performingEntity.myCell.roomLocation.y + direction[1])
	print("Moving from ", performingEntity.myCell.roomLocation, " to ", cell_to_move_to.roomLocation, " with direction vector ", direction)
	performingEntity.myCell.entity_exited.emit()
	performingEntity.reparent(cell_to_move_to, false)
	performingEntity.myCell.occupyingEntity = null
	performingEntity.myCell = cell_to_move_to
	performingEntity.myCell.occupyingEntity = performingEntity
	direction = Vector2.ZERO
	
