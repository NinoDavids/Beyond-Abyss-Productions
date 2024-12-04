extends RigidBody3D

func _ready() -> void:
	add_to_group("Pickups")

func interact() -> void:
	print_debug("test")
