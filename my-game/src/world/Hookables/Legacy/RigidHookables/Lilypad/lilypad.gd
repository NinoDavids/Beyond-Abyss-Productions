extends RigidBody3D

class_name LilypadDragable

@export var float_force: float = 1.0
@export var water_drag: float = 0.05
@export var water_angular_drag: float = 0.05
@export var hookable: RigidHookable
@onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var water: Water
@export_group("Checkpoint Handling")
@export var checkpoint: Checkpoint
#@onready var water_height := water.water_plane.global_position.y
var water_height: float

var startValue: Vector3
var submerged: bool = false
var playerOnThisLilly: bool
var timer: float
#const water_height := -2.0

func _ready() -> void:
	self.lock_rotation = true
	startValue = position

func _physics_process(delta: float) -> void:
	if water != null and water.water_plane != null:
		water_height = water.water_plane.global_position.y
	if timer > 0:
		if !playerOnThisLilly:
			timer -= delta
			print_debug(timer)
	else:
		if hookable and !hookable.canMove:
			print_debug(hookable.canMove)
			hookable.canMove = true

	submerged = false
	if water != null and water.water_plane != null:
		water_height = water.water_plane.global_position.y
		var depth: float = water.water_plane.get_height(global_position) - global_position.y
		if depth > 0:
			submerged = true
			apply_central_force(Vector3.UP * float_force * gravity * depth)

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if submerged:
		state.linear_velocity *= 1 - water_drag
	state.angular_velocity *= 1 - water_angular_drag

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		playerOnThisLilly = true
		hookable.canMove = false
		timer = 1.0

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player:
		playerOnThisLilly = false