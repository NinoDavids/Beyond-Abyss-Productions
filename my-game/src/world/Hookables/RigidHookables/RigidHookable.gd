extends Hookable
class_name RigidHookable

## The [RigidBody3D] acting as the parent of the [Hookable].
@export var body: RigidBody3D
## Set to [code]True[/code] to set the [Object] to move towards the player when [method reel_in] is called.
@export var to_player: bool

## Moves the [Object] towards a direction based on [member to_player].[br]
## If set to [code]True[/code], it moves towards the [Player]. [br]
## Otherwise it moves the [member body] towards the [RigidHookable].
func reel_in() -> void:
	if body:
		var direction: Vector3
		if to_player:
			direction = global_position.direction_to(bobber.player.global_position)
			body.look_at(bobber.player.global_position)
		else:
			direction = body.global_position.direction_to(global_position)
		body.apply_central_impulse(direction)
	else:
		print("No body has been connected to ", name)
