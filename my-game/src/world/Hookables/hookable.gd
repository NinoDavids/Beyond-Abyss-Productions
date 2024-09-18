extends Area3D
class_name Hookable

var is_hooked: bool = false

func reel_in() -> void:
	print("Reeling in...")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reel_hook") and is_hooked:
		reel_in()

func _on_body_entered(body: Node3D) -> void:
	if body is Bobber:
		is_hooked = true
		body.set_hooked(global_position)
		body.tree_exited.connect(reel_in)

func remove_bobber() -> void:
	is_hooked = false
