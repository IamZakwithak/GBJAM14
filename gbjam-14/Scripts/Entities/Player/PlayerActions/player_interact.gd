class_name PlayerInteract extends PlayerAction

func can_do_action() -> bool:
	print("should we do this?")
	if performingPlayer.myCell.pickupableEntity != null && performingPlayer.inventory_item == null : 
		return true
	return performingPlayer.myCell.overlappedEntity.interactable

func do_action() -> void:
	print("let's do this!")
	if(performingPlayer.myCell.diggable):
		print("oh we diggin")
		dig_hole()
		return
	if(performingPlayer.inventory_item != null) : 
		print("oh we puttin our shiz down")
		put_down_item()
		return
	if performingPlayer.myCell.pickupableEntity != null:
		performingPlayer.myCell.pickupableEntity.do_interaction()
	else :
		var interactableEntityRef = performingPlayer.myCell.overlappedEntity as InteractableEntity
		interactableEntityRef.do_interaction()
	
func dig_hole() -> void: 
	performingPlayer.myCell.diggable = false
	RoomManager.player_took_action.emit()
	

func put_down_item() -> void: 
	performingPlayer.myCell.pickupableEntity = performingPlayer.inventory_item
	performingPlayer.inventory_item.reparent(performingPlayer.myCell.pickupableEntity)
	performingPlayer.inventory_item.visible = true
	performingPlayer.inventory_item.drop_item_func()
	performingPlayer.inventory_item = null
	RoomManager.player_took_action.emit()
	
