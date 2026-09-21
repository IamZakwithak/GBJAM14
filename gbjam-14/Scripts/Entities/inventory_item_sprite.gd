extends Sprite2D

func _process(_delta:float) -> void:
	var player_ref = get_tree().get_first_node_in_group("Player")
	if player_ref.inventory_item is PickupItemGem:
		self.frame = 130
	elif player_ref.inventory_item is SkeletonEntity:
		self.frame = 128
	elif player_ref.inventory_item is PickupItemTennisBall:
		self.frame = 129
	else:
		self.frame = 127
