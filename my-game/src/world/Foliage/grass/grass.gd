extends Node3D

@export var billBoard: MeshInstance3D
@export var model: MeshInstance3D

func _ready() -> void:
	billBoard.visibility_range_begin = 5
	model.visibility_range_end = 5
	model.visibility_parent = billBoard.get_path()
