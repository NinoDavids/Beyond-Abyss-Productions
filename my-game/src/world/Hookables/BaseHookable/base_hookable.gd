class_name BaseHookable
extends Area3D

@export var parent: BasePuzzlePiece
var bobber: Bobber
@onready var neighbour_cast: RayCast3D = $NeighbourCast

func _ready() -> void:
	assert(parent != null)

func _physics_process(_delta: float) -> void:
	if bobber != null:
		bobber.set_hooked(global_position)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reel_hook") and bobber != null:
		_reel_in()

func _reel_in() -> void:
	if neighbour_cast.is_colliding(): return
		
	var direction: Vector3 = parent.global_position.direction_to(global_position).round() * 3
	parent.move(direction)


func _on_body_entered(body: Node3D) -> void:
	if body is Bobber:
		if not body.is_attached:
			bobber = body
			bobber.set_hooked(global_position)
