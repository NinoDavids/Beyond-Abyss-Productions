extends Hookable
class_name AnimationHookable

signal is_completed()

@export var animation_player: AnimationPlayer
@export var animation_name: StringName

func _ready() -> void:
	animation_player.play(animation_name)
	animation_player.pause()
	
func reel_in() -> void:
	animation_player.play(animation_name)

func pause_animation() -> void:
	animation_player.pause()

func animation_finished() -> void:
	is_completed.emit()
