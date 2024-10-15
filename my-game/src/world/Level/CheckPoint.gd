extends Marker3D
class_name CheckPoint

@export var is_active: bool = false
@export var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventManager.player_respawned.connect(handle_player_respawn)


func handle_player_respawn() -> void:
	player.global_position = global_position
