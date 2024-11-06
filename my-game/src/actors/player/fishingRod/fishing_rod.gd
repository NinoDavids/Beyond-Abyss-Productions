extends Node3D
class_name FishingRod

const BOBBER: PackedScene = preload("res://src/actors/player/fishingRod/bobber/Bobber.tscn")
const SPRING: PackedScene = preload("res://src/actors/player/fishingRod/line/spring.tscn")
var spring: Node

@export var player: Player

var current_bobber: Bobber
@onready var bobber_mesh: MeshInstance3D = %BobberMesh

@export var cast_strength: float = 5.5
@export var strenght_multiplier: float = 0.5
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_charging: bool = false

func _ready() -> void:
	EventManager.anim_hookable_finished.connect(cancel_hook)


func set_active(active: bool) -> void:
	bobber_mesh.visible = !active

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cast_hook") and !current_bobber:
		animation_player.play("HoldBack")
		is_charging = true
	
	if event.is_action_released("cast_hook") and !current_bobber and is_charging:
		animation_player.play("Cast")
		is_charging = false
	
	if event.is_action_pressed("cancel_hook"):
		animation_player.play("RESET")
		cancel_hook()

func cancel_hook() -> void:
	set_active(false)
	if spring != null:
		spring.queue_free()

func cast_bobber() -> void:
	set_active(true)
	current_bobber = BOBBER.instantiate()
	current_bobber.player = player
	get_tree().current_scene.add_child(current_bobber)
	current_bobber.add_to_group("bobber")
	current_bobber.global_position = bobber_mesh.global_position ## Get the position of the rod
	var direction: Vector3 = -player.player_camera.global_transform.basis.z ## Aims in the direction that the camera is pointing
	direction.y += 1 ## Moves the aim a bit more upwards
	current_bobber.apply_impulse(direction * cast_strength * strenght_multiplier)
	create_rope()

func create_rope() -> void:
	spring = SPRING.instantiate()
	spring.bobber_mesh = bobber_mesh
	add_sibling(spring)
	spring.global_position = current_bobber.global_position
