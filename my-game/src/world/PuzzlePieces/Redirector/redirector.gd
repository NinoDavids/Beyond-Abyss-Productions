class_name Redirector
extends Area3D


@onready var audio_player: AudioStreamPlayer3D = $AudioPlayer
@onready var origin_marker: Marker3D = $OriginMarker
@onready var direction_marker: Marker3D = $DirectionMarker

@export var push_distance: float = 1.5


func _on_body_entered(body: Node3D) -> void:
	if body is CanonProjectile:
		audio_player.play()
		shoot_projectile(body)

func shoot_projectile(projectile: CanonProjectile) -> void:
	projectile.start_position = origin_marker.global_position
	var dir: Vector3 = origin_marker.global_position.direction_to(direction_marker.global_position)

	var tween: Tween = get_tree().create_tween()
	tween.tween_property(projectile, "direction", dir, 0.1)
	projectile.end_position = origin_marker.global_position + (projectile.direction * (push_distance * 3))
	await tween.finished
	projectile.direction = dir
	projectile.jump = projectile.doGravity
