class_name SkeletonEntity extends PickupItem

var alive : bool = false
var buried : bool = false
var move : SkeletonMove
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move = SkeletonMove.new()
	move.performingEntity = self
	RoomManager.dungeon_come_to_life.connect(toggle_skeleton_alive)
	RoomManager.player_took_action.connect(choose_direction_and_move)
	RoomManager.dungeon_go_to_sleep.connect(toggle_skeleton_alive)

func toggle_skeleton_alive() -> void: 
	if(myCell.myRoom.room_index == RoomManager.current_room.room_index):
		if(!buried):
			alive = RoomManager.dungeonAlive
			if(alive):
				$ActiveSkeletonSprite.visible = true
				$InnertSkeletonSprite.visible = false
			else:
				$ActiveSkeletonSprite.visible = false
				$InnertSkeletonSprite.visible = true



func choose_direction_and_move() -> void: 
	if(myCell.myRoom.room_index == RoomManager.current_room.room_index):	
		if(alive && !buried):
			if(RoomManager.last_player_movement_direction.x != 0) :
				var potential_cell_left = RoomManager.get_current_room().get_cell(myCell.roomLocation.x - 1, myCell.roomLocation.y)
				var potential_cell_right = RoomManager.get_current_room().get_cell(myCell.roomLocation.x + 1, myCell.roomLocation.y)
				
				move.direction =  Vector2i(-1,0) if potential_cell_left.roomLocation.x - RoomManager.player_location.x < potential_cell_right.roomLocation.x - RoomManager.player_location.x else Vector2i(1,0)
				var cell_to_move_to = RoomManager.get_current_room().get_cell(myCell.roomLocation.x + move.direction.x, myCell.roomLocation.y + move.direction.y)
				if(cell_to_move_to == null || !cell_to_move_to.check_can_entity_enter(self)):
					move.direction = Vector2i(0,0)
					
			else: 
				var potential_cell_up = RoomManager.get_current_room().get_cell(myCell.roomLocation.x, myCell.roomLocation.y - 1)
				var potential_cell_down = RoomManager.get_current_room().get_cell(myCell.roomLocation.x, myCell.roomLocation.y + 1)
				move.direction =  Vector2i(0,1) if potential_cell_up.roomLocation.y - RoomManager.player_location.y < potential_cell_down.roomLocation.y - RoomManager.player_location.y else Vector2i(0, -1)
				var cell_to_move_to = RoomManager.get_current_room().get_cell(myCell.roomLocation.x + move.direction.x, myCell.roomLocation.y + move.direction.y)
				if(cell_to_move_to == null || !cell_to_move_to.check_can_entity_enter(self)):
					move.direction = Vector2i(0,0)
				if(move.can_do_action()):
					move.do_action()
