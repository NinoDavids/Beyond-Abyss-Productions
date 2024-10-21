extends RigidBody3D

@export var float_force := 1.0
@export var water_drag := 0.05
@export var water_angular_drag := 0.05

@onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var water: WaterPlane

var submerged := false

@onready var water_height := water.global_position.y
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.lock_rotation = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	submerged = false
	water_height = water.global_position.y
	var depth = water.get_height(global_position) - global_position.y
	if depth > 0:
		submerged = true
		apply_central_force(Vector3.UP * float_force * gravity * depth)

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if submerged:
		state.linear_velocity  *= 1 - water_drag
		state.angular_velocity *= 1 - water_angular_drag
