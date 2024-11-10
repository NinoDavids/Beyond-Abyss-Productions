extends Node

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		if body.find_child("Hitbox"):
			var hitbox: Hitbox = body.find_child("Hitbox") as Hitbox
			hitbox.take_damage(3)
