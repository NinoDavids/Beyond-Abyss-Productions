@tool
extends Area3D

class_name Water

@export var plane_size: Vector2 = Vector2(1,1)
@export var animation_player: AnimationPlayer
var collision_size: Vector3

@onready var water_plane: MeshInstance3D = $WaterPlane
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@export var respawnWater: bool = false : set = set_button
@export var player:Player
@export var shoot_height: float = 5.0
const FLYING_FISH: PackedScene = preload("res://src/actors/Fish/flying_fish.tscn")

func set_button(_new_value: bool) -> void:
	loadWater()

func loadWater() -> void:
	collision_size = Vector3(plane_size.x, 0.1, plane_size.y)
	water_plane.mesh.size = plane_size
	collision_shape_3d.shape.size = collision_size

func _ready() -> void:
	loadWater()

func player_hits_water(body: CharacterBody3D) -> void:
	if body.find_child("Hitbox"):
		var hitbox: Hitbox = body.find_child("Hitbox") as Hitbox
		hitbox.take_damage(3)

func raise_water(height: float) -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(water_plane, "global_position", Vector3(water_plane.global_position.x, height, water_plane.global_position.z), 5)

func stop_raise_water(_height: float) -> void:
	var tween: Tween = get_tree().create_tween()
	tween.stop()

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		player_hits_water(body)
		return
	
	if body is Floatable:
		print_debug('banaan')
		body.water = self
		body.is_floating = true

func _on_timer_timeout() -> void:
	var plane: PlaneMesh = water_plane.mesh

	var rand: RandomNumberGenerator = RandomNumberGenerator.new()
	rand.randomize()

	var random_x:float = rand.randf_range(-plane.size.x / 2, plane.size.x / 2)
	var random_z:float = rand.randf_range(-plane.size.y / 2, plane.size.y / 2)

	var new_fish: Flying_fish = FLYING_FISH.instantiate() as Flying_fish
	add_child(new_fish)
	new_fish.position = Vector3(random_x, 0, random_z)

	if (random_x > 0):
		new_fish.apply_force_direction(Vector3(randf_range(-4, -7),7,0), player, water_plane, shoot_height)
	else:
		new_fish.apply_force_direction(Vector3(randf_range(4, 7),7,0), player, water_plane, shoot_height)
