class_name Canon
extends BasePuzzlePiece

@export var projectile: PackedScene
@export var projectile_distance: int = 1
@export var start_shooting: bool = false

@onready var target_direction: Marker3D = $TargetDirection
@onready var spawn_point: Marker3D = %SpawnPoint
@onready var audio_player: AudioStreamPlayer3D = %AudioPlayer
@onready var timer: Timer = $Timer
@onready var projectile_receiver: Area3D = $ProjectileReceiver


@onready var canon_boom_sfx: AudioStream = preload("res://src/world/PuzzlePieces/Canons/sfx/Canon Boom 2.wav") as AudioStream
@export var cannon_model: CannonModel

func _ready() -> void:
	assert(spawn_point != null)
	assert(projectile != null)
	assert(audio_player != null)
	if start_shooting:
		cannon_model.start_charge_animation()

func shoot_projectile() -> void:
	var current_projectile: CanonProjectile = projectile.instantiate() as CanonProjectile
	current_projectile.direction = spawn_point.global_position.direction_to(target_direction.global_position)
	current_projectile.start_position = spawn_point.global_position
	current_projectile.end_position = spawn_point.global_position + (current_projectile.direction * (projectile_distance * 3))
	spawn_point.add_child(current_projectile)
	audio_player.play()

func _on_cannon_up_model_shoot() -> void:
	projectile_receiver.monitoring = false
	timer.start()
	shoot_projectile()
	play_boom_sfx()

func play_boom_sfx() -> void:
	audio_player.stream = canon_boom_sfx
	audio_player.pitch_scale = randf_range(0.9, 1.1)
	audio_player.volume_db = -10
	audio_player.play()

func _on_projectile_receiver_body_entered(body: Node3D) -> void:
	if body is CanonProjectile:
		body.absorb()
		cannon_model.start_charge_animation()


func _on_timer_timeout() -> void:
	projectile_receiver.monitoring = true
