extends Node
class_name CheckpointHandler
## The [CheckpointHandler] is a class that works in tandem with [Checkpoint]. 
## It saves the original transform of the parent on save and places it back on load.[br]
## [color=red]This can only be a child to [Node3D]. [/color]


## This is the [Checkpoint] that this class listens to.
@export var checkpoint: Checkpoint

@export var despawnParticles: PackedScene
@export var respawnParticles: PackedScene
@onready var effect_timer: Timer = $EffectTimer

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
	
	EventManager.checkpoint_touched.connect(handle_checkpoint_touched)
	EventManager.checkpoint_respawn.connect(handle_checkpoint_respawn)

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
func handle_checkpoint_touched(point: Checkpoint) -> void:
	if point == checkpoint : return
	save_object()

## Gets called when [signal EventManager.checkpoint_respawn] gets emitted.
## Returns the [member CheckpointHandler.parent] transform to [member CheckpointHandler.parent_original_transform].
func handle_checkpoint_respawn(point: Checkpoint) -> void:
	if point != checkpoint : return
	load_object()

func save_object() -> void:
	parent_original_transform = parent.global_transform

func load_object() -> void:
	parent.global_transform = parent_original_transform
	
	if parent is RigidBody3D:
		parent.linear_velocity = Vector3.ZERO
		parent.angular_velocity = Vector3.ZERO
	
	if anim_hookable != null:
		anim_hookable.is_finished = false
		anim_hookable.animation_player.play("RESET")
		anim_hookable._ready()
	
	for child: Node in parent.get_children():
		if child is LegacyHookable:
			if child.bobber != null:
				child.remove_bobber()
				EventManager.anim_hookable_finished.emit()

func despawn_effect(body: Node3D) -> void:
	var effect: CPUParticles3D = despawnParticles.instantiate() as CPUParticles3D
	effect.finished.connect(destroy_effect)
	body.visible = false
	add_child(effect)
	effect.global_position = body.global_position
	effect.emitting = true

func respawn_effect(body: Node3D) -> void:
	var effect: CPUParticles3D = respawnParticles.instantiate() as CPUParticles3D
	effect.finished.connect(destroy_effect)
	add_child(effect)
	effect.global_position = body.global_position
	effect_timer.wait_time = effect.lifetime
	effect.emitting = true
	effect_timer.start()

func destroy_effect() -> void:
	for child: Node in get_children():
		if child is CPUParticles3D:
			child.queue_free()

func respawn_with_effect() -> void:
	despawn_effect(parent)
	load_object()
	respawn_effect(parent)
	await effect_timer.timeout
	parent.visible = true
