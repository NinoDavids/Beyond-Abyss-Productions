class_name Checkpoint
extends Marker3D

var is_active: bool = false
var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player") as Player
	EventManager.player_respawned.connect(handle_player_respawned)

func handle_player_respawned() -> void:
	if is_active:
		player.global_position = global_position
		## Sets the player to look forward
		player.head.rotation = Vector3.ZERO
		player.rotation = Vector3.ZERO
