class_name Flying_fish
extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


	

func _physics_process(delta: float) -> void:
	look_at(global_position + linear_velocity, Vector3.UP)
	
	if global_position.y < -1:
		queue_free()
	
func apply_force_direction(direction: Vector3, player: Player):
	var random = RandomNumberGenerator.new()
	random.randomize()
	
	if randi_range(0, 1) == 1:
		var target_position: Vector3 = player.global_position

		direction = (target_position + global_position).normalized()
		direction.x = -direction.x
		
		linear_velocity = -direction * 2 * global_position.distance_to(target_position)
		apply_impulse(Vector3(0,10,0))
		pass
	#apply_impulse(direction * 2 * global_position.distance_to(target_position))
		
	
	apply_impulse(direction)
