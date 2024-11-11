extends Node3D

@export_group("Checkpoint Handling")

@export var float_force: float = 1.0
@export var water_drag: float = 0.05
@export var water_angular_drag: float = 0.05
@export var checkpoint: Checkpoint
@export var object: RigidBody3D

@onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
#@onready var checkpoint_handler: CheckpointHandler = $CheckpointHandler

var water: Water 
var water_height: float
var submerged := false
var is_floating := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	object.lock_rotation = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if is_floating:
		floating()

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if submerged:
		state.linear_velocity  *= 1 - water_drag
		state.angular_velocity *= 1 - water_angular_drag


func _on_body_entered(body: Node) -> void:
	print_debug('hi')
	if body == Water:
		is_floating = true


func floating() -> void:
	submerged = false
	water_height = water.water_plane.global_position.y
	var depth = water.water_plane.get_height(global_position) - global_position.y
	if depth > 0:
		submerged = true
		object.apply_central_force(Vector3.UP * float_force * gravity * depth)

func _on_body_exited(body: Node) -> void:
	if body == Water:
		is_floating = false

func _on_bobber_body_entered(body: Node) -> void:
	print_debug(body)
	if body == Water:
		is_floating = true
