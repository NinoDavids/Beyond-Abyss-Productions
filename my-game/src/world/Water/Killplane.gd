extends CollisionShape3D


func _on_body_entered(player: CharacterBody3D) -> void:
	player.respawn()
	if player.find_child("Hitbox"):
		var hitbox: Hitbox = player.find_child("Hitbox") as Hitbox
		hitbox.take_damage(3)
