class_name BasePuzzlePiece
extends CharacterBody3D

@export var transition_speed: float = 0.5
@export var fall_speed: float = 0.5

var is_moving: bool = false

func move(direction: Vector3) -> void:
	if not is_moving:
		is_moving = true
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(self, ^"global_position:x", global_position.x + direction.x, transition_speed)
		tween.chain().tween_property(self, ^"global_position:z", global_position.z + direction.z, transition_speed)
		tween.tween_property(self, "is_moving", false, 0.0)

func _physics_process(_delta: float) -> void:
	if not is_on_floor() and not is_moving:
		velocity.y -= fall_speed
	
	move_and_slide()
