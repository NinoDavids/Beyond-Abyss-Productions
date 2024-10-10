extends RigidBody3D

@export var float_force := 1.0
@export var water_drag := 0.05
@export var water_angular_drag := 0.05

@onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var water = get_node('/root/World/Water/WaterPlane')

var submerged := false

const water_height := -2.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	print(water)
	submerged = false
	var depth = water.get_height(global_position) - global_position.y
	if depth > 0:
		submerged = true
		apply_central_force(Vector3.UP * float_force * 100 * depth)
		
func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if submerged:
		state.linear_velocity  *= 1 - water_drag
