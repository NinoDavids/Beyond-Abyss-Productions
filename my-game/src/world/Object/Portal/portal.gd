class_name Portal
extends Node3D

@export var puzzle: Puzzle
var is_active: bool = true
@onready var audio_player: AudioStreamPlayer3D = $AudioPlayer
@onready var bubble_enter_sfx: AudioStream = preload("res://src/world/Object/Portal/sfx/Portal SFX.wav") as AudioStream

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CanonProjectile and is_active and puzzle:
		is_active = false
		puzzle.next_water_spout()
		play_sfx(bubble_enter_sfx)
		body.queue_free()

func play_sfx(sfx: AudioStream) -> void:
	audio_player.stream = sfx
	audio_player.pitch_scale = randf_range(0.900, 1.200)
	audio_player.play()
	await audio_player.finished
	
