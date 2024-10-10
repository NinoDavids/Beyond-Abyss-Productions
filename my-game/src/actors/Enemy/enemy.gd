extends CharacterBody3D

@onready var navAgent = $NavigationAgent3D

func _physics_process(delta: float) -> void:
	var location = global_transform.origin
	var nextLocation = navAgent.get_next_path_position()
	var newVelocity = (nextLocation - location).normalized() * 3

	velocity = newVelocity
	move_and_slide()

func update_target_location(target):
	navAgent.set_target_position(target)
