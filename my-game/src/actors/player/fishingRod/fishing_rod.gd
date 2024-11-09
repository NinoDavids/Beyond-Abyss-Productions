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

@export var show_aim: bool = false
@onready var spawn_point: Node3D = $SpawnPoint

var is_charging: bool = false

func _ready() -> void:
	EventManager.anim_hookable_finished.connect(cancel_hook)

func set_active(active: bool) -> void:
	bobber_mesh.visible = !active

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cast_hook") and !current_bobber:
		animation_player.play("HoldBack")
		toggle_aim()
		is_charging = true
	
	if event.is_action_released("cast_hook") and !current_bobber and is_charging:
		animation_player.play("Cast")
		is_charging = false
	
	if event.is_action_pressed("cancel_hook"):
		cancel_hook()

func cancel_hook() -> void:
	set_active(false)
	animation_player.play("RESET")
	if spring != null:
		spring.queue_free()

func cast_bobber() -> void:
	toggle_aim()
	set_active(true)
	current_bobber = BOBBER.instantiate()
	current_bobber.player = player
	get_tree().current_scene.add_child(current_bobber)
	current_bobber.add_to_group("bobber")
	current_bobber.global_position = bobber_mesh.global_position ## Get the position of the rod
	var direction: Vector3 = -player.player_camera.global_transform.basis.z ## Aims in the direction that the camera is pointing
	direction.y += .75 ## Moves the aim a bit more upwards
	current_bobber.apply_impulse(direction * cast_strength * strenght_multiplier)
	create_rope()

func create_rope() -> void:
	spring = SPRING.instantiate()
	spring.bobber_mesh = bobber_mesh
	add_sibling(spring)
	spring.global_position = current_bobber.global_position

func toggle_aim() -> void:
	show_aim = not show_aim

func _physics_process(_delta: float) -> void:
	if show_aim:
		draw_aim()

func get_front_direction() -> Vector3:
	return -player.player_camera.global_transform.basis.z

func draw_aim() -> void:
	var vel: Vector3 = get_front_direction() as Vector3
	vel += get_front_direction()
	vel.y += .75
	vel *= (cast_strength * strenght_multiplier)

	var tstep: float = 0.05
	var start_pos: Vector3 = spawn_point.global_position
	var g: float = -ProjectSettings.get_setting("physics/3d/default_gravity", 9.8)
	var drag: float = ProjectSettings.get_setting("physics/3d/default_linear_damp", 0.0)
	
	var line_start: Vector3 = start_pos
	var line_end: Vector3 = start_pos
	var colors: Array[Color] = [Color.BLACK, Color.BLUE]
	
	for i: int in range(1,151):
		vel.y += g*tstep
		line_end = line_start
		line_end += vel*tstep
		
		vel *= clampf(1.0 - drag * tstep, 0, 1)
		
		var space_state: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
		var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(line_start, line_end)
		var ray: Dictionary = space_state.intersect_ray(query)
		if not ray.is_empty():
			break
		
		DebugDraw.draw_line_relative(line_start, line_end-line_start, colors[i%2])
		line_start = line_end
