class_name CannonModel
extends Node3D

signal shoot()

@export var animation_name: StringName
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func start_charge_animation() -> void:
	animation_player.play(animation_name)

func _shoot() -> void:
	shoot.emit() 
