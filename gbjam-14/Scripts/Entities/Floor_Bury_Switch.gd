extends Entity

@export var connected_cell: int
@onready var entity_to_unlock = self.get_parent().get_parent().grid[connected_cell -1].get_child(0)
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var mycell = get_parent()
@onready var player_ref = get_tree().get_first_node_in_group("Player")

func _ready():
	set_entity_to_unlock.call_deferred()

func set_entity_to_unlock():
	myCell.entity_enter.connect(unlock_entity)
	
func unlock_entity(entering_entity: Entity) -> void:
	print("hello")
	if entity_to_unlock.is_locked and player_ref.inventory_item is PickupItemGem:
		entity_to_unlock.is_locked = false
		sprite_2d.frame = 13
		player_ref.inventory_item.queue_free()
		player_ref.inventory_item = null
		RoomManager.dungeonAlive = false
		entity_to_unlock.get_child(0).frame = 2
	else:
		pass
		
	
