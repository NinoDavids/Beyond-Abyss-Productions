class_name SpringPuzzlePiece
extends BasePuzzlePiece

@export var push_distance: int = 3

@onready var spring: SpringModel = $spring
@onready var timer: Timer = $Timer

var projectile: CanonProjectile
var triggered_projectile_finder: ProjectileFinder
var projectile_finders: Array[ProjectileFinder] = []
@onready var audio_player: AudioStreamPlayer3D = $AudioPlayer

func _ready() -> void:
	for child: Node in get_children():
		if child is ProjectileFinder:
			projectile_finders.append(child)
			child.projectile_found.connect(_handle_projectile_finder_projectile_found)


func _on_spring_spring_went_off() -> void:
	triggered_projectile_finder.shoot_projectile(push_distance + 1)
	play_sfx()
	timer.start()

func _handle_projectile_finder_projectile_found(finder: ProjectileFinder) -> void:
	if not is_moving:
		triggered_projectile_finder = finder
		spring.rotation_degrees = triggered_projectile_finder.rotation_degrees
		spring.start_spring()
		toggle_projectile_finders(false)

func toggle_projectile_finders(active: bool) -> void:
	for finder: ProjectileFinder in projectile_finders:
		if finder != triggered_projectile_finder:
			finder.is_active = active

func _on_timer_timeout() -> void:
	toggle_projectile_finders(true)

func play_sfx() -> void:
	audio_player.pitch_scale = randf_range(0.900, 1.200)
	audio_player.play()
