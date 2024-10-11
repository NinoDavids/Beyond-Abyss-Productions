extends Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func player_hits_water(player: CharacterBody3D) -> void:
	player.respawn()

func _on_body_entered(body: CharacterBody3D) -> void:
	print('object in water')
	body.respawn()
	if body.is_class('Player'):
		print ('player in water')
		player_hits_water(body)
