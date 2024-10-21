extends RigidBody3D

class_name Lilypad

@export var float_force := 1.0
@export var water_drag := 0.05
@export var water_angular_drag := 0.05

@onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var water = $".."

var startValue: Vector3

var submerged := false

const water_height := -2.0

func _ready() -> void:
	self.lock_rotation = true
	startValue = position
	
func resetLilypads() -> void:
	transform.origin = startValue
	print_debug(startValue)

func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("quitEditor")):
		resetLilypads()

func _physics_process(delta: float) -> void:
	submerged = false
	var depth = water.water_plane.get_height(global_position) - global_position.y
	if depth > 0:
		submerged = true
		apply_central_force(Vector3.UP * float_force * 100 * depth)

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if submerged:
		state.linear_velocity *= 1 - water_drag
