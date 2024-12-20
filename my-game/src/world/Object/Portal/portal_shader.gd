extends Node3D

var is_front_direction: bool:
	set(value):
		is_front_direction = value
		load_portal()

@onready var shader: MeshInstance3D = $PortalShader
@onready var material: ShaderMaterial = shader.get_surface_override_material(0)
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	load_portal()

func load_portal() -> void:
	if is_front_direction:
		material.set_shader_parameter("PORTAL_NORMAL", Vector3(0,0,1))
	else:
		material.set_shader_parameter("PORTAL_NORMAL", Vector3(1,0,0))

func close_portal() -> void:
	animation_player.play("close_portal")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "close_portal":
		self.queue_free()
