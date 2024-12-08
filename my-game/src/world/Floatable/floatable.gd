extends RigidBody3D
class_name Floatable

@export_group("Checkpoint Handling")

@export var float_force: float = 1.0
@export var water_drag: float = 0.05
@export var water_angular_drag: float = 0.05
@export var checkpoint: LegacyCheckpoint

@onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
#@onready var checkpoint_handler: CheckpointHandler = $CheckpointHandler

var water: Water
var water_height: float
var submerged: bool = false
var is_floating: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lock_rotation = true

func _physics_process(_delta: float) -> void:
	if is_floating:
		floating()

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if submerged:
		state.linear_velocity  *= 1 - water_drag
		state.angular_velocity *= 1 - water_angular_drag

func floating() -> void:
	submerged = false
	water_height = water.water_plane.global_position.y
	var depth: float = water.water_plane.get_height(global_position) - global_position.y
	if depth > 0:
		submerged = true
		apply_central_force(Vector3.UP * float_force * gravity * depth)
