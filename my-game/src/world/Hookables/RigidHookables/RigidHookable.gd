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
			direction = bobber.player.global_position
			body.look_at(Vector3(direction.x, global_position.y, direction.z))
			body.apply_impulse((direction - body.global_position))
		else:
			direction = global_position - body.global_position
			body.apply_central_impulse(direction * 2.5)
		
	else:
		print_debug("No body has been connected to ", name)
