extends Entity

@export var connected_cell: int
@onready var entity_to_unlock = self.get_parent().get_parent().grid[connected_cell -1].get_child(0)

@onready var mycell = get_parent()
@onready var player_ref = get_tree().get_first_node_in_group("Player")

func _ready():
	set_entity_to_unlock.call_deferred()

func set_entity_to_unlock():
	mycell.entity_enter.connect(unlock_entity)

func unlock_entity(entering_entity: Entity) -> void:
	if entity_to_unlock.is_locked and player_ref.inventory_item is PickupItemTennisBall:
		entity_to_unlock.is_locked = false
		get_tree().change_scene_to_file("res://Scenes/YouWinScene.tscn")
	else:
		print("no tennis ball")
		pass
