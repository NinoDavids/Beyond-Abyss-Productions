extends Node3D

@export var animation_player: AnimationPlayer
@export var hookable: Hookable
@export var sewer_cover: AnimatableBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hookable.is_hooked == false && sewer_cover.rotation.x == 0:
		animation_player.play_backwards("Open")
