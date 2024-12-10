extends Node
## [EventManager] handles all signals.


@warning_ignore("unused_signal")
signal player_damaged()
@warning_ignore("unused_signal")
signal player_regenerating()
@warning_ignore("unused_signal")
signal cancel_bobber()
@warning_ignore("unused_signal")
signal anim_hookable_finished()
@warning_ignore("unused_signal")
signal player_died()
@warning_ignore("unused_signal")
signal player_respawned()
@warning_ignore("unused_signal")
signal checkpoint_touched(point: LegacyCheckpoint)
@warning_ignore("unused_signal")
signal checkpoint_respawn(point: LegacyCheckpoint)
@warning_ignore("unused_signal")
signal disable_fishingrod()
@warning_ignore("unused_signal")
signal enable_fishingrod()

func _ready() -> void:
	cancel_bobber.connect(handle_cancel_bobber)

## Need to correctly interchange these signals. Will take a bit of time so this is a current fix.
## TODO: Replace anim_hookable_finished to cancel_bobber
func handle_cancel_bobber() -> void:
	anim_hookable_finished.emit()
