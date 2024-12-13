class_name Portal
extends Node3D

@export var puzzle: Puzzle
@export var is_front_direction: bool = true 
var is_active: bool = true
@onready var audio_player: AudioStreamPlayer3D = $AudioPlayer
@onready var bubble_enter_sfx: AudioStream = preload("res://src/world/Object/Portal/sfx/Portal SFX.wav") as AudioStream
@onready var portal_enter_effect: CPUParticles3D = $PortalEnterEffect
@onready var portal: Node3D = $Node3D/PortalShaderBack

func _ready() -> void:
	portal.is_front_direction = is_front_direction

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CanonProjectile and is_active and puzzle:
		is_active = false
		puzzle.next_water_spout()
		play_sfx(bubble_enter_sfx)
		body.queue_free()
		portal_enter_effect.emitting = true

func play_sfx(sfx: AudioStream) -> void:
	audio_player.stream = sfx
	audio_player.pitch_scale = randf_range(0.900, 1.200)
	audio_player.play()
	await audio_player.finished
	
