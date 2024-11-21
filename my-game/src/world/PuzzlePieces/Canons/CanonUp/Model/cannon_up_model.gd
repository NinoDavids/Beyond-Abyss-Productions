class_name CannonUpModel
extends Node3D

signal shoot()

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func start_charge_animation() -> void:
	animation_player.play("ShootUp")

func _shoot() -> void:
	shoot.emit()
