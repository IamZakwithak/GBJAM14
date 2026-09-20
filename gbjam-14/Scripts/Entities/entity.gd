class_name Entity extends Node2D

var myCell : Cell
var cancelMove : bool 

@export var interactable : bool = false
@export var pickupable : bool = false
@export var diggable : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

	
func can_entity_enter(entering_entity: Entity) -> bool:
	return true;
	
func take_turn() -> void: 
	pass
