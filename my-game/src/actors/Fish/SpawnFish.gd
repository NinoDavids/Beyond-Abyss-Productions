extends MeshInstance3D

var mesh_data: MeshDataTool = MeshDataTool.new()

@onready var fish: RigidBody3D = $RigidBody3D
@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		timer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func _on_timer_timeout() -> void:
	var plane: PlaneMesh = self.mesh

	var rand = RandomNumberGenerator.new()


	rand.randomize()

	var random_x = rand.randf_range(-plane.size.x / 2, plane.size.x / 2)
	var random_z =  rand.randf_range(-plane.size.y / 2, plane.size.y / 2)

	var new_fish: RigidBody3D = fish.duplicate()
	new_fish.position = Vector3(random_x, 0, random_z)
	
	
	print(random_x)
	if (random_z < 0):
		new_fish.apply_impulse(Vector3(-5,20,0))
	else:
		new_fish.apply_impulse(Vector3(5,20,0))
	add_child(new_fish)
	
	
	
