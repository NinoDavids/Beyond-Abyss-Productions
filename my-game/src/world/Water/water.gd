@tool
extends Area3D

class_name Water

@export var plane_size: Vector2 = Vector2(1,1)
@export var animation_player: AnimationPlayer
var collision_size: Vector3

@onready var water_plane: MeshInstance3D = $WaterPlane
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

func _process(_delta: float) -> void:
	collision_size = Vector3(plane_size.x, 0.1, plane_size.y)
	if water_plane and collision_shape_3d:
		if water_plane.mesh.size != plane_size:
			water_plane.mesh.size = plane_size
		if collision_shape_3d.shape.size != collision_size:
			collision_shape_3d.shape.size = collision_size

func player_hits_water(player: CharacterBody3D) -> void:
	if player.find_child("Hitbox"):
		var hitbox: Hitbox = player.find_child("Hitbox") as Hitbox
		hitbox.take_damage(3)

func _on_body_entered(body: CharacterBody3D) -> void:
	body.respawn()
	if body is Player:
		print ('player in water')
	if body.is_class('Player'):
		player_hits_water(body)

func raise_water(height: float) -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(water_plane, "global_position", Vector3(water_plane.global_position.x, height, water_plane.global_position.z), 5)
