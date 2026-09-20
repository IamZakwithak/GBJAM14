class_name PickupItem extends InteractableEntity


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func do_interaction() -> void:
	print("pick up your stuff")
	if myCell.occupyingEntity is Player : 
		var tempPlayer = myCell.occupyingEntity as Player
		tempPlayer.inventory_item = self 
		self.reparent(tempPlayer.inventoryParent)
		self.visible = false
		myCell.pickupableEntity = null
		interactable = false
		pickupable = false
		
func drop_item_func() -> void: 
	pass
