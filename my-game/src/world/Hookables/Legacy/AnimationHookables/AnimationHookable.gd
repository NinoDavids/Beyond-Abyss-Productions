extends LegacyHookable
class_name AnimationHookable

@export var animation_player: AnimationPlayer
@export var animation_name: StringName

var is_finished: bool = false

func _ready() -> void:
	animation_player.play(animation_name)
	animation_player.pause()

func reel_in() -> void:
	if !is_finished:
		animation_player.play(animation_name)

func pause_animation() -> void:
	animation_player.pause()

func animation_finished() -> void:
	EventManager.anim_hookable_finished.emit()
	is_finished = true
