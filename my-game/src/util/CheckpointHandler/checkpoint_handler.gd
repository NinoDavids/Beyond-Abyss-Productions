extends Node
class_name CheckpointHandler
## The [CheckpointHandler] is a class that works in tandem with [Checkpoint]. 
## It saves the original transform of the parent on save and places it back on load.[br]
## [color=red]This can only be a child to [Node3D]. [/color]


## This is the [Checkpoint] that this class listens to.
@export var checkpoint: Checkpoint

## The parent of the [CheckpointHandler]. [br]
## Automatically gets set in the [method CheckpointHandler.set_parent] function. [br]
## [color=red][b] Must be of type [Node3D] in order to work. [/b][/color]
var parent: Node3D

## This is the original [Transform3D] of the [member CheckpointHandler.parent] node.
var parent_original_transform: Transform3D

## If the [member Checkpointhandler.parent] has a child node of type [AnimationHookable], 
## this variable gets set in the [member CheckpointHandler.set_parent_properties]. [br]
## It's purpose is to append the status of the animation.
var anim_hookable: AnimationHookable

func _ready() -> void:
	set_parent()
	
	if parent != null:
		set_parent_properties()
	
	EventManager.checkpoint_touched.connect(save_object)
	EventManager.checkpoint_respawn.connect(load_object)

## Sets [member CheckpointHandler.parent] according to the parent node. [br]
## If the parent is [b]NOT[/b] of type [Node3D], it pushes an [b]Error[/b]
## and [member CheckpointHandler.parent] remains [code]null[/code]. [br]
## Gets called in the [member _ready()] function.
func set_parent() -> void:
	if get_parent() is not Node3D:
		push_error(self, " is not attached to a Node3D object.")
		return
	parent = get_parent()

## Gets called if [member CheckpointHandler.parent] is not [code]null[/code].
## Sets all variables in relation to the parent.
func set_parent_properties() -> void:
	parent_original_transform = parent.global_transform
	
	if parent.find_child("AnimHookable"):
		anim_hookable = parent.find_child("AnimHookable")

## Gets called when [signal EventManager.checkpoint_touched] gets emitted.
func save_object(point: Checkpoint) -> void:
	if point == checkpoint : return
	parent_original_transform = parent.global_transform

## Gets called when [signal EventManager.checkpoint_respawn] gets emitted.
## Returns the [member CheckpointHandler.parent] transform to [member CheckpointHandler.parent_original_transform].
func load_object(point: Checkpoint) -> void:
	if point != checkpoint : return
	parent.global_transform = parent_original_transform
	
	if anim_hookable != null:
		anim_hookable.animation_player.play("RESET")
		anim_hookable._ready()
