class_name ToPlayerHookable
extends BaseHookable

@onready var front_cast: RayCast3D = $FrontCast
@onready var back_cast: RayCast3D = $BackCast
@onready var left_cast: RayCast3D = $LeftCast
@onready var right_cast: RayCast3D = $RightCast

func _reel_in() -> void:
	var player: Player = bobber.player
	var direction: Vector3 = global_position.direction_to(player.global_position).round()
	direction.y = 0
	if direction.z == 1 and direction.x == 0 and not front_cast.is_colliding():
		_reel(direction)
	elif direction.z == -1 and direction.x == 0 and not back_cast.is_colliding():
		_reel(direction)
	elif direction.x == 1 and direction.z == 0 and  not left_cast.is_colliding():
		_reel(direction)
	elif direction.x == -1 and direction.z == 0 and  not right_cast.is_colliding():
		_reel(direction)
	
func _reel(direction: Vector3) -> void:
	parent.move(direction * 3)
