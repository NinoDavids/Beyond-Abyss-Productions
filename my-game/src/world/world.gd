extends Node3D

@onready var player = $Player

var time_elapsed: float

func _ready() -> void:
	get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)

func _process(delta):
	time_elapsed += delta
	var time_to_int = int(time_elapsed)

	if time_to_int >= 3:
		get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)
		time_elapsed = 0.0
