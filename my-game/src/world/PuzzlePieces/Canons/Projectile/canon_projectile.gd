class_name CanonProjectile
extends CharacterBody3D

@export var speed: float = 1.0
@export var gravity: float = -9.8
var direction: Vector3
var start_position: Vector3
var end_position: Vector3
var vertical_velocity: float = 0.0
var jump: bool = false
@export var jump_velocity: float = 7.5
@export var doGravity: bool = true
@onready var thump_sfx: AudioStream = preload("res://src/world/PuzzlePieces/Canons/Projectile/sfx/thump.mp3") as AudioStream
@onready var pop_sfx: AudioStream = preload("res://src/world/PuzzlePieces/Canons/Projectile/sfx/pop.mp3") as AudioStream
@onready var audio_player: AudioStreamPlayer3D = $AudioPlayer

func _ready() -> void:
	start_position = global_position
	end_position = start_position + direction.normalized() * start_position.distance_to(end_position)

func _physics_process(_delta: float) -> void:
	if direction == null: return
	
	if(jump):
		vertical_velocity += jump_velocity
		jump = false
	else:
		vertical_velocity += gravity * _delta
	
	if check_distance_reached() and visible:
		play_sfx(pop_sfx)
	
	velocity = direction * speed
	
	if doGravity:
		velocity.y = vertical_velocity
	
  #look_at(global_position + direction)
	move_and_slide()

func check_distance_reached() -> bool:
	# Total distance from start to end
	var total_distance: float = start_position.distance_to(end_position)
	# Distance traveled by the projectile
	var traveled_distance: float = start_position.distance_to(global_position)
	# Check if we've passed the end position
	return traveled_distance > total_distance

func absorb() -> void:
	play_sfx(thump_sfx)

func play_sfx(sfx: AudioStream) -> void:
	visible = false
	audio_player.stream = sfx
	audio_player.pitch_scale = randf_range(0.8, 1.2)
	audio_player.play()
	velocity = Vector3.ZERO
	speed = 0
	await audio_player.finished
	queue_free()

func _on_area_3d_body_entered(_body: Node3D) -> void:
	play_sfx(pop_sfx)
