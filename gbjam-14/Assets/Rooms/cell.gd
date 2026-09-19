class_name Cell extends Node2D

signal entity_enter(entering_entity: Entity)
signal entity_exited(exiting_entity: Entity)

var occupyingEntity : Entity #Entity that is currently in this cell 
var pickupableEntity : PickupItem
var overlappedEntity : Entity
var roomLocation : Vector2 #This is the x,y indexes for the cell grid spaces, so every cell knows where they are 
@export var diggable : bool = false 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_child_count() > 0 :
		var childEntity = get_child(0) as Entity
		if(childEntity.pickupable):
			pickupableEntity = childEntity
			pickupableEntity.myCell = self
		else:
			occupyingEntity = childEntity
			occupyingEntity.myCell = self
	
	entity_exited.connect(reset_overlappable_entity)
	#if occupyingEntity != null: 
	#	occupyingEntity.myCell = self

	
func check_can_entity_enter(entering_entity : Entity) -> bool:
	if occupyingEntity == null || occupyingEntity.can_entity_enter(entering_entity):
		entity_entered(entering_entity)
		return true
	return false
	
func entity_entered( entering_entity : Entity) -> void:
	print("entity entered!")
	occupyingEntity = entering_entity
	#occupyingEntity.myCell = self
	entity_enter.emit(entering_entity)

func entity_exit() -> void: 
	if(occupyingEntity != null):
		var entity_exiting : Entity = occupyingEntity
		entity_exited.emit(occupyingEntity)

func reset_overlappable_entity() -> void: 
	if overlappedEntity != null:
		occupyingEntity = overlappedEntity
		overlappedEntity = null
		


	
	
