extends Node3D

var is_front_direction: bool:
	set(value):
		is_front_direction = value
		load_portal()

@onready var shader = $PortalShader
@onready var material = shader.get_surface_override_material(0)

func _ready() -> void:
	load_portal()

func load_portal() -> void:
	if is_front_direction:
		material.set_shader_parameter("PORTAL_NORMAL", Vector3(0,0,1))
	else:
		material.set_shader_parameter("PORTAL_NORMAL", Vector3(1,0,0))
