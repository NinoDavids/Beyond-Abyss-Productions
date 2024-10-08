extends RigidBody3D
class_name Bobber

var player: Player

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel_hook"):
		queue_free()

func set_hooked(pos: Vector3) -> void:
	global_position = pos
	
