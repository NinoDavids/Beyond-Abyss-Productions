extends Area3D

@export var next_level: PackedScene

func _on_body_entered(body: Node3D) -> void:
	if body is Player and next_level != null:
		get_tree().change_scene_to_packed(next_level)
