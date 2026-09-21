class_name PlayerInteract extends PlayerAction

func can_do_action() -> bool:
	if((performingPlayer.myCell.diggable && performingPlayer.inventory_item != null && performingPlayer.myCell.buriedEntity == null) 
	|| performingPlayer.myCell.diggable && performingPlayer.inventory_item == null && performingPlayer.myCell.buriedEntity != null):
		return true
	if performingPlayer.myCell.pickupableEntity != null && performingPlayer.inventory_item == null : 
		return true
	return false

func do_action() -> void:
	print("let's do this!")
	if performingPlayer.myCell.pickupableEntity != null:
		performingPlayer.myCell.pickupableEntity.do_interaction()
	elif(performingPlayer.myCell.diggable):
		print("oh we diggin")
		dig_hole()
		return
	else :
		var interactableEntityRef = performingPlayer.myCell.overlappedEntity as InteractableEntity
		interactableEntityRef.do_interaction()
	
func dig_hole() -> void: 
	if(performingPlayer.myCell.buriedEntity != null):
		performingPlayer.myCell.buriedEntity.do_interaction()
		performingPlayer.myCell.buriedEntity = null
		performingPlayer.myCell.buriedEntitySprite.free()
		RoomManager.player_took_action.emit()
		return
	performingPlayer.myCell.buriedEntity = performingPlayer.inventory_item
	performingPlayer.inventory_item.drop_item_func()
	if(performingPlayer.inventory_item is SkeletonEntity):
		var skeleton_ref = performingPlayer.inventory_item as SkeletonEntity
		skeleton_ref.buried = true
	performingPlayer.inventory_item.reparent(performingPlayer.myCell)
	performingPlayer.inventory_item = null
	var buriedDirt = RoomManager.buried_item_entity.instantiate()
	performingPlayer.myCell.add_child(buriedDirt)
	performingPlayer.myCell.buriedEntitySprite = buriedDirt
	RoomManager.player_took_action.emit()
	

func put_down_item() -> void: 
	performingPlayer.myCell.pickupableEntity = performingPlayer.inventory_item
	performingPlayer.inventory_item.reparent(performingPlayer.myCell.pickupableEntity)
	performingPlayer.inventory_item.visible = true
	performingPlayer.inventory_item.drop_item_func()
	if(performingPlayer.inventory_item is SkeletonEntity):
		var skeleton_ref = performingPlayer.inventory_item as SkeletonEntity
		skeleton_ref.buried = false
	performingPlayer.inventory_item = null
	RoomManager.player_took_action.emit()
	
