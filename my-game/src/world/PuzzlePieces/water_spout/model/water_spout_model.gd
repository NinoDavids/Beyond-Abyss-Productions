class_name WaterSpoutModel
extends Node3D

@export var animation_player: AnimationPlayer
@onready var audio_player: AudioStreamPlayer3D = $AudioPlayer


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	audio_player.stop()
