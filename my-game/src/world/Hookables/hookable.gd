extends Area3D
class_name Hookable

var is_hooked: bool = false :
	set(val):
		is_hooked = val
		fire_flies.emitting = !is_hooked
var bobber: Bobber
var player_too_close: bool = false
@onready var fire_flies: CPUParticles3D = $FireFlies

@export_group("Audio and SFX")
@export var hooked_SFX: Array[AudioStream] = []
@export var audio_player: AudioStreamPlayer3D

## A function that gets called as soon as the [Hookable] [member is_hooked] AND the [Player] [kbd]scroll wheel down[/kbd].
func reel_in() -> void:
	pass

func _physics_process(_delta: float) -> void:
	if bobber:
		place_bobber()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reel_hook") and is_hooked:
		reel_in()

func _on_body_entered(body: Node3D) -> void:
	if body is Bobber and not player_too_close:
		play_sfx()
		is_hooked = true
		bobber = body
		place_bobber()
		body.tree_exited.connect(remove_bobber)
	
	if body is Player and is_hooked:
		player_too_close = true
		EventManager.anim_hookable_finished.emit()

## Places the [member bobber] in the center of the [Hookable].
func place_bobber() -> void:
	bobber.set_hooked(global_position)

## Removes the [member bobber] from the [Hookable].
func remove_bobber() -> void:
	is_hooked = false
	bobber = null

func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		player_too_close = false

func play_sfx() -> void:
	if audio_player and hooked_SFX.size() > 0:
		audio_player.stream = hooked_SFX.pick_random()
		audio_player.play()
