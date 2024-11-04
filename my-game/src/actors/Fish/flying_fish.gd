class_name Flying_fish
extends RigidBody3D




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


	

func _physics_process(_delta: float) -> void:
	look_at(global_position + linear_velocity, Vector3.UP)
	
	if global_position.y < -1:
		queue_free()
	
func apply_force_direction(direction: Vector3, player: Player, plane: MeshInstance3D, height: int) -> void:
	var random: RandomNumberGenerator = RandomNumberGenerator.new()
	random.randomize()
	
	if random.randi_range(0,10) == 1:
		linear_velocity = Vector3(0,0,0)
		linear_velocity = calculateLaunchVelocity(player, height, plane)
	else:
		linear_velocity = Vector3(0,0,0)
		linear_velocity = direction
	


func calculateLaunchVelocity(player: Player, height: float, plane:MeshInstance3D)-> Vector3:
	
	
	var displacementY: float = player.global_position.y - global_position.y + height/2.5
	var displacementXZ: Vector3 = Vector3(player.global_position.x - (plane.global_position.x + position.x), 0, player.global_position.z - (plane.global_position.z + position.z))
	var gravity:float = -9.8
	var time: float = sqrt(-2*height/gravity) + sqrt(2*(displacementY -height)/gravity)
	var velocityY: Vector3 = Vector3.UP * sqrt(-2 * gravity * height)
	var velocityXZ: Vector3 = displacementXZ / time


	return velocityXZ + velocityY
