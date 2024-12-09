class_name BaseHookable
extends Area3D

@export var parent: BasePuzzlePiece
var bobber: Bobber
@onready var neighbour_cast: RayCast3D = $NeighbourCast
var player_too_close: bool = false

@onready var audio_player: AudioStreamPlayer3D = $AudioPlayer

@export var hooked_sfx: Array[AudioStream]

## The ready function will if the parent is set to null.
func _ready() -> void:
	assert(parent != null)

## The Physics Process function checks if the hookable has a bobber, if it does it sets it to the hookables global position.
#func _physics_process(_delta: float) -> void:
	#if bobber != null:
		#bobber.set_hooked(global_position)

## Registers the "reel_hook" action. If this action is called [b]and[/b] the hookable has a bobber,[/br]
## Then the _reel_in() function is called.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reel_hook") and bobber != null:
		_reel_in()

## Checks if a neighbour is touching a collider, if it is it does nothing.
## If there is no collision, then it moves the parent to the position.
func _reel_in() -> void:
	if neighbour_cast.is_colliding(): return
	
	var direction: Vector3 = parent.global_position.direction_to(global_position).round() * 3 ## Times three currently as the position is 1 off.
	parent.move(direction)

## Checks if the collider is a bobber, if it is [b]and[/b] the bobber is not attached, it sets the bobber in this class.
func _on_body_entered(body: Node3D) -> void:
	if body is Bobber and not player_too_close:
		if not body.is_attached:
			bobber = body
			bobber.set_hooked(global_position)
			place_bobber(body)
			play_hooked_sfx()
	
	if body is Player:
		player_too_close = true
		if bobber != null:
			EventManager.cancel_bobber.emit()

func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		player_too_close = false

func play_hooked_sfx() -> void:
	audio_player.stream = hooked_sfx.pick_random()
	audio_player.pitch_scale = randf_range(.8, 1.2)
	audio_player.play()

func place_bobber(bob: Bobber) -> void:
	bob.reparent(self)
