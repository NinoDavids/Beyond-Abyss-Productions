class_name ProjectileFinder
extends Area3D

signal projectile_found(finder: ProjectileFinder)

@onready var start_point: Marker3D = $StartPoint
@onready var aim: Marker3D = $Aim
@export var is_redirector: bool = false
@export var distance: int = 1
var is_active: bool = true
var projectile: CanonProjectile

func _on_body_entered(body: Node3D) -> void:
	if body is CanonProjectile and is_active:
		projectile = body
		projectile_found.emit(self)
		if is_redirector:
			shoot_projectile(distance)

func shoot_projectile(push_distance: int) -> void:
	projectile.start_position = start_point.global_position
	var tween: Tween = get_tree().create_tween()
	var dir: Vector3 = start_point.global_position.direction_to(aim.global_position)
	tween.tween_property(projectile, "direction", dir, .25)
	#projectile.direction = start_point.global_position.direction_to(aim.global_position)
	projectile.end_position = start_point.global_position + (projectile.direction * (push_distance * 3))
	projectile = null
