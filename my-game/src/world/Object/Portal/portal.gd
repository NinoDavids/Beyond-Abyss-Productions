class_name Portal
extends Node3D

@export var out_portal: Portal

var used: bool = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if !used:
		out_portal.used = true
		body.global_position = out_portal.global_position

func _on_area_3d_body_exited(body: Node3D) -> void:
	used = false

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	if body is Player:
		body.teleport_shader.show()

func _on_area_3d_2_body_exited(body: Node3D) -> void:
	if body is Player:
		body.teleport_shader.hide()
