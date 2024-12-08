extends Area3D
class_name LegacyCheckpoint
## [Checkpoint]

var player: Player
var player_original_transform: Transform3D
var is_active: bool = false

func _ready() -> void:
	EventManager.player_respawned.connect(handle_player_respawn)
	EventManager.checkpoint_touched.connect(handle_new_checkpoint)

## When [signal EventManager.checkpoint_touched] is emitted, this function gets called.
## It checks if parameter is itself.
## If yes, then it sets [member Checkpoint.is_active] to [code]true[/code].
## If no, then it checks if this checkpoint was previously active.
## If it was, then it removes the player from the collisionmask preventing to be active ever again.
func handle_new_checkpoint(new_checkpoint: LegacyCheckpoint) -> void:
	if new_checkpoint != self:
		if is_active:
			set_collision_mask_value(2, false)
		is_active = false
	else:
		is_active = true

func handle_player_respawn() -> void:
	if is_active:
		player.transform = player_original_transform
		## Sets the player to look forward
		player.head.rotation = Vector3.ZERO
		player.rotation = Vector3.ZERO

		EventManager.checkpoint_respawn.emit(self)

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		player = body
		player_original_transform = player.global_transform
		EventManager.checkpoint_touched.emit(self)
