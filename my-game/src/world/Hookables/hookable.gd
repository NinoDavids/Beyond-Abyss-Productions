extends Area3D
class_name Hookable

var is_hooked: bool = false
var parent: RigidBody3D
var bobber: Bobber

func _ready() -> void:
	if get_parent() is RigidBody3D:
		parent = get_parent()

func reel_in() -> void:
	if parent:
		pull_parent()
	else:
		print("Reeling in just the hook")

func _physics_process(_delta: float) -> void:
	if bobber:
		place_bobber()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reel_hook") and is_hooked:
		reel_in()

func _on_body_entered(body: Node3D) -> void:
	if body is Bobber:
		is_hooked = true
		bobber = body
		place_bobber()
		body.tree_exited.connect(remove_bobber)

func place_bobber() -> void:
	bobber.set_hooked(global_position)

func remove_bobber() -> void:
	is_hooked = false
	bobber = null

func pull_parent() -> void:
	var direction: Vector3 = parent.global_transform.origin.direction_to(global_transform.origin)
	parent.apply_central_impulse(direction)
