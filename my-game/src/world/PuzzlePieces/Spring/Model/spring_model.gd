class_name SpringModel
extends Node3D

signal spring_went_off()

@export var animation_name: StringName = "Spring"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func start_spring() -> void:
	animation_player.play(animation_name)

func push_ball() -> void:
	spring_went_off.emit()
