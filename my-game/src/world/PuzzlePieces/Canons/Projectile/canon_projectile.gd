class_name CanonProjectile
extends CharacterBody3D

@export var speed: float = 50.0
var direction: Vector3
var end_position: Vector3

func _physics_process(delta: float) -> void:
	if direction == null: return
	
	if check_distance_reached():
		queue_free()
	
	velocity = direction * speed
	move_and_slide()

func check_distance_reached() -> bool:
	if global_position > end_position:
		return true
	return false
