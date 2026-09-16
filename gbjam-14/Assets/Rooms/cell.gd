class_name Cell extends Node2D

signal entity_enter(entering_entity: Entity)
signal entity_exited(exiting_entity: Entity)

var occupyingEntity : Entity #Entity that is currently in this cell 
var roomLocation : Vector2 #This is the x,y indexes for the cell grid spaces, so every cell knows where they are 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func check_can_entity_enter(entering_entity : Entity) -> bool:
	if occupyingEntity == null || occupyingEntity.can_entity_enter(entering_entity):
		return true
	return false
	
func entity_entered( entering_entity : Entity) -> void:
	occupyingEntity = entering_entity
	occupyingEntity.myCell = self
	entity_enter.emit(entering_entity)

func entity_exit() -> void: 
	if(occupyingEntity != null):
		var entity_exiting : Entity = occupyingEntity
		entity_exited.emit(occupyingEntity)
		


	
	
