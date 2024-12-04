class_name CanonProjectile
extends CharacterBody3D

@export var speed: float = 1.0
var direction: Vector3
var start_position: Vector3
var end_position: Vector3

func _physics_process(_delta: float) -> void:
	if direction == null: return
	
	if check_distance_reached():
		queue_free()
	
	velocity = direction * speed
	#look_at(global_position + direction)
	move_and_slide()

func check_distance_reached() -> bool:
	# Total distance from start to end
	var total_distance: float = start_position.distance_to(end_position)
	# Distance traveled by the projectile
	var traveled_distance: float = start_position.distance_to(global_position)
	# Check if we've passed the end position
	return traveled_distance > total_distance
