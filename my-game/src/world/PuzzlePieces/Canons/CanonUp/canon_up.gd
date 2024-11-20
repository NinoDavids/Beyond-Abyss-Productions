class_name CanonUp
extends BasePuzzlePiece

@export var projectile: PackedScene
@export var projectile_distance: int = 1

@onready var spawn_point: Node3D = %SpawnPoint
@onready var audio_player: AudioStreamPlayer3D = %AudioPlayer

func _ready() -> void:
	assert(spawn_point != null)
	assert(projectile != null)
	assert(audio_player != null)

func shoot_projectile() -> void:
	var current_projectile: CanonProjectile = projectile.instantiate() as CanonProjectile
	current_projectile.direction = Vector3.UP
	current_projectile.end_position = spawn_point.global_position + (Vector3.UP * (projectile_distance * 3))
	add_child(current_projectile)
	current_projectile.global_position = spawn_point.global_position
	audio_player.play()

func _on_cannon_up_model_shoot() -> void:
	shoot_projectile()
