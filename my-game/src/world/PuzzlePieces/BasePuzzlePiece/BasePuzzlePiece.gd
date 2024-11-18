class_name BasePuzzlePiece
extends CharacterBody3D

@export var transition_speed: float = 0.5
@export var fall_speed: float = 0.5

var is_moving: bool = false

func move(direction: Vector3) -> void:
	if not is_moving:
		is_moving = true
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(self, "global_position", global_position + direction, transition_speed)
		tween.tween_property(self, "is_moving", false, 0.0)

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y -= .5
	
	move_and_slide()
