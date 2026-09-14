class_name PlayerMove extends Action

var direction : Vector2 = Vector2.ZERO

func can_do_action() -> bool:
	var cell_to_move_to : Cell = RoomManager.get_current_room().get_cell(performingEntity.myCell.x + direction.x, performingEntity.myCell.y + direction.y)
	
	if cell_to_move_to != null && cell_to_move_to.check_can_entity_enter(performingEntity):
		return true
		
	return false
	
func do_action() -> void:
	var cell_to_move_to : Cell = RoomManager.get_current_room().get_cell(performingEntity.myCell.x + direction.x, performingEntity.myCell.y + direction.y)
	performingEntity.reparent(cell_to_move_to, false)
	performingEntity.myCell.occupyingEntity = null
	performingEntity.myCell = cell_to_move_to
	direction = Vector2.ZERO
	
