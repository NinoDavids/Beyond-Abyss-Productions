class_name WaterSpout
extends BasePuzzlePiece

@export var projectile: PackedScene
@onready var shoot_timer: Timer = $ShootTimer
@export var shot_cooldown: float = 5.0
@export var projectile_distance: int = 3.0

@onready var spawn_point: Marker3D = $WaterSpoutModel/SpawnPoint
@onready var target_direction: Marker3D = $WaterSpoutModel/TargetDirection
@onready var audio_player: AudioStreamPlayer3D = $AudioPlayer


func _ready() -> void:
	shoot_timer.wait_time = shot_cooldown

func shoot_projectile() -> void:
	var current_projectile: CanonProjectile = projectile.instantiate() as CanonProjectile
	current_projectile.direction = spawn_point.global_position.direction_to(target_direction.global_position)
	current_projectile.start_position = spawn_point.global_position
	current_projectile.end_position = spawn_point.global_position + (current_projectile.direction * (projectile_distance * 3))
	spawn_point.add_child(current_projectile)
	audio_player.play()


func _on_shoot_timer_timeout() -> void:
	shoot_projectile()
