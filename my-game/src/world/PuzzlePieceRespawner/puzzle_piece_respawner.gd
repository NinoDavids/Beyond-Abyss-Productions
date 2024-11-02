extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.find_child("CheckpointHandler"):
		var handler: CheckpointHandler = body.find_child("CheckpointHandler") as CheckpointHandler
		handler.respawn_with_effect()
