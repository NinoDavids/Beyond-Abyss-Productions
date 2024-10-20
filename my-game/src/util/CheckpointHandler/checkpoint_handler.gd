extends Node
class_name CheckpointHandler

@export var checkpoint: Checkpoint

var parent: Node3D
var parent_original_transform: Transform3D

var anim_hookable: AnimationHookable

func _ready() -> void:
	parent = get_parent()
	parent_original_transform = parent.global_transform
	
	if parent.find_child("AnimHookable"):
		anim_hookable = parent.find_child("AnimHookable")
	
	EventManager.checkpoint_touched.connect(save_object)
	EventManager.checkpoint_respawn.connect(load_object)

func save_object(point: Checkpoint) -> void:
	if point == checkpoint : return
	parent_original_transform = parent.global_transform

func load_object(point: Checkpoint) -> void:
	if point != checkpoint : return
	parent.global_transform = parent_original_transform
	
	if anim_hookable != null:
		anim_hookable.animation_player.play("RESET")
		anim_hookable._ready()
