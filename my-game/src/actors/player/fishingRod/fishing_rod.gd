extends Node3D
class_name FishingRod

@onready var bobber_mesh: MeshInstance3D = $BobberMesh


func set_active(active: bool) -> void:
	bobber_mesh.visible = !active
