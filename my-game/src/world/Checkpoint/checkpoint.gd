extends Area3D
class_name Checkpoint

var player: Player
var player_original_transform: Transform3D
var is_active: bool = false

func _ready() -> void:
	EventManager.player_respawned.connect(handle_player_respawn)
	EventManager.checkpoint_touched.connect(handle_new_checkpoint)

func handle_new_checkpoint(new_checkpoint: Checkpoint) -> void:
	if new_checkpoint != self:
		is_active = false
	else: 
		is_active = true

func handle_player_respawn() -> void:
	if is_active:
		player.transform = player_original_transform
		EventManager.checkpoint_respawn.emit(self)

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		player = body
		player_original_transform = player.global_transform
		EventManager.checkpoint_touched.emit(self)
