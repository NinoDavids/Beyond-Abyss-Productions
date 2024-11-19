extends LegacyHookable
class_name RigidHookable

## The [RigidBody3D] acting as the parent of the [LegacyHookable].
@export var body: RigidBody3D
## Set to [code]True[/code] to set the [Object] to move towards the player when [method reel_in] is called.
@export var to_player: bool
@export var maxSpeed: float = 5.5
var canMove: bool = true

## Moves the [Object] towards a direction based on [member to_player].[br]
## If set to [code]True[/code], it moves towards the [Player]. [br]
## Otherwise it moves the [member body] towards the [RigidHookable].

func reel_in() -> void:
	if canMove:
		var direction: Vector3
		if to_player:
			direction = bobber.player.global_position
			direction.y = 0
			body.look_at(Vector3(direction.x, global_position.y, direction.z))
			body.apply_impulse((direction - body.global_position))
			if body.linear_velocity.length() > maxSpeed:
				body.linear_velocity = body.linear_velocity.normalized() * maxSpeed
		else:
			direction = global_position - body.global_position
			body.apply_central_impulse(direction * 1.5)
	else:
		print_debug("No body has been connected to ", name)
