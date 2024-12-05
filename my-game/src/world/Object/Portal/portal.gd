class_name Portal
extends Node3D

@export var puzzle: Puzzle

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CanonProjectile:
		puzzle.next_water_spout()
