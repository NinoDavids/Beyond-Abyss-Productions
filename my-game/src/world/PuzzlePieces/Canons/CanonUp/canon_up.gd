class_name CanonUp
extends BasePuzzlePiece

@export var projectile: PackedScene
@export var projectile_distance: int = 1
@export var start_shooting: bool = false

@onready var spawn_point: Node3D = %SpawnPoint
@onready var audio_player: AudioStreamPlayer3D = %AudioPlayer

@onready var cannon_up_model: CannonUpModel = $CannonUpModel

func _ready() -> void:
	assert(spawn_point != null)
	assert(projectile != null)
	assert(audio_player != null)
	if start_shooting: cannon_up_model.start_charge_animation()

func shoot_projectile() -> void:
	var current_projectile: CanonProjectile = projectile.instantiate() as CanonProjectile
	current_projectile.direction = Vector3.UP
	current_projectile.end_position = spawn_point.global_position + (Vector3.UP * (projectile_distance * 3))
	spawn_point.add_child(current_projectile)
	audio_player.play()

func _on_cannon_up_model_shoot() -> void:
	shoot_projectile()


func _on_projectile_receiver_body_entered(body: Node3D) -> void:
	if body is CanonProjectile:
		body.queue_free()
		cannon_up_model.start_charge_animation()
