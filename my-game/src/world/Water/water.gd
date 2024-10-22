@tool
extends Area3D

@export var plane_size: Vector2 = Vector2(1,1)
var collision_size: Vector3

@onready var water_plane: MeshInstance3D = $WaterPlane
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@export var respawnWater: bool = false : set = set_button

func set_button(new_value: bool) -> void:
	loadWater()
				
func loadWater() -> void:
	collision_size = Vector3(plane_size.x, 0.1, plane_size.y)
	water_plane.mesh.size = plane_size
	collision_shape_3d.shape.size = collision_size
		
func _ready() -> void:
	loadWater()
