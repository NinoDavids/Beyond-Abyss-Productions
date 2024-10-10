extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.name.contains("Object"):
		print_debug("dropped off object")

func _on_body_exited(body: Node3D) -> void:
	if body.name.contains("Object"):
		print_debug("picked up object")
