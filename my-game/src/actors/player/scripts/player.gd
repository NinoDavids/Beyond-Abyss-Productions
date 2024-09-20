extends CharacterBody3D
class_name Player

@onready var head: Node3D = $Head
const BOBBER: PackedScene = preload("res://src/actors/player/fishingRod/bobber/Bobber.tscn")
@onready var player_camera: Camera3D = $Head/PlayerCamera
@onready var fishing_rod: FishingRod = $Head/FishingRod

const SPEED: float = 5.0
const JUMP_VELOCITY: float = 4.5

@export var mouse_sens: float = 0.25
@export var cast_strength: float = 5.5

var current_bobber: Bobber

var held_Item: RigidBody3D

@onready var camera := $Head/PlayerCamera
@onready var raycast := camera.get_node("RayCast3D")
@onready var itemHolder := $Head/ItemHolder


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("quitEditor")):
		get_tree().quit();
		
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
	
	if event.is_action_pressed("Drop"):
		if held_Item:
			held_Item.freeze = false
			held_Item.collision_mask = 1
			held_Item = null
	
	if event.is_action_pressed("Pickup"):
		if held_Item == null:
			if raycast.get_collider() && raycast.get_collider().name.contains("Object"):
				held_Item = raycast.get_collider()
				held_Item.freeze = true
				held_Item.collision_mask = 2
			
	if held_Item:
		held_Item.global_transform.origin = itemHolder.global_transform.origin
	
	if event.is_action_pressed("cast_hook") and !current_bobber:
		cast_bobber()
	
	if event.is_action_pressed("cancel_hook"):
		fishing_rod.set_active(false)

func cast_bobber() -> void:
	fishing_rod.set_active(true)
	
	var clone: Bobber = BOBBER.instantiate()
	current_bobber = clone
	get_tree().current_scene.add_child(clone)
	clone.global_position = fishing_rod.global_position ## Get the position of the rod
	var direction: Vector3 = -player_camera.global_transform.basis.z ## Aims in the direction that the camera is pointing
	direction.y += 1 ## Moves the aim a bit more upwards
	clone.apply_impulse(direction * cast_strength)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var input_dir: Vector2 = Input.get_vector("left", "right", "forward", "backward")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
