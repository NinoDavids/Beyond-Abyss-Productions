class_name Portal
extends Node3D

@export var next_water_sprout: WaterSpout
@export var current_water_sprout: WaterSpout

var used: bool = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if next_water_sprout:
		next_water_sprout.active = true
		
	if current_water_sprout:
		current_water_sprout.active = false
