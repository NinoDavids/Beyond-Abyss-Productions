extends Node3D
class_name Bridge
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_blocker: CollisionShape3D = $ROOT/cuboid_153/StaticBody3D/playerBlocker


func progress() -> void:
	print("Opening bridge")
	animation_player.play("KeyAction")



func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	player_blocker.queue_free()
