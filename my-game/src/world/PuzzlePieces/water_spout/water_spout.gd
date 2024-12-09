class_name WaterSpout
extends BasePuzzlePiece

@export var projectile: PackedScene
@onready var shoot_timer: Timer = $ShootTimer
@export var shot_cooldown: float = 5.0
@export var projectile_distance: float = 1.5
@export var model: WaterSpoutModel
@export var active: bool = false :
	set(value):
		active = value
		set_model(value)

@onready var spawn_point: Marker3D = $WaterSpoutModel/SpawnPoint
@onready var target_direction: Marker3D = $WaterSpoutModel/TargetDirection
@onready var audio_player: AudioStreamPlayer3D = $AudioPlayer


func _ready() -> void:
	shoot_timer.wait_time = shot_cooldown

func shoot_projectile() -> void:
	var current_projectile: CanonProjectile = projectile.instantiate() as CanonProjectile
	current_projectile.direction = target_direction.global_position.direction_to(spawn_point.global_position)
	current_projectile.start_position = spawn_point.global_position
	current_projectile.end_position = spawn_point.global_position + (current_projectile.direction * (projectile_distance * 3))
	spawn_point.add_child(current_projectile)
	audio_player.play()

func _on_shoot_timer_timeout() -> void:
	if active:
		shoot_projectile()

func set_model(enable: bool) -> void:
	if enable:
		model.animation_player.play("ChangeState")
		model.audio_player.play()
	else:
		model.animation_player.play_backwards("ChangeState")
		model.audio_player.play()
