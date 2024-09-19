extends CharacterBody3D
class_name Player

@onready var head: Node3D = $Head

const SPEED: float = 5.0
const JUMP_VELOCITY: float = 4.5

var objectHeld: bool = false
var heldObject: RigidBody3D = null

@export var mouse_sens: float = 0.25

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("quitEditor")):
		get_tree().quit()
		
	if(event.is_action_pressed("interact")):
		interact()
		
	if(event.is_action_pressed("dropItem")):
		dropItem()
		
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func dropItem() -> void:
	if objectHeld and heldObject:		
		$Holder.remove_child(heldObject)
		get_parent().add_child(heldObject) 
		heldObject.set_position(Vector3(position.x + 1,  position.y,  position.z))
		heldObject.freeze = false;
		objectHeld = false
		heldObject = null

func interact() -> void:
	var space_state = get_world_3d().direct_space_state
	var cam = $Head/PlayerCamera
	var mousepos = get_viewport().get_mouse_position()

	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * 20
	var query = PhysicsRayQueryParameters3D.new()
	query.from = origin
	query.to = end
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	
	if result and result.collider:
		if result.collider.name.contains("PickUp"):
			if not objectHeld:
				heldObject = result.collider
				result.collider.get_parent().remove_child(heldObject)
				$Holder.add_child(heldObject)
				heldObject.freeze = true
				heldObject.set_position(Vector3(0, 0, 0))
				objectHeld = true
		elif result.collider.name == "PlaceHere":
			if objectHeld:
					$Holder.remove_child(heldObject)
					result.collider.add_child(heldObject) 
					heldObject.set_position(Vector3(0,  0.75,  0))
					heldObject.freeze = false;
					objectHeld = false
					heldObject = null

func _physics_process(delta: float) -> void:
	# Add gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input direction and handle movement/deceleration.
	var input_dir: Vector2 = Input.get_vector("left", "right", "forward", "backward")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
