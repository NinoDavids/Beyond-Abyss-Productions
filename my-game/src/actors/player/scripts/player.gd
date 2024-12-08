extends CharacterBody3D
class_name Player

## TODO: Needs to be changed but it works for now i think.
@onready var main_menu: PackedScene = preload("res://src/UI/MainMenu/MainMenu.tscn")

@onready var head: Node3D = $Head
@onready var player_camera: Camera3D = $Head/PlayerCamera
@onready var fishing_rod: FishingRod = $Head/FishingRod
@onready var raycast: RayCast3D = player_camera.get_node("RayCast3D")
@onready var itemHolder: Node3D = $Head/ItemHolder

@export var SPEED: float = 5.0
const JUMP_VELOCITY: float = 4.5

@export_group("SFX")
@export var audio_player: AudioStreamPlayer3D
@export var footstep_SFX_grass: Array[AudioStream] = []
var is_grass_active: bool = false
@export var footstep_SFX_wood: Array[AudioStream] = []
var is_wood_active: bool = false
@export var foot_step_timer: Timer
@onready var ground_sfx_collider: RayCast3D = %GroundSFXCollider
@onready var pause_menu: InGameMenu = $CanvasLayer2/InGameMenu

var current_bobber: Bobber
var held_Item: RigidBody3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	EventManager.player_respawned.connect(respawn)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quitEditor"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pause_menu.show()
		get_tree().paused = !get_tree().paused
	
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * SettingsManager.settings.sensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y * SettingsManager.settings.sensitivity * SettingsManager.get_inverted_y_float()))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
	if event.is_action_pressed("Drop"):
			if held_Item:
				held_Item.freeze = false
				held_Item.collision_mask = 1
				held_Item = null

	if event.is_action_pressed("Pickup"):
		if held_Item == null:
			if raycast.get_collider():
				var pickups: Array[Node] = get_tree().get_nodes_in_group("Pickups")
				for pickup: RigidBody3D in pickups:
					if(raycast.get_collider() == pickup):
						held_Item = raycast.get_collider()
						held_Item.freeze = true
						held_Item.collision_mask = 2

	if held_Item:
		held_Item.global_transform.origin = itemHolder.global_transform.origin

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if ground_sfx_collider.is_colliding():
		set_footstep_sfx(ground_sfx_collider.get_collider())

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir: Vector2 = Input.get_vector("left", "right", "forward", "backward")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if is_on_floor():
			play_footstep()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func respawn() -> void:
	fishing_rod.cancel_hook()
	print_debug("%s respawned." %name)

## TODO: Should be a cleaner way of doing this...
func set_footstep_sfx(obj: Node) -> void:
	if obj.is_in_group("Grass"):
		is_grass_active = true
		is_wood_active = false
	elif obj.is_in_group("Wood"):
		is_grass_active = false
		is_wood_active = true
	else:
		is_grass_active = false
		is_wood_active = false

func play_footstep() -> void:
	if audio_player and foot_step_timer.is_stopped():
		if is_grass_active:
			audio_player.stream = footstep_SFX_grass.pick_random()
		if is_wood_active:
			audio_player.stream = footstep_SFX_wood.pick_random()
		else: ## Defaults to grass
			audio_player.stream = footstep_SFX_grass.pick_random()
		audio_player.play()
		foot_step_timer.start()
