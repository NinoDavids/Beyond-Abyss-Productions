@tool
extends Area3D

@export var plane_size: Vector2 = Vector2(1,1)
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

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		print_debug("%s hit " %body.name, "%s." %name)
		player_hits_water(body)
		return
	
	if body.find_child("CheckpointHandler"):
		var handler: CheckpointHandler = body.find_child("CheckpointHandler") as CheckpointHandler
		if handler.anim_hookable == null:
			handler.load_object()
